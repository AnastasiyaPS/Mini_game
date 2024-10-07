extends Line2D

func _ready():
	# Рисуем оси
	add_point(Vector2(0, 300))  # Ось X
	add_point(Vector2(600, 300))
	add_point(Vector2(300, 0))  # Ось Y
	add_point(Vector2(300, 600))
