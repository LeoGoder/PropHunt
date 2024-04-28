extends Control

var peer = ENetMultiplayerPeer.new()
const Hideur = preload("res://Scene/Hideur.tscn")
const Hunter = preload("res://Scene/hunter_cam.tscn")
const Port = 9999

func _physics_process(delta):
	if Global.Host_or_join == 0:
		$VBoxContainer/IPAdress.hide()
	if Global.Host_or_join == 1:
		$VBoxContainer/IPAdress.show()

func _on_hunter_pressed():
	if Global.Host_or_join == 0:
		Global.roleID = 0
		peer.create_server(Port)
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(add_player)
		add_player(multiplayer.get_unique_id())
		$".".hide()
	if Global.Host_or_join == 1:
		Global.roleID = 0
		peer.create_client("127.0.0.1", Port)
		multiplayer.multiplayer_peer = peer


func _on_hideur_pressed():
	if Global.Host_or_join == 0:
		Global.roleID = 1
		peer.create_server(Port)
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(add_player)
		add_player(multiplayer.get_unique_id())
		$".".hide()
	if Global.Host_or_join == 1:
		Global.roleID = 1
		peer.create_client("127.0.0.1", Port)
		multiplayer.multiplayer_peer = peer


func add_player(peer_id):
	if Global.roleID == 0:
		var player = Hunter.instantiate()
		player.name = str(peer_id)
		add_child(player)
	if Global.roleID == 1:
		var player = Hideur.instantiate()
		player.name = str(peer_id)
		add_child(player)
