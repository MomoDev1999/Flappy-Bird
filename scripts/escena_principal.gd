extends Node2D

var puntuacion_actual = 0
var has_jumped = false

func _ready():
	load_score()
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		has_jumped = true  # Marcar que el pájaro ha saltado.
	
	if not has_jumped:
		$CanvasLayer/Mensaje.visible = true  # Mostrar el mensaje para saltar
		$CanvasLayer/Label.visible = false  # Ocultar la puntuación si el pájaro no ha saltado
	else:
		$CanvasLayer/Mensaje.visible = false  # Ocultar el mensaje cuando ya se ha saltado
		$CanvasLayer/Ultima_puntuacion.visible = false # Ocultar el mensaje cuando ya se ha saltado
		$CanvasLayer/Label.visible = true  # Mostrar la puntuación cuando el pájaro ha saltado

func _point():
	puntuacion_actual = $CanvasLayer/Label.text.to_int()
	puntuacion_actual += 1
	$CanvasLayer/Label.text = str(puntuacion_actual)

func save_score():
	var puntuacion_actual = $CanvasLayer/Label.text.to_int()
	var file = FileAccess.open("res://guardado/puntuacion.txt", FileAccess.READ)
	if file.get_error() == OK:
		var puntuacion_anterior = file.get_var()
		file.close()
		if puntuacion_anterior != null and puntuacion_actual > puntuacion_anterior:
			var file_write = FileAccess.open("res://guardado/puntuacion.txt", FileAccess.WRITE)
			file_write.store_var(puntuacion_actual)
			file_write.close()
		elif puntuacion_anterior == null:
			var file_write = FileAccess.open("res://guardado/puntuacion.txt", FileAccess.WRITE)
			file_write.store_var(puntuacion_actual)
			file_write.close()
	else:
		var file_write = FileAccess.open("res://guardado/puntuacion.txt", FileAccess.WRITE)
		file_write.store_var(puntuacion_actual)
		file_write.close()

func load_score():
	var file = FileAccess.open("res://guardado/puntuacion.txt", FileAccess.READ)
	if file.get_error() == OK:
		var puntuacion_actual = file.get_var()
		file.close()
		if puntuacion_actual != null :
			$CanvasLayer/Ultima_puntuacion.text = "mejor puntuación: " + str(puntuacion_actual)


