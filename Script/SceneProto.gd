extends Node3D



func ChangeThePlayer(NewGlobal_position):
	var ID = Global.ID
	match  ID:
		0:
			pass
		1:
			var newPlayer = preload("res://Scene/player_chair.tscn").instantiate()
			add_child(newPlayer)
			newPlayer.global_position = NewGlobal_position
