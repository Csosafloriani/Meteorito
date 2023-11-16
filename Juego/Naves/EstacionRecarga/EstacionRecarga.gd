#EstacionRecarga.gd
class_name EsstacionRecarga
extends Node2D

# Atributos Onready
onready var carga_sfx:AudioStreamPlayer = $CargaSFX


# Atributos Export
export var energia:float = 6.0
export var radio_energia_entregada:float = 0.05

#Atributos
var nave_player:Player = null
var player_en_zona:bool = false

# Metodos
func _unhandled_input(event: InputEvent) -> void:
	if not puede_recargar(event):
		return
		
	controlar_energia()
	
	if event.is_action("recarga_escudo"):
		nave_player.get_escudo().controlar_energia(radio_energia_entregada)
	elif event.is_action("recarga_laser"):
		nave_player.get_laser().controlar_energia(radio_energia_entregada)
	
	if event.is_action_released("recarga_escudo") or event.is_action_released("recarga_laser"):
		carga_sfx.stop()
		$VacioSFX.stop()

# Metodos Custom
func controlar_energia() -> void:
	energia -= radio_energia_entregada
	if energia <= 0.0:
		$VacioSFX.play()
		carga_sfx.stop()
	#solo debug, quitar
	print("Energia estacion: ", energia)

func puede_recargar(event: InputEvent) -> bool:
	var hay_input = event.is_action("recarga_escudo") or event.is_action("recarga_laser")
	
	
	if hay_input and player_en_zona and energia > 0.0:
		if !carga_sfx.playing:
			carga_sfx.play()
			
		return true
	
	return false

# Señales Internas

func _on_AreaColision_body_entered(body):
	if body.has_method("destruir"):
		body.destruir()


func _on_AreaRecarga_body_entered(body):
	if body is Player:
		player_en_zona = true
		nave_player = body

func _on_AreaRecarga_body_exited(body):
	carga_sfx.stop()
	$VacioSFX.stop()
	player_en_zona = false