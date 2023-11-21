#HUD.gd
extends CanvasLayer

## Atributos Onready
onready var info_zona_recarga:ContenedorInformacion = $InfoZonaRecarga

## Metodos
func _ready():
	conectar_seniales()


## Metodos Custom
func conectar_seniales() -> void:
	Eventos.connect("nivel_iniciado", self, "fade_out")
	Eventos.connect("nivel_terminado", self, "fade_in")
	Eventos.connect("detecto_zona_recarga", self, "_on_detecto_zona_recarga")

func _on_detecto_zona_recarga(en_zona:bool) -> void:
	if en_zona:
		info_zona_recarga.mostrar_suavizado()
	else:
		info_zona_recarga.ocultar_suavizado()


func fade_in() -> void:
	$FadeCanvas/AnimationPlayer.play("fade_in")

func fade_out() -> void:
	$FadeCanvas/AnimationPlayer.play_backwards("fade_in")
