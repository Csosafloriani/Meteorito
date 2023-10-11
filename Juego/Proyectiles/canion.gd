#Canion.gd
class_name Canion
extends Node2D

## Atributos export
export var proyectil:PackedScene = null
export var cadencia_disparo:float = 0.8
export var velocidad_proyectil:int = 100
export var danio_proyectil:int = 1

## Atributos onready
onready var timer_enfriamiento:Timer = $TimerEnfriamiento
onready var disparo_sfx:AudioStreamPlayer2D = $DisparoFX
onready var esta_enfriado:bool = true
onready var esta_disparando:bool = false setget set_esta_disparando

## Atributos
var puntos_disparo:Array = []

## Setters y Getters
func set_esta_disparando(disparando:bool) -> void:
	esta_disparando = disparando

## Metodos
func _ready() -> void:
	almacenar_puntos_disparo()
	timer_enfriamiento.wait_time = cadencia_disparo

func _process(delta: float) -> void:
	if esta_disparando and esta_enfriado:
		disparar()

## Metodos Custom
func almacenar_puntos_disparo() -> void:
	for nodo in get_children():
		if nodo is Position2D:
			puntos_disparo.append(nodo)

func disparar():
	pass
