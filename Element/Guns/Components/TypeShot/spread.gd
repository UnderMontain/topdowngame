extends TypeShot
class_name Spread


func use_type_shot(_direction:Vector2, _global_position:Vector2):
	#var current_data_bullet:BulletData = _bullet_scene.bullet_data
	var spread_angle_degrees: float = 40.0  # Ángulo total de dispersión
	var bullet_count: int = 5  # Número de balas disparadas
	var base_direction = _direction
	var base_angle = base_direction.angle()
	# Dividir el ángulo de dispersión en subrangos
	var spread_angle_radians = deg_to_rad(spread_angle_degrees)
	var angle_increment = spread_angle_radians / bullet_count 
	var start_angle = base_angle - spread_angle_radians / 2
	for i in range(bullet_count):
		# Generar un ángulo aleatorio dentro del subrango
		var min_angle = start_angle + i * angle_increment
		var max_angle = min_angle + angle_increment
		var bullet_angle = randf_range(min_angle, max_angle)
		
		# Rotar la dirección base (derecha)
		# Instanciar y disparar la bala
		#var bullet:BulletLogic = _bullet_scene.duplicate()
		#bullet.bullet_data = current_data_bullet
		#bullet.set_direction_and_rotation(bullet_angle,_global_position)
		emit_signal("request_bullet",bullet_angle,_global_position)
