extends TypeShot
class_name Line

func use_type_shot(_bullet:BulletLogic, _direction:Vector2, _global_position:Vector2):
	var base_direction = _direction
	var base_angle = base_direction.angle()
	# Rotar la dirección base (derecha)
	# Instanciar y disparar la bala
	_bullet.position = _global_position # Offset de la punta del armas
	_bullet.rotation = base_angle
	get_tree().current_scene.get_node("PoolObject").add_child(_bullet)
