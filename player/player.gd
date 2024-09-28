extends CharacterBody2D

const GRAVITY = 1000.0
const WALK_SPEED = 200
const JUMP_HEIGHT = 600


func _physics_process(delta):
	velocity.y += delta * GRAVITY
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x *= 0.8
	if Input.is_action_pressed("ui_up") && is_on_floor():
		velocity.y -= JUMP_HEIGHT
	move_and_slide()
