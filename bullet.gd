extends Area2D

const _SPEED = 300
var direction = Vector2.ZERO

func _physics_process(delta):
	var movement = direction * _SPEED * delta
	position += movement
	
func _on_body_entered(body):
	if body == TileMap:
		var tile_pos = body.local_to_map(position)
		tile_pos += Vector2i(direction)
		var tile = body.get_cell_source_id(0, tile_pos)
		print(tile)
		if tile == 0 or tile == 1:
			body.set_cell(0, tile_pos, 1, Vector2i(0,0))
		get_parent().remove_child(self)
	else:
		#get_parent().remove_child(self)
		pass
