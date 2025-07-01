class_name EnemySpawnLocation


static func get_spawn_position(camera: Rect2, map_bounds: Rect2) -> Vector2i:
	# Must be outside the camera but inside the map bounds
	var spawn_position: Vector2i

	var possible_positions: Array[Rect2] = get_possible_positions(camera, map_bounds)

	if possible_positions.is_empty():
		push_error("No valid spawn positions found outside the camera bounds.")
		return Vector2.ZERO # Return a default position if no valid spawn positions are found

	# Choose a random rectangle from the possible positions
	var random_index: int = randi() % possible_positions.size()
	var spawn_rect: Rect2 = possible_positions[random_index]

	# Choose a random position within the selected rectangle
	spawn_position = Vector2i(
		randi_range(spawn_rect.position.x as int, (spawn_rect.position.x + spawn_rect.size.x) as int),
		randi_range(spawn_rect.position.y as int, (spawn_rect.position.y + spawn_rect.size.y) as int)
	)

	return spawn_position


static func get_possible_positions(camera_rect: Rect2, area: Rect2) -> Array[Rect2]:
	var possible_positions: Array[Rect2] = []

	# Top
	if area.position.y < camera_rect.position.y:
		var top = area.position.y
		var left = area.position.x
		var width = area.size.x
		var height = min(camera_rect.position.y - area.position.y, area.size.y)
		possible_positions.append(Rect2(left, top, width, height))

	# Bottom
	if area.position.y + area.size.y > camera_rect.position.y + camera_rect.size.y:
		var top = max(camera_rect.position.y + camera_rect.size.y, area.position.y)
		var left = area.position.x
		var width = area.size.x
		var height = min(area.position.y + area.size.y - top, area.size.y)
		possible_positions.append(Rect2(left, top, width, height))

	# Left
	if area.position.x < camera_rect.position.x:
		var top = area.position.y
		var left = area.position.x
		var width = min(camera_rect.position.x - area.position.x, area.size.x)
		var height = area.size.y
		possible_positions.append(Rect2(left, top, width, height))

	# Right
	if area.position.x + area.size.x > camera_rect.position.x + camera_rect.size.x:
		var top = area.position.y
		var left = max(camera_rect.position.x + camera_rect.size.x, area.position.x)
		var width = min(area.position.x + area.size.x - left, area.size.x)
		var height = area.size.y
		possible_positions.append(Rect2(left, top, width, height))

	return possible_positions
