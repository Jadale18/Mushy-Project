extends Node2D

var base_scene = "res://scenes/Locations/Base.tscn"
var store_count_scene = "res://scenes/UI/CountAndStore.tscn"
var player_scene = "res://scenes/characters/Player.tscn"

var node : Node2D


func _ready():
	$MainMenu.connect("start_button", self, "_on_Start_button")
	
func start_game():
	$MainMenu.queue_free()
	node = load(base_scene).instance()
	add_child(node)
	$CanvasLayer.add_child(load(store_count_scene).instance())
	var player = load(player_scene).instance()
	player.position = Vector2(450,350)
	add_child(player)

func _on_Start_button():
	start_game()
