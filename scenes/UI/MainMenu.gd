extends Control

signal start_button

func _on_Button_pressed():
	emit_signal("start_button")
