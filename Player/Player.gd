extends CharacterBody2D

@onready var health_component: Node = $Health
@onready var projectile_spawn_point: Marker2D = $Pivot/projectile_spawn_point
@onready var deathSound = $DeathSound
@onready var player_name_label: Label = $PlayerName

var turn_manager: TurnManager
var player_name: String
var velocidad: int = 100
var gravity: float
var jump_velocity: int = -200
var is_dead: bool = false
var has_shot: bool = false
var current_weapon_index: int = 0
var current_weapon: WeaponStrategy
var weapons: Array = [
	GrenadeStrategy.new(),
]

signal player_died(player)

func _ready():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	set_physics_process(true)
	add_to_group("Players")
	set_current_weapon(0)
	player_name_label.text = name
	player_name = name
	set_process_input(false)  

func _physics_process(delta):
	$Pivot.look_at(get_global_mouse_position())
	handle_gravity(delta)
	move_and_slide()

func _input(event):
	if event.is_action_pressed("shoot") and not has_shot:
		shoot_projectile()
		has_shot = true
	elif event.is_action_pressed("switch_weapon_next"):
		handle_weapon_switch()

func start_turn():
	set_process_input(true)  

func end_turn():
	set_process_input(false)  
	has_shot = false
	stop_movement()

func stop_movement():
	velocity = Vector2.ZERO

func handle_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

func _process(_delta):
	if is_processing_input():
		handle_movement()

func handle_movement():
	var input_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = input_direction * velocidad
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	move_and_slide()

func handle_weapon_switch():
	current_weapon_index = (current_weapon_index + 1) % weapons.size()
	set_current_weapon(current_weapon_index)

func set_current_weapon(index: int):
	current_weapon = weapons[index]

func collect_weapon(weapon_strategy: WeaponStrategy):
	if not has_weapon(weapon_strategy):
		weapons.append(weapon_strategy)
		set_current_weapon(weapons.size() - 1)  

func shoot_projectile():
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - projectile_spawn_point.global_position).normalized()
	var projectile = current_weapon.shoot(projectile_spawn_point.global_position, direction)
	get_tree().root.add_child(projectile)

func take_damage(amount: int):
	health_component.take_damage(amount)
	if health_component.current_health <= 0:
		_on_died()

func _on_died():
	is_dead = true
	deathSound.play()
	hide()
	await deathSound.finished
	emit_signal("player_died", self)  
	queue_free()

func get_current_weapon() -> WeaponStrategy:
	return current_weapon

func set_turn_manager(manager: TurnManager):
	turn_manager = manager

func has_weapon(weapon_strategy: WeaponStrategy) -> bool:
	for weapon in weapons:
		if weapon.get_script() == weapon_strategy.get_script():
			return true
	return false
