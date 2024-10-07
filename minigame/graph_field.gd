extends Control

# Массив точек графика
var points: Array[Vector2] = []
var function_type: String = "log"
# Коэффициенты, которые будут вводиться через LineEdit
var a: float = 0.0
var b: float = 0.0
var c: float = 0.0

var grid_size = 5  # Размер сетки 
# Выбранная позиция для вставки графика
var selected_cell = Vector2(0, 0)

# Функция вызывается при готовности
func _ready():
	# Пример начальной функции для отрисовки
	draw_logarithmic()  
	

# Отрисовка элементов графика
func _draw():
	# Рисуем оси координат, центрированные по середине поля
	var width = size.x
	var height = size.y
	var center_x = width / 2
	var center_y = height / 2
	
	# Рисуем оси
	draw_line(Vector2(center_x, 0), Vector2(center_x, height), Color(0, 0, 0), 2)  # Вертикальная ось
	draw_line(Vector2(0, center_y), Vector2(width, center_y), Color(0, 0, 0), 2)  # Горизонтальная ось

	# Рисуем график
	if points.size() > 1:
		for i in range(points.size() - 1):
			draw_line(points[i], points[i + 1], Color(1, 0, 0), 2)  # Красная линия графика

# Функция для обновления графика
func refresh_graph():
	queue_redraw()  # Godot 4 вместо update()

# Пример функции отрисовки синусоиды
func draw_sinusoidal():
	points.clear()
	var width = size.x
	var center_x = width / 2
	var center_y = size.y / 2
	
	for x in range(-center_x, center_x):
		var y = a * sin(b * x * 0.05) + c  # Пример функции синуса с коэффициентами
		points.append(Vector2(x + center_x, -y + center_y))  # Перемещаем в центр поля
	refresh_graph()  # Перерисовываем график
	
# Пример функции отрисовки экспоненциальной функции
func draw_exponential():
	points.clear()
	var width = size.x
	var center_x = width / 2
	var center_y = size.y / 2
	
	for x in range(-center_x, center_x):
		var y = a * exp(b * x * 0.01) + c  # Пример функции экспоненты с коэффициентами
		points.append(Vector2(x + center_x, -y + center_y))  # Перемещаем в центр поля
	refresh_graph()  # Перерисовываем график

# Пример функции отрисовки логарифмической функции
func draw_logarithmic():
	points.clear()
	var width = size.x
	var center_x = width / 2
	var center_y = size.y / 2
	
	for x in range(1, center_x):  # Избегаем логарифма от 0
		var y = a * log(b * x) + c  # Пример функции логарифма с коэффициентами
		points.append(Vector2(x + center_x, -y + center_y))  # Перемещаем в центр поля
	refresh_graph()  # Перерисовываем график
	
# Полиморфная функция (например, квадратичная)
func draw_polynomial():
	points.clear()
	var width = size.x
	var center_x = width / 2
	var center_y = size.y / 2
	
	for x in range(-center_x, center_x):
		var y = a * pow(x, 2) + b * x + c  # Пример полиномиальной функции (квадратичная)
		points.append(Vector2(x + center_x, -y + center_y))  # Перемещаем в центр поля
	refresh_graph()  # Перерисовываем график



# Обработчики изменения значений в LineEdit
func _on_line_edit_a_text_changed(new_text: String) -> void:
	a = new_text.to_float()  # Преобразуем текстовое значение в float
	refresh_graph()  # Обновляем график


func _on_line_edit_b_text_changed(new_text: String) -> void:
	b = new_text.to_float()
	refresh_graph()

func _on_line_edit_c_text_changed(new_text: String) -> void:
	c = new_text.to_float()
	refresh_graph()


func _on_log_button_pressed() -> void:
	function_type = "log"
	update_graph()


func _on_poli_button_pressed() -> void:
	function_type = "poly"
	update_graph()


func _on_exp_button_pressed() -> void:
	function_type = "exp"
	update_graph()


func _on_sin_button_pressed() -> void:
	function_type = "sin"
	update_graph()


func _on_save_button_pressed() -> void:
	update_graph()

func update_graph():
	match function_type:
		"sin":
			draw_sinusoidal()
		"exp":
			draw_exponential()
		"log":
			draw_logarithmic()
		"poly":
			draw_polynomial()
