extends Label

var count = 0
export var mushybought :PackedScene

func _ready():
	for node in get_tree().get_root().get_child(0).get_children():
		if "BasicMush" in node.name:
			node.connect("harvest", self, "_on_Harvest")

func _on_Harvest(spore):
	count += spore
	text = 'Spores = ' + var2str(count)


func _on_Button_pressed():
	if count >= 5:
		count -= 5
		text = 'Spores = ' + var2str(count)
		var new_mushy = mushybought.instance()
		get_parent().add_child(new_mushy)
		new_mushy.position = get_global_mouse_position()
		new_mushy.placing = true
		
		
