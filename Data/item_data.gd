extends Resource
class_name ItemData

@export var sprite: Texture2D
enum TypeItem {GUN, EQUIPMENT, BULLET}
@export var type_item: TypeItem

func get_intance() -> Node:
	return Node.new()