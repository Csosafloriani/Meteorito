##MeteoritoSpawner.gd
class_name MeteoritoSpawner
extends Position2D

## Atributos Export
export var direccion:Vector2 = Vector2(1, 1)
export var rango_tamanio_meteorito:Vector2 = Vector2(0.5, 2.2)

## Metodos
func _ready():
	#Esto es temporal. como este script se llama antes del scipt del nivel
	#es necesario esperar a que este listo dicho script para ejecutar el envio
	#de las señal. Sin este "yield" se emite una señal que no recibe nadie
	#ya que el Nivel.gd no se cargó todavia.
	yield(owner,"ready")
	spawnear_meteorito()

## Metodos custom
func spawnear_meteorito() :
	Eventos.emit_signal("spawn_meteorito", global_position, direccion, tamanio_meteorito_aleatorio())

func tamanio_meteorito_aleatorio():
	randomize()
	return rand_range(rango_tamanio_meteorito[0], rango_tamanio_meteorito[1])
