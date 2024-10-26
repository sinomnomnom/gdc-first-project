extends Node2D
class_name oil_bottle

var pouring: bool = false
var spring = 100
var damp = 15
var velocity = 0
var displacement = 0
var goalRotation
@export var oilemitter: GPUParticles2D
@export var spout: Node2D
@export var sprite: Sprite2D
@export var oil: String
var time_since_last_spawn: float = 0
var spawn_delay: float = .1

func _process(delta):
	time_since_last_spawn += delta
	if pouring:
		goalRotation = PI * 2 / 3
		if time_since_last_spawn >= spawn_delay:
			spawn_droplet()
			time_since_last_spawn = 0.0
	else:
		goalRotation = 0
	
	var force = -spring * (displacement - goalRotation) - damp * velocity
	velocity += force * delta
	displacement += velocity * delta
	sprite.rotation = displacement

func spawn_droplet():
	var drop = load(oil)
	var droplet_instance = drop.instantiate() 
	add_child(droplet_instance)
	droplet_instance.global_position = spout.global_position 
	 
	print("drip")
