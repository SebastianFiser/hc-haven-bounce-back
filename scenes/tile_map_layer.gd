extends TileMapLayer

@export var source_id: int = 0
@export var grass_tile: Vector2i = Vector2i(0, 0)
@export var dirt_tile: Vector2i = Vector2i(1, 0)
@export var decor_tiles: Array[Vector2i] = [Vector2i(2, 0), Vector2i(3, 0)]
@export var fill_depth: int = 15
@export_range(0.0, 1.0) var decor_chance: float = 0.06
@export var min_decor_depth: int = 2
@export var random_seed: int = 0

var rng := RandomNumberGenerator.new()


func _ready() -> void:
	if random_seed == 0:
		rng.randomize()
	else:
		rng.seed = random_seed
	fill_dirt()


func fill_dirt() -> void:
	for cell: Vector2i in get_used_cells():
		var data: TileData = get_cell_tile_data(cell)
		if data == null or not data.get_custom_data("grows_dirt"):
			continue

		for step in range(1, fill_depth + 1):
			var below: Vector2i = cell + Vector2i(0, step)
			if get_cell_source_id(below) != -1:
				break

			var tile: Vector2i = dirt_tile
			if step >= min_decor_depth and rng.randf() < decor_chance:
				tile = decor_tiles.pick_random()

			set_cell(below, source_id, tile)
