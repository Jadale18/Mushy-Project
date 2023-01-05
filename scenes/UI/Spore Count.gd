extends Label

var count = 0

func _ready():
	for node in get_tree().get_root().get_child(0).get_children():
		if "BasicMush" in node.name:
			node.connect("harvest", self, "_on_Harvest")

func _on_Harvest(spore):
	count += spore
	text = 'Spores = ' + var2str(count)
