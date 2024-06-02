extends Node2D

var radio_inicial: float = 50.0
var velocidad_expansion: float = 10.0  # píxeles por segundo
var radio_maximo: float = 200.0
var grosor_borde: float = 10.0  # ancho del borde del círculo
var radio_actual: float

@onready var collision_polygon = $Hitbox/CollisionPolygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var seg_count = 9
	var angle = (360 / seg_count)
	var innerSize = 75
	var outerSize = 95
	for j in range(0,seg_count):
		var Polygon = Polygon2D.new()
		var ColPolygon = CollisionPolygon2D.new()
		var rot = j * (360 / seg_count)
		Polygon.color = '#333333'
		Polygon.antialiased=true
		var points = []
		for i in range(0, seg_count):
			var x = sin(deg_to_rad((angle * i)-rot)) * (outerSize)
			var y = cos(deg_to_rad((angle * i)-rot)) * (outerSize)
			points.append(Vector2(x,y))
		for i in range(0, seg_count):
			var rev = seg_count - i - 1;
			var x = sin(deg_to_rad((angle * rev)-rot)) * innerSize
			var y = cos(deg_to_rad((angle * rev)-rot)) * innerSize
			points.append(Vector2(x,y))
		Polygon.set_polygon(points)
		ColPolygon.set_polygon(points)
		add_child(Polygon)
		add_child(ColPolygon) 
	#_update_collision_polygon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#_update_collision_polygon()
	pass

func _update_collision_polygon():
	var circle_points = PackedVector2Array()
	var num_segments = 32
	var angle = 0
	
	# Crear puntos del semicírculo original
	for i in range(num_segments + 1):
		angle = (i * PI)/num_segments
		var point = Vector2(cos(angle), sin(angle)) * radio_actual
		circle_points.append(point)
	
	radio_actual = radio_actual - grosor_borde
	
	# Añadir círculo interior en la dirección opuesta
	for i in range(num_segments + 1):
		angle = (i * -PI * 2)/ num_segments
		var point = Vector2(cos(angle), sin(angle)) * radio_actual
		circle_points.append(point)
	
	radio_actual = radio_actual + grosor_borde
	
	 # Añadir semicírculo exterior en la dirección original
	for i in range(num_segments + 1):
		angle = i * -PI / num_segments
		var point = Vector2(cos(angle), sin(angle)) * radio_actual
		circle_points.append(point)
	
	collision_polygon.polygon = circle_points
