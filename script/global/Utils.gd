extends Node

var PATH_DAYS_JSON_DATA = "res://assets/JSON/Game Data - DaysData.json"
var PATH_PLAYER_JSON_DATA = "res://assets/JSON/Game Data - PlayerData.json"


func load_json_data_from_path(path: String):
	var file_string = FileAccess.get_file_as_string(path)
	var json_data
	if file_string != null:
		json_data = JSON.parse_string(file_string)
	else:
		push_warning("FAILED GET FILE AS STRING ON " + path)
		
	if json_data == null:
		push_error("FAILED JSON PARSING ON " + path)
		
	return json_data
