extends Node2D

var health = 30
signal death

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = str(health)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func action(power: int = 0) -> Dictionary:
	var a = [0,0,0,0]
	var p = power
	
	for i in range(p):
		var r = randi_range(0, p)
		a[randi_range(0,3)] += r
		p -= r
		
	var d = {
	"UL" 	: a[0],
	"UR"	: a[1],
	"DL"	: -a[2],
	"DR"	: -a[3]
	}
	return d

func update_health(i: int)-> void:
	health += i
	if health <= 0:
		health = 0
		##emit_signal("death")
	$Label.text = str(health)
