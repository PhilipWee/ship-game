extends Control

func _on_CreateGame_pressed():
	Network.createMatch()
	Globals.gotoScene(Globals.PATH.MATCH_LOBBY)


func _on_JoinGame_pressed():
	Globals.gotoScene(Globals.PATH.JOIN_GAME)
