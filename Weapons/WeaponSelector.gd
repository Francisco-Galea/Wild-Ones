# Weapons/WeaponSelector.gd
extends Control

signal weapon_selected(weapon: WeaponStrategy)


func _on_button_pressed():
	emit_signal("weapon_selected", BasicGunStrategy.new())
	queue_free
