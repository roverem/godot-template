extends Node

var days:Array[Day];

func _ready():
	SignalBus.game_started.connect( _load_game_data )

func _load_game_data():
	days = []
	var json_data = Utils.load_json_data_from_path(Utils.PATH_DAYS_JSON_DATA)
	if json_data == null:
		push_error( "NO JSON DATA" )
	
	for i in len(json_data):
		var day = Day.new()
		var day_data = json_data[str(i+1)]
		day.type = day_data["Type"]
		day.text = day_data["Text"]
		print( day.text )
		days.append( day )
	


func _randomize_days():
	pass
	
func get_current_day(id:int)->Day:
	return days[id]
