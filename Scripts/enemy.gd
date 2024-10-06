extends CharacterBody2D

var movement_speed = 50.0
@export var target: Node2D = null

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("actor_setup")
	navigation_agent_2d.radius = 8

func actor_setup():
	await get_tree().physics_frame
	set_movement_target(target.position)

func set_movement_target(movement_target: Vector2):
	navigation_agent_2d.target_position = movement_target

func _physics_process(delta: float) -> void:
	if target:
		navigation_agent_2d.target_position = target.position
	
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
	
	
func _update_target() -> void:
	pass

func _on_timer_timeout() -> void:
	_update_target()
	pass # Replace with function body.
