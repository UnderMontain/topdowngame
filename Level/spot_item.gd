extends Node2D
class_name SpotItem

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@export var item_data: ItemData
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = get_parent().create_tween()
	sprite_2d.texture = item_data.sprite
	
	tween.loop_finished.connect(_particles)
	tween.set_loops()
	tween.tween_property(sprite_2d,"position",Vector2(0,-10),0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite_2d,"position",Vector2(0,0),1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _particles(lop:int) -> void:
	print(lop)
	gpu_particles_2d.emitting = true
	gpu_particles_2d.restart()
	

func _restart_emitting():
	gpu_particles_2d.emitting = false

func get_new_item() -> Gun:
	var gun_intance
	match item_data.type_item:
		item_data.TypeItem.GUN:
			gun_intance = item_data.get_intance()
	##Agregar las demas bifurcaciones
	return gun_intance

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerLogic:
		body._can_pickup(self)
	

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerLogic:
		body._can_pickup(self) # Replace with function body.
