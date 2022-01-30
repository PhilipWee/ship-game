extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var UserName  = $VBoxContainer/UserName
onready var Password = $VBoxContainer/Password

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_Login_pressed():
	Network.login(UserName.text,Password.text)
	yield(Network,"logged_in")
	Globals.gotoScene(Globals.PATH.MAIN_MENU)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func fill_fake_user(userNum):
	UserName.text = "fakeUser%s@fakeEmail.com" % [userNum]
	Password.text = "myVeryLongVeryFakePassword123456"

func _on_User1_pressed():
	fill_fake_user(1)


func _on_User2_pressed():
	fill_fake_user(2)


func _on_User3_pressed():
	fill_fake_user(3)


func _on_User4_pressed():
	fill_fake_user(4)


func _on_User5_pressed():
	fill_fake_user(5)



