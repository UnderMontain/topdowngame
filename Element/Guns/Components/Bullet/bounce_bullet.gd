extends BulletBehavior
class_name BounceBullet

var bounce :int = 3
var area_bounce : Area2D

func _init(_bullet: Bullet) -> void:
	super(_bullet)
	create_area2d()

func create_area2d():
	var area = Area2D.new()
	var collision_shape = CollisionShape2D.new()
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = 2000  # Radio de detección
	collision_shape.shape = circle_shape
	# Configurar el Area2D
	area.add_child(collision_shape)
	area.global_position = bullet.global_position
	#area.set_collision_layer_bit(2, true)  # Ajusta la capa si es necesario
	area.set_collision_mask(2)  # Ajusta la máscara si es necesario
	bullet.add_child(area)
	area_bounce = area

func hit_somebody(hit_info):
	if bounce <= 0:
		bullet.queue_free()
	var results = area_bounce.get_overlapping_bodies()
	if results.size() > 1:
		var nearest_enemy = null
		var shortest_distance = INF
		for result in results:
			#Chequear si es enemigo ToDo
			if result != hit_info: 
				var distance = bullet.global_position.distance_to(result.global_position)
				if distance < shortest_distance:
					shortest_distance = distance
					nearest_enemy = result

	  # Si hay un enemigo cercano, redirige la bala
		if nearest_enemy:
			var direction:Vector2 = (nearest_enemy.global_position - bullet.global_position).normalized()
			bounce -= 1
			bullet.rotation = direction.angle()
