extends Control

var basic = 0
var wbutton = 0

func _ready():
	for node in get_tree().get_root().get_child(0).get_children():
		if "Mush" in node.name:
			node.connect("harvest", self, "_on_Harvest")


func _on_Harvest(spore, type):
	if type == 'basic':
		basic += spore
		$GridContainer/BasicSporeCount.text = var2str(basic)
	elif type == 'wbutton':
		wbutton += spore
		$GridContainer/WhiteButtonSporeCount.text = var2str(wbutton)
