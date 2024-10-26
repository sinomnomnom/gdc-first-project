extends Area2D
class_name droplet
var speed: int = 100
var timer: float = 0
var lifetime: int = 5
func _process(delta):
	timer += delta
	if timer > lifetime:
		self.queue_free()
	position.y += speed*delta
