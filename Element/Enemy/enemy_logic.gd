extends CharacterBody2D
class_name EnemyLogic

@export_category("Data") 
@export var default_stats: EnemyData
var current_data: EnemyData


@export var target: Node2D = null

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer

#Set layer bullet for enemy
@export_flags_2d_physics var layer
@export_flags_2d_physics var Mask
# Called when the node enters the scene tree for the first time.



func _ready() -> void:
	current_data = default_stats.duplicate()
	call_deferred("actor_setup")
	navigation_agent_2d.radius = 8

func actor_setup():
	await get_tree().physics_frame
	set_movement_target(target.position)

func set_movement_target(target_position: Vector2):
	navigation_agent_2d.target_position = target_position

func _physics_process(_delta: float) -> void:
	_update_direction_raycast()
	if ray_cast_2d.get_collider() == target:
		_update_target()	
		
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
		
		var velocity_dir = current_agent_position.direction_to(next_path_position)
		velocity = velocity.lerp(velocity_dir.normalized() * current_data.move_speed, 0.02)
		move_and_slide()
	else:
		velocity = velocity.lerp(Vector2.ZERO,0.065)
		move_and_slide()
		
		

func _update_direction_raycast() -> void:
	#if velocity != Vector2.ZERO:
	ray_cast_2d.target_position = (target.global_position - global_position).normalized() * current_data.maxtargetdistance

func _update_target() -> void:
	if target:
		navigation_agent_2d.target_position = target.position

#Recibe un resource o data con el Daño a aplicar 
func _apply_Damage()-> void:
	current_data.max_life -= 20
	print("hit", current_data.max_life,name)
	if current_data.max_life <= 0:
		print("im dead", current_data.max_life)
		_reset_stats()

func _reset_stats() -> void:
	current_data = default_stats
	print("Reset stats ", current_data.max_life)
#Shoot
func _on_timer_timeout() -> void:
	pass
	#var bullet = BULLET_SCENE.instantiate()
	#bullet.modulate = Color.REBECCA_PURPLE
	#bullet.collision_layer = self.collision_layer
	#bullet.collision_mask = self.collision_mask
	#var base_direction = (target.position - position).normalized()
	#var base_angle = base_direction.angle()
	#bullet.position = position
	#bullet.rotation = base_angle
	#bullet.direction = base_direction
	#get_parent().add_child(bullet)
	#pass # Replace with function body.
