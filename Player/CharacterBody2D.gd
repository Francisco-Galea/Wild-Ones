extends CharacterBody2D

var velocidad: int = 500
var _gravity: float
var projectile_scene: PackedScene = preload("res://Weapon/Projectile.tscn")

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
	
	if Input.is_action_just_pressed("shoot"):  
		_shoot_projectile()
		
	velocity.normalized()
	move_and_slide()

func _shoot_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.position = position
	var mouse_position = get_global_mouse_position()
	
	#Direccion del proyectil
	var direction = (mouse_position - global_position).normalized()
	projectile.position = position + direction * 100
	
	#Velocidad del proyectil
	projectile.velocity = direction * 900 
	get_parent().add_child(projectile)

