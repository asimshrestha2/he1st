extends Control

onready var level_complete = $LevelComplete
onready var in_game_ui = $inGameUI
onready var main_menu = $mainMenu

func show_game_ui():
	in_game_ui.visible = true
	level_complete.visible = false
	main_menu.visible = false

func show_level_complete():
	globals.unset_map() # TODO: Move out of gui script (use signal handler?)
	level_complete.set_score(scoreManager.score) # TODO: Remove (local score node instead of global)
	in_game_ui.visible = false
	level_complete.visible = true
	main_menu.visible = false

func show_menu_screen():
	in_game_ui.visible = false
	level_complete.visible = false
	main_menu.visible = true