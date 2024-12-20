extends CanvasLayer

@export var player : PlayerLogic
@onready var sprite_2d_gun: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.handle_atack.Equiped.connect(_changeGun)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _changeGun(gun:Gun):
	sprite_2d_gun.texture = gun.data.sprite
