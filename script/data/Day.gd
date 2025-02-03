extends Node
class_name  Day

var actions:Array[Action]
var current_action:int


func get_current_action()->Action:
	return actions[current_action]

func advance_action():
	current_action += 1
