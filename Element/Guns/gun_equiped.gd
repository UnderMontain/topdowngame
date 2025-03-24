extends Node2D
class_name GunEquiped

var gun: Gun
@onready var sprite: Sprite2D = $Sprite
@onready var fire_rate: Timer = $FireRate
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func execute(_direction:Vector2) -> void:
	if gun:
		gun.execute(_direction, global_position)
	
func _flip_sprite()-> void:
	sprite.flip_v = !sprite.flip_v

func _ready() -> void:
	pass

func _equiped(_gun:Gun) -> void:
	if gun != null: _unequiped()
	gun = _gun
	set_up_gun()
	add_child(_gun)

func _unequiped() -> void:
	fire_rate.timeout.disconnect(gun._on_shoot_ready)
	gun.queue_free()
	pass
	
func set_up_gun() -> void:
	sprite.texture = gun.data.sprite
	fire_rate.wait_time = gun.data.fire_rate
	fire_rate.timeout.connect(gun._on_shoot_ready)
	gun.fire_rate = fire_rate
	gun.handleatack = get_parent()
