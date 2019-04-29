extends "res://scripts/character.gd"

onready var parent = get_parent()

export (int) var detect_radius
export (int) var FOV

var angle = 0
var direction = Vector2()

const RED = Color(1.0, 0, 0, 0.4)
const YELLOW = Color(1.0, 1.0, 0, 0.4)
var fov_color = YELLOW

func _process(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		parent.rotate = true
	else:
		pass

func _draw():
	draw_circle_arc_poly(Vector2(), detect_radius, -FOV/2, FOV/2, fov_color)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points+1):
    	var angle_point = angle_from + i*(angle_to-angle_from)/nb_points
    	points_arc.push_back(center + Vector2( cos( deg2rad(angle_point) ), sin( deg2rad(angle_point) ) ) * radius)
	$DetectionArea/CollisionPolygon2D.polygon = points_arc
	draw_polygon(points_arc, colors)

func _on_DetectionArea_body_entered(body):
	if body.name == "player":
		fov_color = RED
		update()
	pass # Replace with function body.


func _on_DetectionArea_body_exited(body):
	if body.name == "player":
		fov_color = YELLOW
		update()
	pass # Replace with function body.