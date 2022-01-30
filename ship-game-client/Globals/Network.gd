extends Node

var client: NakamaClient
var session: NakamaSession
var socket: NakamaSocket
var curMatch: NakamaRTAPI.Match
var connectedPlayers = {}

const HOST_ADDR = "127.0.0.1"
const HOST_PORT = 7350

signal socket_created
signal session_created
signal match_joined
signal match_left
signal match_players_updated
signal logged_in

enum LOGIN_PROVIDER {
	GOOGLE,
	DEVICE
}

func createSession(email, password):
	var device_id = OS.get_unique_id()
	session = yield(client.authenticate_email_async(email,password), "completed")
	if session.is_exception():
		print("An error occurred: %s" % session)
		return
	emit_signal("session_created")
	

func createSocket():
	socket = Nakama.create_socket_from(client)
	var connected : NakamaAsyncResult = yield(socket.connect_async(session), "completed")
	if connected.is_exception():
		print("An error occurred: %s" % connected)
		return
	emit_signal("socket_created")

func createClient():
	client = Nakama.create_client("defaultkey", HOST_ADDR, HOST_PORT, "http")
	
func _on_match_presence(p_presence: NakamaRTAPI.MatchPresenceEvent):
	for p in p_presence.joins:
		connectedPlayers[p.user_id] = p
	for p in p_presence.leaves:
		connectedPlayers.erase(p.user_id)
	emit_signal("match_players_updated")

func connectMatchSignal():
	socket.connect("received_match_presence", self, "_on_match_presence")

func connectToServer():
	createClient()
	

func login(email,password):
	createSession(email,password)
	yield(self,"session_created")
	createSocket()
	yield(self,"socket_created")
	connectMatchSignal()
	emit_signal("logged_in")

func _ready():
	connectToServer()
	
func createMatch():
	curMatch = yield(socket.create_match_async(), "completed")
	if curMatch.is_exception():
		print("An error occurred: %s" % curMatch)
		return
	emit_signal("match_joined")

func joinMatch(matchId):
	curMatch = yield(socket.join_match_async(matchId), "completed")
	if curMatch.is_exception():
		print("An error occurred: %s" % curMatch)
		return
	emit_signal("match_joined")
	
func leaveMatch(matchId):
	if !curMatch:
		return
	yield(socket.leave_match_async(matchId),"completed")
	emit_signal("match_left")
	
