extends CanvasLayer

var puntos = 0

# Esta función se ejecutará cada vez que se emita la señal "point"
func _sumarPunto():
	puntos += 1
	# Actualiza el texto del Label para mostrar la puntuación actualizada
	$Label.text = str(puntos)
