extends CharacterBody2D


@export var speed: float = 1000.0  # Velocidad de la bala
@export var direction: Vector2 = Vector2.RIGHT  # Dirección inicial de la bala

func _ready():
	# Establecer la dirección y velocidad de la bala
	velocity = direction * speed

func _physics_process(delta):
	# Mover la bala en la dirección especificada
	move_and_collide(velocity * delta)

	# O si quieres que la bala desaparezca cuando colisione
	 
