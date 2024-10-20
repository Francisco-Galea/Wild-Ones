extends Control

@onready var lblWeapon = $VBoxContainer/lblWeapon
@onready var lblAmmo = $VBoxContainer/lblAmmo

func update_weapon_info(weapon: WeaponStrategy):
	lblWeapon.text = weapon.get_weapon_description()
	lblAmmo.text = str(weapon.ammo)

