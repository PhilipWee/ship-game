extends Node

const PATH = {
	"MAIN_MENU" : "res://Menus/MainMenu/MainMenu.tscn",
	"JOIN_GAME" : "res://Menus/JoinGame/JoinGame.tscn",
	"MATCH_LOBBY" : "res://Menus/MatchLobby/MatchLobby.tscn"
}

func gotoScene(path):
	#TODO: Handle deferred loading or whatever nonsense
	get_tree().change_scene(path)
