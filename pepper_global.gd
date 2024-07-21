extends Node

var shelves:Node2D

var money: int = 50

var canChangeScene:bool = false

var json_as_text = FileAccess.get_file_as_string("res://intro.json")
var dialogs:Dictionary = JSON.parse_string(json_as_text)

var number_of_unlocked_spices: int = 0
