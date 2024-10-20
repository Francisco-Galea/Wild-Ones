extends CanvasLayer
class_name GameHud

var player_name_label: Label 
var turn_time_label: Label  

func _ready():
	player_name_label = $VBoxContainer/lblPlayerName
	turn_time_label = $VBoxContainer/lblTurnTime

func update_hud(player_name: String, turn_time: float):
	player_name_label.text = player_name
	turn_time_label.text = "Tiempo restante: " + str(turn_time) + "s"
