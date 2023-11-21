#NaveBase.gd
class_name NaveBase
extends RigidBody2D

## Enums
enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}



## Atributos onready
onready var animacion:AnimationPlayer = $AnimationPlayer
onready var impactoSFX:AudioStreamPlayer = $AudioStreamPlayer
onready var colisionador:CollisionShape2D = $CollisionShape2D
onready var canion:Canion = $canion

## Atributos Export
export var hitpoints:float = 10.0

## Atributos
var estado_actual:int = ESTADO.SPAWN

## Metodos
func _ready() -> void:
	controlador_estados(estado_actual)

## Metodos custom
func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	if hitpoints <= 0.0 :
		destruir()
	impactoSFX.play()


func controlador_estados(nuevo_estado:int) -> void:
	match nuevo_estado:
		ESTADO.SPAWN:
			colisionador.set_deferred("disabled", true)
			canion.set_puede_disparar(false)
			print ("SPAWN ESTADO")
		ESTADO.VIVO:
			colisionador.set_deferred("disabled", false)
			canion.set_puede_disparar(true)
			print ("VIVO ESTADO")
		ESTADO.INVENCIBLE:
			colisionador.set_deferred("disabled", true)
		ESTADO.MUERTO:
			colisionador.set_deferred("disabled", true)
			canion.set_puede_disparar(false)
			
			#explotar
			Eventos.emit_signal("nave_destruida", self, global_position, 3)
			queue_free()
		_:
			printerr("Error de estado")
	estado_actual = nuevo_estado

func destruir() -> void:
	controlador_estados(ESTADO.MUERTO)

# Señales internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "spawn":
		controlador_estados(ESTADO.VIVO)


func _on_body_entered(body: Node) -> void:
	if body is Meteorito:
		body.destruir()
		destruir()


