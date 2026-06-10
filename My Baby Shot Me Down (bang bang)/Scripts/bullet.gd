extends Node3D

const SPEED = 40.0

@onready var mesh = $MeshInstance3D
@onready var area3d = $Area3D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta

func _on_area_3d_body_entered(body: Node3D) -> void:
		print("Acertou:", body.name)
		if body.is_in_group("Inimigo"):
			mesh.visible = false
			body.queue_free()
			queue_free()
