extends "../character.gd"

# TODO: Fix player detection through walls

onready var parent = get_parent()

export (int) var detect_radius
export (int) var FOV

const RED = Color(1.0, 0, 0, 0.5)
const YELLOW = Color(1.0, 1.0, 0, 0.2)
const WHITE = Color(1, 1, 1, 0.2)
var fov_color = WHITE

var target
var hit_pos

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	if not is_dead() and parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		parent.rotate = true
	
	if target:
		aim()

func aim():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, target.global_position, [self], collision_mask)
	if result:
		hit_pos = result.position
		update()
		if result.collider.name == "player":
			fov_color = RED

func _draw():
	draw_circle_arc_poly(Vector2(), detect_radius, -FOV/2, FOV/2, fov_color)
	
	if target:
		draw_circle(to_local(hit_pos), 5, RED)
		draw_line(Vector2(), to_local(hit_pos), RED)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	
	for i in range(nb_points+1):
    	var angle_point = angle_from + i*(angle_to-angle_from)/nb_points
    	points_arc.push_back(center + Vector2( cos( deg2rad(angle_point) ), sin( deg2rad(angle_point) ) ) * radius)
	
	# Set detection area to the created polygon
	$DetectionArea/CollisionPolygon2D.polygon = points_arc
	
	# Draw the polygon
	# draw_polygon(points_arc, colors)

func die():
	.die()
	$Body.modulate = Color(0.7, 0.7, 0.7, 0.4)
	$CollisionShape2D.disabled = true
	$DetectionArea/CollisionPolygon2D.disabled = true
	target = null

func _on_DetectionArea_body_entered(body):
	if not target:
		target = body
	fov_color = YELLOW
	update()

func _on_DetectionArea_body_exited(body):
	if body == target:
		target = null
	fov_color = WHITE
	update()