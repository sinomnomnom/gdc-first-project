extends Control
@onready var main = $".."
signal gameStart
var gameStarted = false
var playerCount =0
var maxplayers = 4
var players = []
var keys = []
const TEST_FACE = preload("res://main/test_face.tscn")
@onready var rich_text_label =$Panel/VBoxContainer/RichTextLabel
@onready var popup_panel = $Panel/VBoxContainer/PopupPanel

func _input(event: InputEvent):
	popup_panel.hide()
	if playerCount >= maxplayers:
		return
	if event is InputEventKey and event.is_pressed():
		if event.keycode in keys:
			return
		print("Instantiate!")
		keys.append(event.keycode)
		var head = TEST_FACE.instantiate()
		head.key = event.keycode
		players.append(head)
		for i in range(players.size()):
			var player = players[i]
			player.position.y = 100
			player.position.x = (i +.25- (players.size()-.5)/2 )* 300
		playerCount += 1
		rich_text_label.text = "[center]PLAYERS JOINED: " + str(playerCount) + "/4[/center]\n[center][wave]Press any key to join[/wave][/center]"
		main.add_child(head)

func _on_play_pressed():
	if playerCount >=2:
		emit_signal("gameStart")
		hide()

func _on_credits_pressed():
	popup_panel.show()
