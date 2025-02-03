extends Node

var day_ids:Array[int];
var days_by_id:Array[Day];
var choices:Dictionary
var unfiltered_choices:Array[Choice]

func _ready():
	SignalBus.game_started.connect( _load_game_data )

func _load_game_data():
	day_ids = []
	days_by_id = []
	choices = {}
	
	var json_data = Utils.load_json_data_from_path(Utils.PATH_DAYS_JSON_DATA)
	if json_data == null:
		push_error( "NO JSON DATA" )
	
	#FIND ALL DAY IDS
	for i in len(json_data):
		var day_data = json_data[i]
		var day_id:int = day_data["DayID"]
		if not day_id in day_ids:
			day_ids.append(day_id)
		
	unfiltered_choices = []
	var n = 0
	#FILTER CHOICES
	for day_data in json_data:
		var type = day_data["ActionType"];
		if type == "CHOICE_A" or type == "CHOICE_B":
			var choice:Choice = Choice.new()
			choice.day_id = 		day_data["DayID"]
			choice.choice_id = 		day_data["ChoiceID"]
			choice.text = 			day_data["Text"]
			choice.option_id = 		day_data["ActionType"] #"CHOICE_A" || "CHOICE_B"
			choice.value = get_value_from_json(day_data["Value"])
			#choices[ choice.choice_id ][choice.option_id] = choice 
			unfiltered_choices.append(choice)
			json_data[n] = null
		n += 1
	
	#NOW THAT WE HAVE ALL IDS. CREATE A DAY WITH ALL ACTIONS ON THAT DAY
	for d in day_ids:
		var day = Day.new()
		day.actions = get_actions_in_day(json_data, d)
		day.current_action = 0
		days_by_id.append( day )

func get_choices_by_id(id:int)->Array[Choice]:
	var result:Array[Choice] = []
	for c in unfiltered_choices:
		if c.choice_id == id:
			result.append(c)
	return result

func get_actions_in_day(json_data, day_id)->Array[Action]:
	var result:Array[Action] = []
	for i in json_data:
		var day_data = i
		if day_data == null:
			continue
		if ( day_data["DayID"] == day_id ):
			var action:Action = Action.new()
			action.text = day_data["Text"]
			action.day_id = day_data["DayID"]
			action.type = day_data["ActionType"]
			action.value =  get_value_from_json(day_data["Value"] if day_data["Value"] != null else "[0,0,0]")
			action.is_last = day_data["IsLast"]
			action.was_shown = false
			if action.type == "CHOICE":
				action.choice_id = day_data["ChoiceID"]
				var choice_obj = get_choices_by_id(action.choice_id)
				action.choice_A = choice_obj[0]
				action.choice_B = choice_obj[1]
			result.append(action)
	return result

func get_value_from_json( value:String )->Array[int]:
	var result:Array[int] = [0,0,0];
	#TODO
	print(value)
	return result
	
func _randomize_days():
	pass
	
func get_current_day(id:int)->Day:
	return days_by_id[id % len(days_by_id)]
