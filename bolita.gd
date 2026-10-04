extends Node2D

@export var radio := 120.0
@export var velocidad := 2.0
var angulo := 0.0

#Función que hace rotar a Bolita al rededor de mosca.
func _process(delta: float) -> void:
	angulo += velocidad * delta
	position = Vector2(cos(angulo), sin(angulo)) * radio

func _on_area_bolita_body_entered(body: Node2D) -> void:
	if body.name == "Chiquitito" :
		body.get_node("AnimatedSprite2D").animation = "dead"
		body.get_node("AnimatedSprite2D").play()
