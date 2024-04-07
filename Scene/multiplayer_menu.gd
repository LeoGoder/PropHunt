extends Control

var peer = ENetMultiplayerPeer.new()
@export var player_scene : PackedScene


func _on_host_pressed():
	peer.create_server(1027)
	multiplayer.multiplayer_peer = peer
	var newPlayer = multiplayer.peer_connected.connect(add_player)
	$".".hide()

func _on_join_pressed():
	peer.create_client("127.0.0.1", 1027)
	multiplayer.multiplayer_peer = peer
	$".".hide()
	

func add_player(id) : 
	var player = player_scene.instantiate()
	player.name = str(id)
	get_node('/root/scene_proto').add_child(player)

func exit_game(id): 
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)

func del_player(id):
	rpc("_del_player", id)

@rpc("any_peer", "call_local")
func _del_player(id):
	get_node(str(id)).queue_free()
