extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var MatchID = $VBoxContainer/MatchID

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	Globals.gotoScene(Globals.PATH.MAIN_MENU)


func _on_JoinGame_pressed():
	var matchId = MatchID.text
	Network.joinMatch(matchId)
	yield(Network,"match_joined")
	Globals.gotoScene(Globals.PATH.MATCH_LOBBY)
