extends CharacterBody2D

var posicionIni: Vector2
var ultima_posicion_x: float

func _ready() -> void:
	posicionIni = global_position
	ultima_posicion_x = global_position.x

func _process(_delta: float) -> void:
	#Para que el pez de la vuelta calculando su posicion.
	var desplazamiento = global_position.x - ultima_posicion_x
	
	if desplazamiento < -0.1:
		$AnimatedSprite2D.flip_h = false
	elif desplazamiento > 0.1:
		$AnimatedSprite2D.flip_h = true
	ultima_posicion_x = global_position.x
