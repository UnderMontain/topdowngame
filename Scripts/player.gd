extends CharacterBody2D


const SPEED = 350

const DASH_FORCE = 500
const DASH_DURATION = 2
var _dash_ready = true
var _is_dashing = false
var dash_time_elapsed  = 1.7

var _shoot_ready = true
@export var bullet_scene: PackedScene
@onready var timer: Timer = $Timer_Shooting
@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	
	_handle_movement(delta)
	_handle_dash(delta)
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot"):
		_shoot()

func _handle_movement(delta: float) -> void:
	if !_is_dashing:
		var move_vector = Input.get_vector("move_left","move_right","move_up","move_down") 
		var velocity_dir = velocity.lerp(move_vector* SPEED,0.08)
		velocity = velocity_dir
		move_and_slide()
		
		#move_and_collide(mob_velocity)
	#	pass

func _handle_dash(delta: float) -> void:
	if _is_dashing:
		dash_time_elapsed += delta
		if dash_time_elapsed < DASH_DURATION:
			_is_dashing = true
			_dash_ready = false
			var dash_velocity = velocity.normalized().lerp(velocity.normalized()*DASH_FORCE*delta,dash_time_elapsed)
			var collider = move_and_collide(dash_velocity)
			modulate = Color.DEEP_PINK
			if collider != null:
				dash_time_elapsed = 2
		else:
			_is_dashing = false
			_dash_ready = true
			dash_time_elapsed = 0
			modulate = Color.ALICE_BLUE
		
	elif Input.is_action_just_pressed("dash"):
		_is_dashing = true
		_dash_ready = false
		dash_time_elapsed = 1.7
		#var dash_velocity = Vector2(smoothstep(velocity.x,DASH_FORCE*delta, 0.8),smoothstep(velocity.y,DASH_FORCE*delta, 0.8))
	

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


func _on_timer_dash_timeout() -> void:
	_dash_ready = true
	_is_dashing = false
	dash_time_elapsed = 0
	pass # Replace with function body.
