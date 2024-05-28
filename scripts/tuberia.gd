extends Area2D

const VELOCIDAD = 100  # Ajusta la velocidad según sea necesario.
var tiempo_transcurrido = 0

func _ready():
	# Iniciar el temporizador para eliminar la tubería después de 10 segundos.
	$Timer.wait_time = 8
	$Timer.start()

func _process(delta):
	# Mover la tubería hacia la izquierda.
	var nueva_posicion = position - Vector2(VELOCIDAD * delta, 0)
	position = nueva_posicion

func _on_Timer_timeout():
	queue_free()  # Eliminar la tubería cuando el temporizador finaliza.

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	body.death()

# Dentro de tu método _on_puntuacion_body_entered()
func _on_puntuacion_body_entered(body):
	print("¡Has realizado un punto! :D")
	var spawner = get_parent()  # Obtener una referencia al nodo Spawner
	var main_scene_reference = spawner.get_parent()  # Obtener una referencia a la escena principal desde el nodo Spawner
	main_scene_reference._point()  # Llama a la función _point() en la escena principal
	$Puntuacion/point.play()
