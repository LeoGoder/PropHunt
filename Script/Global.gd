extends Node

var global_position
var global_rotation
var ID
	
func ChangeThePlayer(NewGlobal_position):
	var ID = Global.ID
	match  ID:
		0:
			pass
		1:
			var newPlayer = preload("res://Scene/salon_chair_player.tscn").instantiate()
			add_child(newPlayer)
			newPlayer.global_position = NewGlobal_position
		2:
			var newPlayer = preload("res://Scene/player_green_book.tscn").instantiate()
			add_child(newPlayer)
			newPlayer.global_position = NewGlobal_position
