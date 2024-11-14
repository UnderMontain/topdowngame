extends Node2D
class_name HandleAtack

@onready var player: PlayerLogic
@onready var gun_equiped: GunEquiped = $GunEquiped

#Setup equiped gun
var gun_offset: Vector2 = Vector2(20, 0)
var _is_fliped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if gun_equiped.gun != null:
		var dir = player.direction_mouse
		var angle_to_mouse = dir.angle()
		
		gun_equiped.rotation = angle_to_mouse
		gun_equiped.position = position + gun_offset.rotated(angle_to_mouse)
		if dir.x < 0 and !_is_fliped:
			gun_equiped._flip_sprite()
			_is_fliped = true
		elif dir.x > 0 and _is_fliped:
			gun_equiped._flip_sprite()
			_is_fliped = false

func _set_gun(_gun: Gun, _player: Node2D) -> void:
	if gun_equiped != null:
		gun_equiped._unequiped()
		gun_equiped._equiped(_gun)
	else :
		gun_equiped._equiped(_gun)
	gun_equiped.position =  gun_offset
	self.player = player
	
func realeseAttack() -> void:
	gun_equiped.execute(player.direction_mouse)
