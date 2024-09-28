extends CharacterBody2D

var velocidad: int = 500
var gravity: float
var projectile_scene: PackedScene = preload("res://Weapon/Projectile.tscn")
var is_turn: bool = false

@onready var health_component: Node = $Health

func _ready():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	set_physics_process(true) 
	add_to_group("Players")
	health_component.connect("died", Callable(self, "_on_died"))

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	
	if is_turn:
		handle_movement()
	
	move_and_slide()

func handle_movement():
	var input_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = input_direction * velocidad
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -velocidad
	
	if Input.is_action_just_pressed("shoot"):
		shoot_projectile()

func shoot_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.position = position
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	projectile.position = position + direction * 100
	projectile.velocity = direction * 900
	get_parent().add_child(projectile)

func set_turn(turn: bool):
	is_turn = turn 

func _on_area_2d_body_entered(body):
	if body.is_in_group("bullets"):
		health_component.take_damage(10)  
		body.queue_free()
		
		
func _on_died():
	print(name + " ha muerto!")
	set_physics_process(false)
	queue_free()
	get_parent().player_died(self)
