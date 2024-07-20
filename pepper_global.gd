extends Node

class Spice:
	var spice_name: String
	var min_value: float
	var max_value: float
	var ammount: int
	func _init(spice_name: String, min_value: float, max_value: float, ammount: int):
		self.spice_name = spice_name
		self.min_value = min_value
		self.max_value = max_value
		self.ammount = ammount

