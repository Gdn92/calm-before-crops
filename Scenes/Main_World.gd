extends Node2D

@onready var tile_map : TileMap = get_node("/root/Main/World/WorldTileMap")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready function called.")
	print("Tile map: ", tile_map)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		var mouse_pos : Vector2 = get_global_mouse_position()
		var tile_map_pos : Vector2i = tile_map.local_to_map(mouse_pos)
		
		# Debug 
		print("Mouse Position: ", mouse_pos)
		print("Tile Map Position: ", tile_map_pos)
		
		# Check if the tile_map_pos is valid
		if tile_map_pos.x >= 0 and tile_map_pos.y >= 0:
			# Ground is layer 0
			# Ground source id is 3, since we're looking at tiiles 
			# Relevant atlas coords are Vector2i(5, 1)
			tile_map.set_cell(0, tile_map_pos, 3, Vector2i(5, 1)) 
		else:
			print("Tile map position is out of bounds!")
	pass
