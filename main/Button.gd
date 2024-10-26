extends Button
@onready var ui = $"/root/Node2D/UI"
@onready var node_2d = $"/root/Node2D"
@onready var button = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	for child in node_2d.get_children():
		if child is face:
			child.queue_free()
	button.hide()
	ui.show()
	ui.reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
