extends Node

var client: NakamaClient
var session: NakamaSession
var socket: NakamaSocket
var curMatch: NakamaRTAPI.Match

const HOST_ADDR = "127.0.0.1"
const HOST_PORT = 7350


func createSessionAndSocket():
	var device_id = OS.get_unique_id()	
	session = yield(client.authenticate_device_async(device_id), "completed")
	if session.is_exception():
		print("An error occurred: %s" % session)
		return
	socket = Nakama.create_socket_from(client)
	var connected : NakamaAsyncResult = yield(socket.connect_async(session), "completed")
	if connected.is_exception():
		print("An error occurred: %s" % connected)
		return

func createClient():
	client = Nakama.create_client("defaultkey", HOST_ADDR, HOST_PORT, "http")

func connectToServer():
	createClient()
	createSessionAndSocket()

func _ready():
	connectToServer()
	
func createMatch():
	curMatch = yield(socket.create_match_async(), "completed")
	if curMatch.is_exception():
		print("An error occurred: %s" % curMatch)
		return

func joinMatch(matchId):
	curMatch = yield(socket.join_match_async(matchId), "completed")
	if curMatch.is_exception():
		print("An error occurred: %s" % curMatch)
		return
