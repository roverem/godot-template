extends Node2D

@onready var rich_text_label = %RichTextLabel
@onready var stateChart = %StateChart;

func _ready():
	var day = GameData.get_current_day(randi_range(0, 20))
	rich_text_label.text = day.text


func _on_action_state_entered():
	var randi = randi_range(0, 20)
	var day = GameData.get_current_day(randi)
	print( randi, day.text )
	rich_text_label.text = day.text
