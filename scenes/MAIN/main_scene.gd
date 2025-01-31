extends Node2D

@onready var rich_text_label = %RichTextLabel
@onready var stateChart = %StateChart;

func _ready():
	var json_data = Utils.load_json_data_from_path(Utils.PATH_DAYS_JSON_DATA)
	if json_data != null:
		rich_text_label.text = JSON.stringify(json_data)
