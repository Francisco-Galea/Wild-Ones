extends CanvasLayer
class_name GameHud

@onready var player_name_label: Label = $VBoxContainer/lblPlayerName
@onready var turn_time_label: Label = $VBoxContainer/lblTurnTime
@onready var weapon_name_label: Label = $VBoxContainerWeapon/lblWeaponName

func update_hud(player_name: String, turn_time: float, weapon: WeaponStrategy):
	player_name_label.text = "Turno de: " + player_name
	turn_time_label.text = "Tiempo restante: " + str(int(turn_time)) + "s"
	weapon_name_label.text = "Arma: " + weapon.get_weapon_description()

