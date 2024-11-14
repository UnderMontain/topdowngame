extends ItemData
class_name GunData

@export var bullet_data: BulletData
@export var scene_gun: PackedScene 
@export var damage: int
@export var max_ammo: int
@export var fire_rate: float
@export var accuracy: int


@export_range(1, 100,1) var range:int 



func get_intance() -> Gun:
	var instance = scene_gun.instantiate() as Gun
	instance.init(self)
	return instance
