extends Node2D
class_name face

var key: int = KEY_Q
var flipped: bool
var goldeness: float = 0
var redness: float = 0
var flipTime = 1
var playing = false
var bloodRate = 10
var goldRate = 4
@export var beard :Sprite2D
@export var head :Sprite2D
@export var beardShader : Shader
@export var headShader : Shader
var headMaterial
var beardMaterial
var spring = 30
var damp = 5
var velocity = 0
var displacement = 0
var goalRotation
@onready var control = $"../UI"

func _ready():
	headMaterial = ShaderMaterial.new()
	headMaterial.shader = headShader
	head.material = headMaterial
	beardMaterial = ShaderMaterial.new()
	beardMaterial.shader = beardShader
	beard.material = beardMaterial
	control.connect("gameStart",start)

func start():
	playing = true
	redness = 0
	goldeness = 0

func _process(delta):
	if playing:
		if flipped:
			redness += bloodRate*delta
			goldeness += goldRate*delta
			goalRotation = PI
		else:
			redness -= bloodRate*delta
			goalRotation = 0
		goldeness = clampf(goldeness,0,100)
		redness = clampf(redness,0,100)
		updateShaders()
		var force = - spring * (displacement - goalRotation) - damp * velocity
		velocity += force * delta
		displacement += velocity * delta
		rotation = displacement 

func updateShaders():
	beardMaterial.set_shader_parameter("goldeness", goldeness)
	headMaterial.set_shader_parameter("redness", redness)

func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			key:
				flipped = true
	if event is InputEventKey and event.is_released():
		match event.keycode:
			key:
				flipped = false
