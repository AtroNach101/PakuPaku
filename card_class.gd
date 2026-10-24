
class_name Card

var name
var up_left
var up_right
var down_left
var down_right

func _init(n: String = "default") -> void:
	name = n
	var stats = CardLibrary.basics.get(name)
	up_left = stats[0]
	up_right = stats[1]
	down_left = stats[2]
	down_right = stats[3]

func flip() -> void:
	var temp 
	temp = up_left
	up_left = up_right
	up_right = temp
	temp = down_left
	down_left = down_right
	down_right = temp
	
func stats() -> Dictionary:
	var d = {
		"UL" 	: up_left,
		"UR"	: up_right,
		"DL"	: down_left,
		"DR"	: down_right
	}
	return d
