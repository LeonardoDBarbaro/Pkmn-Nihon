extends ShapeCast3D

func snap_to_grid(grid_spacing):
	var rounded_position = Vector3(
		round(transform.origin.x / grid_spacing) * grid_spacing,
		transform.origin.y,
		round(transform.origin.z / grid_spacing) * grid_spacing
	)
	transform.origin = rounded_position

func snap_to_gridV(grid_spacing):
	var rounded_position = Vector3(
		transform.origin.x,
		round(transform.origin.y / grid_spacing) * grid_spacing,
		transform.origin.z
	)
	transform.origin = rounded_position
