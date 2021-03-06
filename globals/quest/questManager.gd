extends Node

var QuestList = []

onready var Quest = load("res://globals/quest/quest.gd")
onready var gui = globals.gui

func add_quest(title: String, quantity: int, optional := false):
	QuestList.append(Quest.new(title, quantity, optional))
	print_quests()
	return QuestList.size() - 1

func progress_quest(quest_index: int, value: int):
	QuestList[quest_index].add_progress(value)
	print_quests()

func clear_quests():
	QuestList = []
	print_quests()

func print_quests():
	var inGameUI = gui.get_node("inGameUI")
	if gui and inGameUI:
		inGameUI.updateQuestList()