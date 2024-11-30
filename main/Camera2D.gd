extends Camera2D

func _ready():
	adjust_zoom()

func adjust_zoom():
	# Get the viewport size
	var viewport_size = get_viewport().size
	
	# Calculate zoom based on viewport size
	# For example, we can use a base size (like 800x600) to determine zoom level
	var target_size = Vector2i(1980, 1060)
	var zoom_factor = target_size / (viewport_size)
	
	# Set the zoom property
	zoom = zoom_factor
