extends Node2D


var hitpoints:float = 10.0

func _process(_delta) -> void:
	$canion.set_esta_disparando(true)

func _on_Area2D_body_entered(body):
	if body is Player:
		body.destruir()

func recibir_danio(danio:float) -> void:
	print("dañado")
	hitpoints -= danio
	print(hitpoints)
	if hitpoints <= 0.0 :
		queue_free()
