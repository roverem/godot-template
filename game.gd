extends Node2D
@onready var intro = $Intro


func _ready():
	SignalBus.game_started.connect( start_game )


func start_game():
	SceneManager.swap_scenes("res://scenes/MAIN/MainScene.tscn", self, intro);
