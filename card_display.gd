extends Node2D

signal card_selected(c: Card)
var card_ref: Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup(c: Card) -> void:
	$UL.text = str(c.up_left)
	$UR.text = str(c.up_right)
	$DL.text = str(c.down_left)
	$DR.text = str(c.down_right)
	$Name.text = c.name
	card_ref = c

func _on_button_pressed() -> void:
	emit_signal("card_selected", card_ref)
