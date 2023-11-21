#ContenedorInformacion.gd
class_name ContenedorInformacion
extends NinePatchRect

## Metodos

func mostrar():
	$AnimationPlayer.play("mostrar")

func ocultar():
	$AnimationPlayer.play("ocultar")

func mostrar_suavizado():
	$AnimationPlayer.play("mostrar_suavizado")

func ocultar_suavizado():
	$AnimationPlayer.play("ocultar_suavizado")
