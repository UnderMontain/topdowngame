extends RefCounted
class_name BulletBehavior

var bullet : Bullet

func _init(_bullet: Bullet) -> void:
	bullet = _bullet
	pass

func execute(_delta:float):
	var direction = Vector2.RIGHT.rotated(bullet.rotation)
	bullet.position += direction * bullet.bullet_data.speed_bullet * _delta

func hit_somebody(hit_info):
	bullet.queue_free()
