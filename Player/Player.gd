extends CharacterBody2D

var velocidad: int = 200
var gravity: float
var is_turn: bool = false
var has_shot: bool = false
var current_weapon_index: int = 0
var current_weapon: WeaponStrategy
var weapons: Array = [
	GrenadeStrategy.new(),
	GasGrenadeStrategy.new()
]
#De armas solo debe quedar la granada
@onready var health_component: Node = $Health
@onready var projectile_spawn_point: Marker2D = $Pivot/projectile_spawn_point
@onready var deathSound = $DeathSound
@onready var player_name_label: Label = $PlayerName
@onready var weapons_hud: Control = $WeaponsHud

func _ready():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	set_physics_process(true)
	add_to_group("Players")
	current_weapon = weapons[0]  
	player_name_label.text = name
	update_weapons_hud()

func update_weapons_hud():
	weapons_hud.update_hud(current_weapon)

func _physics_process(delta):
	$Pivot.look_at(get_global_mouse_position())
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	if is_turn:
		handle_movement()
		handle_weapon_switch()
	move_and_slide()

func set_turn(turn: bool):
	is_turn = turn 
	if turn:
		has_shot = false
	else:
		stop_movement()

func stop_movement():
	velocity = Vector2.ZERO

func handle_movement():
	var input_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = input_direction * velocidad
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -velocidad
	if Input.is_action_just_pressed("shoot") and not has_shot:
		shoot_projectile()
		has_shot = true
		get_parent().end_turn()

func handle_weapon_switch():
	if Input.is_action_just_pressed("switch_weapon_next"):
		current_weapon_index += 1
		if current_weapon_index >= weapons.size():
			current_weapon_index = 0 
		current_weapon = weapons[current_weapon_index]
		print("Switched to " + current_weapon.get_weapon_description())
		update_weapons_hud()

func collect_weapon(weapon_strategy):
	weapons.append(weapon_strategy)
	current_weapon = weapon_strategy
	print(name + " collected " + weapon_strategy.get_weapon_description())

func shoot_projectile():
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - projectile_spawn_point.global_position).normalized()
	var projectile = current_weapon.shoot(projectile_spawn_point.global_position, direction)
	get_tree().root.add_child(projectile)

func take_damage(amount: int):
	print(name + " took " + str(amount) + " damage!")
	health_component.take_damage(amount)
	if health_component.current_health <= 0:
		_on_died()

func _on_died():
	deathSound.play()
	print(name + " ha muerto!")
	hide()
	set_physics_process(false)
	await deathSound.finished
	queue_free()
	get_parent().player_died(self)
	
func add_ammo_to_weapon(weapon_strategy, amount):
	for weapon in weapons:
		if weapon.get_class() == weapon_strategy.get_class():
			weapon.ammo += amount
			print(name + " ha recibido " + str(amount) + " municiones para " + weapon_strategy.get_weapon_description() + ". Munición actual: " + str(weapon.ammo))

func get_available_weapons() -> Array:
	var available_weapons = []
	for weapon in weapons:
		available_weapons.append(weapon)  # Agrega todas las armas que el jugador tiene
	return available_weapons


