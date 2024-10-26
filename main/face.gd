extends Node2D
class_name face

var key: int = KEY_Q
var flipped: bool
var goldeness: float = 0
var redness: float = 0
var flipTime = 1
var playing = false
var bloodRate = 15
var goldRate = .5
@export var bottle: oil_bottle
@export var faceGraphics: Node2D
@export var beard :Sprite2D
@export var head :Sprite2D
@export var beardShader : Shader
@export var headShader : Shader
@export var collider: Area2D
@export var sparkles: CPUParticles2D
@export var droplets: CPUParticles2D
@export var godrays: ColorRect
@export var godrayShader : Shader
@export var doveEmitter : CPUParticles2D
var godrayMaterial
var headMaterial
var beardMaterial
var spring = 100
var damp = 15
var velocity = 0
var displacement = 0
var goalRotation
@onready var control = $"../UI"
var dead = false
var won = false
var godrayalpha : float = 0
var ascendRate: float = 15

func _ready():
	headMaterial = ShaderMaterial.new()
	headMaterial.shader = headShader
	head.material = headMaterial
	beardMaterial = ShaderMaterial.new()
	beardMaterial.shader = beardShader
	beard.material = beardMaterial
	godrayMaterial = ShaderMaterial.new()
	godrayMaterial.shader = godrayShader
	godrays.material = godrayMaterial
	control.connect("gameStart",start)

func start():
	playing = true
	redness = 0
	goldeness = 0

func _process(delta):
	if won:
		godrayalpha += delta/3
		godrayMaterial.set_shader_parameter("alpha",godrayalpha)
		faceGraphics.position.y -= ascendRate*delta
		faceGraphics.position.x -=ascendRate*delta*.3
		goalRotation = 0
		spring = 15
		var force = - spring * (displacement - goalRotation) - damp * velocity
		velocity += force * delta
		displacement += velocity * delta
		faceGraphics.rotation = displacement 
		godrayalpha = clamp(godrayalpha,0,0.8)
		
	if dead:
		faceGraphics.position.y -= velocity*delta
		velocity -= 1000*delta
		faceGraphics.rotation += 5*delta
		return
	if playing:
		if flipped:
			redness += delta*bloodRate
			goalRotation = PI
		else:
			redness-= delta*bloodRate
			goalRotation = 0
		redness = clampf(redness,0,100)
		updateShaders()
		var force = - spring * (displacement - goalRotation) - damp * velocity
		velocity += force * delta
		displacement += velocity * delta
		faceGraphics.rotation = displacement 
		if redness == 100:
			die()
		if goldeness == 100:
			win()

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

func onOilHitHead(area):
	print("droplet entered area")
	area.queue_free()
	if faceGraphics.rotation > PI/2:
		goldeness += goldRate
		sparkles.emitting = true
	else:
		droplets.emitting = true
	goldeness = clampf(goldeness,0,100)

func die():
	redness = 100
	updateShaders()
	dead = true
	flipped = false
	velocity = 400
	

func win():
	redness = 0
	goldeness = 100
	updateShaders()
	won = true
	doveEmitter.emitting = true
