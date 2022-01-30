extends Control

var MatchUser = preload("res://Menus/MatchLobby/MatchUser.tscn")

onready var MatchId = $VBoxContainer/HBoxContainer/MatchId
onready var PlayerContainer = $VBoxContainer/PlayerContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	if !Network.curMatch:
		yield(Network, "match_joined")
	connect_signals()
	re_render()
	
func connect_signals():
	connect("match_presence",Network,"_on_match_presence")

func _on_match_presence():
	re_render()
	
func _on_LeaveGame_pressed():
	if Network.curMatch:
		Network.leaveMatch(Network.curMatch.match_id)
		yield(Network,"match_left")
	Globals.gotoScene(Globals.PATH.MAIN_MENU)

func _on_CopyMatchId_pressed():
	OS.set_clipboard(MatchId.text)

func re_render():
	MatchId.text = Network.curMatch.match_id
	Util.delete_children(PlayerContainer)
	for player in Network.connectedPlayers.values():
		var matchUser = MatchUser.instance()
		PlayerContainer.add_child(matchUser)
		matchUser.init(player)
