extends Control

@onready var lbl_weapon = $VBoxContainer/lblWeapon
@onready var lbl_ammo = $VBoxContainer/lblAmmo

func update_hud(weapon: WeaponStrategy):
	lbl_weapon.text = weapon.get_weapon_description()
	lbl_ammo.text = str(weapon.ammo)
