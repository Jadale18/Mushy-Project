extends Control

var basic = 0
var wbutton = 0
export var basicMushBought :PackedScene
export var bigBasicBought :PackedScene
export var whiteButtonBought :PackedScene

func _ready():
	for node in get_tree().get_root().get_child(0).get_child(2).get_children():
		if "Mush" in node.name:
			node.connect("harvest", self, "_on_Harvest")

func _process(delta):
	$Store/BasicBuy.disabled = (basic < 5)
	$Store/BigBasicBuy.disabled = (basic < 20)
	$Store/WhiteButtonBuy.disabled = (wbutton < 20)

	

func _on_Harvest(spore, type):
	if type == 'basic':
		basic += spore
		$SporeCount/BasicSporeCount.text = var2str(basic)
	elif type == 'wbutton':
		wbutton += spore
		$SporeCount/WhiteButtonSporeCount.text = var2str(wbutton)

func _on_Place(cost, type):
	$Store.visible = true
	if type == 'basic':
		basic -= cost
		$SporeCount/BasicSporeCount.text = var2str(basic)
	elif type == 'wbutton':
		wbutton -= cost
		$SporeCount/WhiteButtonSporeCount.text = var2str(wbutton)
	$RotationMessage.visible = false

func _on_BasicBuy_pressed():
	if basic >= 5:
		var new_mushy = basicMushBought.instance()
		get_parent().add_child(new_mushy)
		new_mushy.connect("harvest", self, "_on_Harvest")
		new_mushy.connect("place", self, "_on_Place")
		new_mushy.position = get_global_mouse_position()
		new_mushy.placing = true
		$Store.visible = false
		$RotationMessage.visible = true


func _on_BigBasicBuy_pressed():
	if basic >= 20:
		var new_mushy = bigBasicBought.instance()
		get_parent().add_child(new_mushy)
		new_mushy.connect("harvest", self, "_on_Harvest")
		new_mushy.connect("place", self, "_on_Place")
		new_mushy.position = get_global_mouse_position()
		new_mushy.placing = true
		$Store.visible = false
		$RotationMessage.visible = true


func _on_WhiteButtonBuy_pressed():
	if wbutton >= 20:
		var new_mushy = whiteButtonBought.instance()
		get_parent().add_child(new_mushy)
		new_mushy.connect("harvest", self, "_on_Harvest")
		new_mushy.connect("place", self, "_on_Place")
		new_mushy.position = get_global_mouse_position()
		new_mushy.placing = true
		$Store.visible = false
		$RotationMessage.visible = true
