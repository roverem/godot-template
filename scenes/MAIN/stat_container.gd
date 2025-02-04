extends HBoxContainer

@onready var label:Label = $Label


func update_stat(v:int):
	label.text = str(v)
