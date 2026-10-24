
class_name Deck

var perm_deck: Array[Card]
var temp_deck: Array[Card]

func test() -> void:
	print("hey")

func add(c: Card) -> void:
	perm_deck.append(c)

func remove(c: Card) -> void:
	if perm_deck.has(c):
		perm_deck.erase(c)
	else:
		print("remove() error: card not found")
	
func reset() -> void:
	temp_deck.clear()
	for c in perm_deck:
		var new_c = Card.new(c.name)
		temp_deck.append(new_c)
	
func draw() -> Card:
	return temp_deck.pop_front()

func shuffle() -> void:
	temp_deck.shuffle()
