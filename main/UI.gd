extends Control
@onready var main = $".."
signal gameStart
var gameStarted = false
var playerCount =0
var maxplayers = 4
var players = []
var keys = []
const TEST_FACE = preload("res://main/test_face.tscn")
@onready var rich_text_label = $VBoxContainer/RichTextLabel

func _input(event: InputEvent):
	if playerCount >= maxplayers:
		return
	if event is InputEventKey and event.is_pressed():
		# Check if the key has already been pressed
		if event.keycode in keys:
			return
		
		print("Instantiate!")
		keys.append(event.keycode)  # Add the key to the list of pressed keys
		
		# Instantiate the player head
		var head = TEST_FACE.instantiate()
		head.key = event.keycode  # Assign the key to the player head (if needed)
		players.append(head)  # Add the player to the list
		
		# Set the position of all players
		for i in range(players.size()):
			var player = players[i]
			player.position.y = 0  # Set y position to 0
			player.position.x = (i +.25- (players.size()-.5)/2 )* 300
		
		playerCount += 1
		rich_text_label.text = "[center]PLAYERS JOINED: " + str(playerCount) + "/4[/center]"
		main.add_child(head)  # Make sure to add the instantiated player to the scene



func _on_play_pressed():
	if playerCount >=2:
		emit_signal("gameStart")
		hide()
