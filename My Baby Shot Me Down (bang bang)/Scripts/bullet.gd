extends Node3D

const SPEED = 40.0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta

func matar():
	if ray.is_colliding():
		var alvo = ray.get_collider()
		if alvo.is_in_group("Inimigo"):
				alvo.queue_free()
