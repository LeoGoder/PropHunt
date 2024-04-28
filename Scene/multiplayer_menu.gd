extends Control

var peer = ENetMultiplayerPeer.new()



func _on_host_pressed():
	Global.Host_or_join = 0
	$HBoxContainer.hide()
	$Roles_Choice.show()

func _on_join_pressed():
	Global.Host_or_join = 1
	$HBoxContainer.hide()
	$Roles_Choice.show()
