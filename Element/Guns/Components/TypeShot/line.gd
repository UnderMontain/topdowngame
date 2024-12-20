extends TypeShot
class_name Line

func use_type_shot(_direction:Vector2, _global_position:Vector2):
	var base_angle = _direction.angle()
	# Rotar la dirección base (derecha)
	# Instanciar y disparar la bala
	emit_signal("request_bullet",base_angle,_global_position)
	
