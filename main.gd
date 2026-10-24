extends Node2D

var health = 30

var deck = Deck.new()
var blocks = {
	"UL" 	: 0,
	"UR"	: 0,
	"DL"	: 0,
	"DR"	: 0
}

var current_turn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Health.text = "Health: %d" % health
		
	##starter deck
	for i in CardLibrary.starter_deck:
		deck.add(Card.new(i))
	deck.reset()
	deck.shuffle()
	
	##first hand
	new_hand()
	
	##first turn blocks
	enemy_turn()
	
	##connect card signal
	for i in range(1,5):
		var node_path = "Card%d" % i
		get_node(node_path).card_selected.connect(on_card_select)
	
	##connect enemy signal
	$Enemy.death.connect(_on_enemy_death)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_hand()-> void:
	for i in range(1,5):
		var node_path = "Card%d" % i
		var c = deck.draw()
		if i <= 2:
			c.flip()
		get_node(node_path).setup(c)
			
func on_card_select(c: Card) -> void:
	reset_blocks()
	update_blocks(current_turn)
	var d = c.stats()
	update_blocks(d)

func enemy_turn()->void:
	current_turn = $Enemy.action(10)
	update_blocks(current_turn)

func update_blocks(d: Dictionary) -> void:
	for i in blocks:
		blocks[i] += d[i]
		var node_path = i + "_Block"
		get_node(node_path).set_as(blocks[i])

func reset_blocks() -> void:
	for i in blocks:
		blocks[i] = 0
		var node_path = i + "_Block"
		get_node(node_path).set_as(blocks[i])

func update_damage() -> void:
	for i in blocks:
		if blocks[i] < 0:
			if i[0] == "U":
				$Enemy.update_health(blocks[i])
			if i[0] == "D":
				health += blocks[i]
				if health <= 0:
					health = 0
					$Health.text = "Health: " + str(health)
					_on_player_death()
				$Health.text = "Health: " + str(health)

func _on_end_turn_pressed() -> void:
	
	for i in range(1,5):
		var node_path = "Card%d" % i
		get_node(node_path).visible = !get_node(node_path).visible
	
	await get_tree().create_timer(1).timeout
	update_damage()
	reset_blocks()

	deck.reset()
	deck.shuffle()
	new_hand()
	
	await get_tree().create_timer(1).timeout
	enemy_turn()

	await get_tree().create_timer(2).timeout
	for i in range(1,5):
		var node_path = "Card%d" % i
		get_node(node_path).visible = !get_node(node_path).visible

func _on_enemy_death() -> void:
	print("win")
	$WinMessage.text = "YOU WIN"
	$WinMessage.visible = !$WinMessage.visible
	$Restart.visible = !$Restart.visible
	Engine.time_scale = 0

func _on_player_death() -> void:
	$WinMessage.text = "YOU LOSE"
	$WinMessage.visible = !$WinMessage.visible
	$Restart.visible = !$Restart.visible
	Engine.time_scale = 0

func _on_restart_pressed() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
