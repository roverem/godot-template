extends Node2D

@onready var rich_text_label = %RichTextLabel
@onready var stateChart = %StateChart;

var current_day_id:int = -1
var current_day:Day

func _on_start_day_state_entered():
	_clean_screen()
	current_day_id += 1
	current_day = GameData.get_current_day(current_day_id)
	current_day.current_action = 0
	%DayLabel.text = "Day " + str(current_day_id + 1)

func _on_check_current_state_entered():
	_clean_screen()
	var current_action = current_day.get_current_action()
	if not current_action.was_shown:
		show_current_action()
	else:
		if current_action.is_last:
			%StateChart.send_event("start_day")
		else:
			current_day.advance_action()
			check_next_action()

func show_current_action():
	var current_action = current_day.get_current_action()
	current_action.was_shown = true
	rich_text_label.text = current_action.text
	%StateChart.send_event(current_action.type)

func check_next_action():
	%StateChart.send_event("check_next")

func _on_button_button_up():
	check_next_action()

func _on_read_text_state_entered():
	var current_action = current_day.get_current_action()
	rich_text_label.text = current_action.text
	%AdvanceDayButton.visible = true


func _on_choice_a_button_up():
	_clean_screen()
	var current_action = current_day.get_current_action()
	current_action.choice_selected = current_action.choice_A
	%StateChart.send_event("CHOICE_A")

func _on_choice_b_button_up():
	_clean_screen()
	var current_action = current_day.get_current_action()
	current_action.choice_selected = current_action.choice_B
	%StateChart.send_event("CHOICE_B")


func _on_present_choice_state_entered():
	%Choice_A.visible = true
	%Choice_B.visible = true

func _clean_screen():
	%AdvanceDayButton.visible = false
	%Choice_A.visible = false
	%Choice_B.visible = false

func _on_show_outcome_state_entered():
	var current_action = current_day.get_current_action()
	rich_text_label.text = current_action.choice_selected.text


func _on_modify_stat_state_entered():
	rich_text_label.text = "STAT MODIFIED"
