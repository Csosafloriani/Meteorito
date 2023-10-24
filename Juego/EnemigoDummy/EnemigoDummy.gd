extends Node2D


var hitpoints:int = 100

func _process(delta) -> void:
	$canion.set_esta_disparando(true)

func _on_Area2D_body_entered(body):
	if body is Player:
		body.destruir()

func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	if hitpoints <= 0.0 :
		queue_free()
