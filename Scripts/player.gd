extends CharacterBody2D


const SPEED = 15000.0
const JUMP_VELOCITY = -400.0
@export var bullet_scene: PackedScene
var _shoot_ready = true
@onready var timer: Timer = $Timer



func _physics_process(delta: float) -> void:
	

	look_at(get_global_mouse_position())
	
	var move_vector = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = move_vector.normalized() * delta * SPEED
	move_and_slide()
	if Input.is_action_pressed("shoot"):
		_shoot()

func _shoot() -> void:
	if not _shoot_ready:
		return
	_shoot_ready = false
	timer.start()
	
	var spread_angle_degrees: float = 40.0  # Ángulo total de dispersión
	var bullet_count: int = 5  # Número de balas disparadas
	var base_direction = (get_global_mouse_position() - position).normalized()
	print(base_direction)
	var base_angle = base_direction.angle()
	print(base_angle)
   # Dividir el ángulo de dispersión en subrangos
	var spread_angle_radians = deg_to_rad(spread_angle_degrees)
	var angle_increment = spread_angle_radians / bullet_count   # El -1 es para que incluya ambos extremos
	var start_angle = base_angle - spread_angle_radians / 2
	for i in range(bullet_count):
		var min_angle = start_angle + i * angle_increment
		var max_angle = min_angle + angle_increment
		var bullet_angle = randf_range(min_angle, max_angle)
		
		print("Bullet angle ", i ,":", bullet_angle)
		# Generar un ángulo aleatorio dentro del subrango
		var new_direction = Vector2.RIGHT.rotated(bullet_angle)
		print("New direction:", new_direction)
		# Rotar la dirección base (derecha)
		# Instanciar y disparar la bala
		var bullet = bullet_scene.instantiate()
		bullet.position = position
		bullet.rotation = bullet_angle
		bullet.direction = new_direction
		get_parent().add_child(bullet)
		print("----")


func _on_timer_timeout() -> void:
	_shoot_ready = true
