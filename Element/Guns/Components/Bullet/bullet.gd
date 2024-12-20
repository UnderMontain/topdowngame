extends Area2D
class_name Bullet

var bullet_data: BulletData
var bullet_behavior : BulletBehavior


var direction: Vector2 = Vector2.RIGHT  # Dirección inicial de la bala
var speed: float = 400 # Velocidad de la bala

@onready var sprite_2d: Sprite2D = $Sprite2D


func set_direction_and_rotation(_rotation:float,_position:Vector2):
	rotation = _rotation
	direction = Vector2.RIGHT.rotated(rotation)
	position = _position

func set_propiety(_data:BulletData):
	bullet_data = _data
	bullet_behavior = bullet_data.bullet_behavior.new(self)


func _ready():
	sprite_2d.texture = bullet_data.sprite
	pass
	# Establecer la dirección y velocidad de la bala

func _physics_process(delta):
	if bullet_behavior:
		bullet_behavior.execute(delta)
	

func _on_timer_timeout() -> void:
	#queue_free()
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hiteable"):
		var enemy = body as EnemyLogic
		enemy._apply_Damage()
		bullet_behavior.hit_somebody(enemy)
		 # Replace with function body.
	#queue_free()

## Bounds, code
	#var collision: KinematicCollision2D = move_and_collide(velocity * speed)
	#if collision:
		#if bounds <= 0:
			#queue_free()
		#bounds = bounds - 1
		#var reflect = collision.get_remainder().bounce(collision.get_normal())
		#velocity = velocity.bounce(collision.get_normal())
		#rotation = velocity.angle()
		#move_and_collide(reflect)
	
	## O si quieres que la bala desaparezca cuando colisione
