extends CharacterBody2D

@export var bounds: int = 3
@export var speed: float = 1000.0  # Velocidad de la bala
@export var direction: Vector2 = Vector2.RIGHT  # Dirección inicial de la bala

func _ready():
	# Establecer la dirección y velocidad de la bala
	velocity = direction * speed

func _physics_process(delta):
	# Mover la bala en la dirección especificada
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		if bounds <= 0:
			queue_free()
		bounds = bounds - 1
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		rotation = velocity.angle()
		move_and_collide(reflect)
	# O si quieres que la bala desaparezca cuando colisione
	 
