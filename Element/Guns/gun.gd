extends Node
class_name Gun

var data: GunData
@onready var type_shot:TypeShot = $TypeShot

##Nodos hermanos
var handleatack: HandleAtack
var fire_rate : Timer
## Behaivor bullet

var _shoot_ready = true

func init(_gun_data: GunData) -> void:
	data = _gun_data

func _ready() -> void:
	type_shot.request_bullet.connect(on_instance_bullet)

func execute(_direction:Vector2,_position:Vector2) -> void:
	if not _shoot_ready:
		return
	_shoot_ready = false
	fire_rate.start()
	type_shot.use_type_shot(_direction,_position)
	## Bullet = get_bullet_decorator
	## intancie_bullet (Bullet, direct, position, objPool)

func on_instance_bullet(_direction:Vector2,_position:Vector2):
	var bullet = data.bullet_data.bullet.instantiate() as BulletLogic
	bullet.set_propiety(data.bullet_data)

func _on_shoot_ready() -> void:
	_shoot_ready = true
