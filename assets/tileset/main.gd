extends Node

var tile_size = Vector2(64, 64)
onready var texture = $Tilesheet.texture

func _ready():
	var tex_width = texture.get_width() / tile_size.x
	var tex_height = texture.get_height() / tile_size.y
	var ts = TileSet.new()
	var id = 0
	for y in range(tex_height):
		for x in range(tex_width):
			var region = Rect2(x * tile_size.x, y * tile_size.y, tile_size.x, tile_size.y)
			ts.create_tile(id)
			ts.tile_set_texture(id, texture)
			ts.tile_set_region(id, region)
			id += 1
	ResourceSaver.save("res://assets/tileset/terrain_tiles.tres", ts)