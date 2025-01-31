extends Node2D

func _on_button_pressed():
	SignalBus.game_started.emit()
