extends Gun
class_name Shotgun


#func execute(_direction:Vector2,_position:Vector2) -> void:
	#super.execute(_direction:Vector2,_position:Vector2)
	#pass
	
	#var spread_angle_degrees: float = 40.0  # Ángulo total de dispersión
	#var bullet_count: int = 5  # Número de balas disparadas
	##var base_direction = (node.get_global_mouse_position() - node.position).normalized()
	#var base_direction = handleatack.player.direction_mouse
	#var base_angle = base_direction.angle()
	## Dividir el ángulo de dispersión en subrangos
	#var spread_angle_radians = deg_to_rad(spread_angle_degrees)
	#var angle_increment = spread_angle_radians / bullet_count   # El -1 es para que incluya ambos extremos
	#var start_angle = base_angle - spread_angle_radians / 2
	#for i in range(bullet_count):
		## Generar un ángulo aleatorio dentro del subrango
		#var min_angle = start_angle + i * angle_increment
		#var max_angle = min_angle + angle_increment
		#var bullet_angle = randf_range(min_angle, max_angle)
		#
		#
		#var new_direction = Vector2.RIGHT.rotated(bullet_angle)
		## Rotar la dirección base (derecha)
		## Instanciar y disparar la bala
		#var bullet = data.bullet.instantiate()
		#bullet.position = handleatack.player.global_position # Offset de la punta del armas
		#bullet.rotation = bullet_angle
		#bullet.direction = new_direction
		#handleatack.player.add_sibling(bullet)
