extends CharacterBody2D

var velocidad: int = 100
var gravity: float
var is_turn: bool = false
var has_shot: bool = false

@onready var health_component: Node = $Health
var current_weapon: WeaponStrategy

var weapons: Array = [
	BasicGunStrategy.new(),
	GrenadeStrategy.new(),
]

func _ready():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	set_physics_process(true)
	add_to_group("Players")
	health_component.connect("died", Callable(self, "_on_died"))
	current_weapon = weapons[0]  # Set default weapon to BasicGun
	$Area2D.connect("body_entered", Callable(self, "_on_area_2d_body_entered"))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	if is_turn:
		handle_movement(delta)
		handle_weapon_switch()

	move_and_slide()

func handle_movement(delta):
	var input_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = input_direction * velocidad


	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -velocidad

	if Input.is_action_just_pressed("shoot") and not has_shot:
		shoot_projectile()
		has_shot = true
		get_parent().end_turn()

func handle_weapon_switch():
	if Input.is_action_just_pressed("switch_weapon_1"):
		current_weapon = weapons[0]
		print("Switched to " + current_weapon.get_name())
	elif Input.is_action_just_pressed("switch_weapon_2"):
		current_weapon = weapons[1]
		print("Switched to " + current_weapon.get_name())

func shoot_projectile():
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	var projectile = current_weapon.shoot(global_position, direction)
	get_tree().root.add_child(projectile)

func set_turn(turn: bool):
	is_turn = turn 
	if turn:
		has_shot = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("bullets"):
		take_damage(body.get_damage())
		body.queue_free()

func take_damage(amount: int):
	print(name + " took " + str(amount) + " damage!")
	health_component.take_damage(amount)
	if health_component.current_health <= 0:
		_on_died()

func _on_died():
	print(name + " ha muerto!")
	set_physics_process(false)
	queue_free()
	get_parent().player_died(self)
