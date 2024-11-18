extends RefCounted
class_name BulletBehavior


func _init() -> void:
	pass

func execute(bullet: BulletLogic, bullet_data:BulletData, _delta:float):
	var direction = Vector2.RIGHT.rotated(bullet.rotation)
	bullet.position += direction * bullet_data.speed_bullet * _delta
