extends StaticBody2D

var offset
# Called when the node enters the scene tree for the first time.
func _ready():
	offset = randf_range(1,5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += sin((Time.get_ticks_msec()/500)+offset)
