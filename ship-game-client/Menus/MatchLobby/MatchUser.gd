extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var PlayerName = $PlayerName

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(player: NakamaRTAPI.UserPresence):
	if (PlayerName):
		PlayerName.text = player.username
	
