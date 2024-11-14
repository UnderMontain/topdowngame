extends CharacterBody2D
class_name PlayerLogic

@export_category("Data")
@export var _default_data_player: PlayerData 
var current_data_player: PlayerData

var direction_mouse: Vector2 = Vector2.ZERO

var dash_ready = true
var is_dashing = false
var dash_time_elapsed  = 1.7

var shoot_ready = true
var target_item_to_pickup: ItemData 
var target_item: SpotItem 

@export var can_pickup = false
@export var bullet_scene: PackedScene

@onready var timer: Timer = $Timer_Shooting
@onready var handle_atack: HandleAtack = $HandleAtack


func _ready() -> void:
	current_data_player = _default_data_player
	handle_atack.player = self

func _process(_delta: float) -> void:
	
	_direction_mouse()
	
	if Input.is_action_just_pressed("pickup") and can_pickup:
		can_pickup = false
		if target_item != null:
			var gun = _pickup_item()
			handle_atack._set_gun(gun,self) 
			

func _physics_process(delta: float) -> void:
	
	_handle_movement(delta)
	_handle_dash(delta)
	
	if Input.is_action_pressed("shoot"):
		#_shoot()
		handle_atack.realeseAttack()
		

	if Input.is_action_just_pressed("Right_click"):
		pass

func _handle_movement(_delta: float) -> void:
	if !is_dashing:
		var move_vector = Input.get_vector("move_left","move_right","move_up","move_down") 
		var velocity_dir = velocity.lerp(move_vector * current_data_player.move_speed, 0.08)
		velocity = velocity_dir
		move_and_slide()

func _handle_dash(delta: float) -> void:
	if is_dashing:
		dash_time_elapsed += delta
		if dash_time_elapsed < current_data_player.dash_duration:
			is_dashing = true
			dash_ready = false
			var dash_velocity = velocity.normalized().lerp(velocity.normalized()* current_data_player.dash_force *delta,dash_time_elapsed)
			var collider = move_and_collide(dash_velocity)
			modulate = Color.DEEP_PINK
			if collider != null:
				dash_time_elapsed = 2
		else:
			is_dashing = false
			dash_ready = true
			dash_time_elapsed = 0
			modulate = Color.ALICE_BLUE
		
	elif Input.is_action_just_pressed("dash"):
		is_dashing = true
		dash_ready = false
		dash_time_elapsed = 1.7
		#var dash_velocity = Vector2(smoothstep(velocity.x,DASH_FORCE*delta, 0.8),smoothstep(velocity.y,DASH_FORCE*delta, 0.8))

func _direction_mouse() -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	direction_mouse = direction

func _pickup_item() -> Gun:
	var gun = target_item.get_new_item()
	return gun

func _can_pickup(_spot_item: SpotItem):
	if target_item == _spot_item:
		target_item = null
		can_pickup = false
	else:
		target_item = _spot_item
		can_pickup = true

func _on_timer_timeout() -> void:
	shoot_ready = true


func _on_timer_dash_timeout() -> void:
	dash_ready = true
	is_dashing = false
	dash_time_elapsed = 0
	pass 

#var poscell = ground.local_to_map(get_global_mouse_position())
	#var pos_world = ground.map_to_local(poscell)
	#var array: PackedVector2Array = ([Vector2(-8,-8 ), Vector2(8, -8),Vector2(8,8),Vector2(-8, 8)])
	#$Line2D.set_points(array)
	#$Line2D.global_position = pos_world
	#z_index = position.y
	
	#_is_construction = true
	#
		#var obj = WALLTILE.instantiate()
		#obj.position = pos_world
		#obj.z_index = obj.position.y
		#get_parent().add_child(obj)
		##ground.set_cell(poscell,1,Vector2i(0,15))
		##print(ground.get_surrounding_cells(poscell))
		##wall.position = ground.map_to_local(poscell)
		#print(poscell)
		
		#var poscell: Array[Vector2i]
		#poscell.append(ground.local_to_map(get_global_mouse_position())) 
		##ground.set_cell(poscell,1,Vector2i(0,19))
		#ground.set_cells_terrain_connect(poscell,0,0,false)
		##wall.position = ground.map_to_local(poscell)
		#print(poscell)
