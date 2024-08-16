extends CharacterBody2D

var velocidad: int = 500
var _gravity: float

func _ready():
	
	_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	_handle_movement(delta)

func _handle_movement(delta):
	
	if not is_on_floor():
		velocity.y += _gravity * delta
	
	var input_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = input_direction * velocidad
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -velocidad
	
	velocity.normalized()
	move_and_slide()
