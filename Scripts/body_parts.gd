extends RigidBody2D

var randomX
var randomY

var main
var blood : GPUParticles2D

var killed_by_sawblade = false

@onready var tile_map : TileMap = $"/root/Main/GAME/Level01/Environment/TileMap"
var is_gravity_changed = false
var parts_tile_pose

var set_original_source_id = 9.0
var set_bloody_source_id = 6.0

#both side painted tiles
var top_and_left_painted_atlas = Vector2i(10, 4)
var top_and_right_painted_atlas = Vector2i(9, 4)


#ref for set og under ground tiles
var og_left_ground_atlas = Vector2i(0, 0)
var og_mid_ground_atlas = Vector2i(1, 0)
var og_right_ground_atlas = Vector2i(2, 0)
var bloody_og_left_ground_atlas = Vector2i(9, 3)
var bloody_og_right_ground_atlas = Vector2i(16, 3)
var random_bloody_atlas = Vector2i(int(randi_range(10, 15)), 3)

#ref for set og left ground tiles
var og_left_mid_ground = Vector2i(2, 1)
var og_left_top_ground = Vector2i(2, 0)
var og_left_down_ground = Vector2i(2, 2)
var og_left_top_atlas = Vector2i(5, 2)
var og_left_mid_atlas = Vector2i(5, 3)
var og_left_down_atlas = Vector2i(5, 4) 

#ref for set og right ground tiles
var og_right_mid_ground = Vector2i(0, 1)
var og_right_top_ground = Vector2i(0, 0)
var og_right_down_ground = Vector2i(0, 2)
var og_right_top_atlas = Vector2i(4, 2)
var og_right_mid_atlas = Vector2i(4, 3)
var og_right_down_atlas = Vector2i(4, 4)

#ref for all sawblade atlas
var saw_atlas_core1 = Vector2i(0, 5)
var saw_atlas_core2 = Vector2i(0, 6)
var saw_atlas_core3 = Vector2i(0, 7)
var saw_atlas_core4 = Vector2i(0, 8)
var saw_atlas_core5 = Vector2i(1, 5)
var saw_atlas_core6 = Vector2i(1, 6)
var saw_atlas_core7 = Vector2i(1, 7)
var saw_atlas_core8 = Vector2i(1, 8)
var saw_atlas_coor1 = Vector2i(0, 9)
var saw_atlas_coor2 = Vector2i(1, 9)
var saw_atlas_coor3 = Vector2i(2, 9)
var saw_atlas_coor4 = Vector2i(3, 9)
var saw_atlas_coor5 = Vector2i(0, 10)
var saw_atlas_coor6 = Vector2i(1, 10)
var saw_atlas_coor7 = Vector2i(2, 10)
var saw_atlas_coor8 = Vector2i(3, 10)

var og_mp_trail_id = 1.0
var bloody_mp_trail_id = 3.0
var mptrail_coor1 = Vector2i(0, 0)
var mptrail_coor2 = Vector2i(1, 0)
var mptrail_coor3= Vector2i(2, 0)

var under_player = Vector2i(0, 0)
var left_player = Vector2i(0, 0)
var right_player = Vector2i(0 , 0)

#flipped
var flipped_under_player = Vector2i(0, 0)
var flipped_left_wall = Vector2i(0, 0)
var flipped_right_wall = Vector2i(0, 0)

var flipped_og_under_front_coor = Vector2i(5, 5)
var flipped_og_under_mid_coor = Vector2i(4, 5)
var flipped_og_under_back_coor = Vector2i(3, 5)
var flipped_b_under_front_coor = Vector2i(16, 2)
var flipped_b_under_mid_coor = Vector2i(randi_range(10, 15), 2)
var flipped_b_under_back_coor = Vector2i(9, 2)

var flipped_left_wall_mid_coor = Vector2i(5, 4)
var flipped_left_wall_down_coor = Vector2i(5, 3)
var flipped_b_left_wall_top = Vector2i(7, 6)
var flipped_b_left_wall_mid = Vector2i(7, 5)
var flipped_b_left_wall_down = Vector2i(7, 4)

var flipped_right_wall_mid_coor = Vector2i(3, 4)
var flipped_right_wall_down_coor = Vector2i(3, 3)
var flipped_b_right_wall_top = Vector2i(6, 6)
var flipped_b_right_wall_mid = Vector2i(6, 5)
var flipped_b_right_wall_down = Vector2i(6, 4)

var flipped_top_left_painted = Vector2i(12, 6)
var flipped_top_right_painted = Vector2i(11, 6)

#flipped saw blade trail tiles
var saw_trail1 = Vector2i(0, 11)
var saw_trail2 = Vector2i(1, 11)
var saw_trail3 = Vector2i(2, 11)
var saw_trail4 = Vector2i(3, 11)
var saw_trail5 = Vector2i(0, 12)
var saw_trail6 = Vector2i(1, 12)
var saw_trail7 = Vector2i(2, 12)
var saw_trail8 = Vector2i(3, 12)

# cement ground tiles
var flipped_cement_top_left_painted = Vector2i(16, 4)
var flipped_cement_top_right_painted = Vector2i(15, 4)

var flipped_cement_under_front_coor = Vector2i(11, 5)
var flipped_cement_under_mid_coor = Vector2i(10, 5)
var flipped_cement_under_back_coor = Vector2i(9, 5)
var flipped_cement_b_under_front= Vector2i(8, 1)
var flipped_cement_b_under_mid_coor = Vector2i(7, 1)
var flipped_cement_b_under_back_coor = Vector2i(0, 1)

var flipped_cement_left_wall_mid_coor = Vector2i(11, 4)
var flipped_cement_left_wall_down_coor = Vector2i(11, 3)
var flipped_cement_b_left_wall_top = Vector2i(3, 4)
var flipped_cement_b_left_wall_mid = Vector2i(3, 3)
var flipped_cement_b_left_wall_down = Vector2i(3, 2)

var flipped_cement_right_wall_mid_coor = Vector2i(9, 4)
var flipped_cement_right_wall_down_coor = Vector2i(9, 3)
var flipped_cement_b_right_wall_top = Vector2i(2, 4)
var flipped_cement_b_right_wall_mid = Vector2i(2, 3)
var flipped_cement_b_right_wall_down = Vector2i(2, 2)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomX = randf_range(-500, 500)
	randomY = randf_range(-500, 500)
	apply_central_impulse(Vector2(randomX, randomY))
	
	main = get_tree().root.get_node("Main")

func _process(delta):
	if main.isEnded:
		queue_free()
	if is_gravity_changed:
		self.gravity_scale = -1.0
	else :
		self.gravity_scale = 1.0
	
	update_tiles()
	update_flipped_tiles()
		
func update_tiles():
	parts_tile_pose = tile_map.local_to_map(self.global_position)
	
	#set og under ground to bloody tiles	
	under_player = Vector2i(parts_tile_pose.x, parts_tile_pose.y + 1)
	var cell_atlas_core_down = tile_map.get_cell_atlas_coords(0, under_player)
	var cell_source_id = tile_map.get_cell_source_id(0, under_player)
	if cell_atlas_core_down == og_left_ground_atlas && cell_source_id == set_original_source_id:
		tile_map.set_cell(0, under_player, set_bloody_source_id, bloody_og_left_ground_atlas)
	elif cell_atlas_core_down == og_mid_ground_atlas && cell_source_id == set_original_source_id:
		tile_map.set_cell(0, under_player, set_bloody_source_id, random_bloody_atlas)
	elif cell_atlas_core_down == og_right_ground_atlas && cell_source_id == set_original_source_id:
		tile_map.set_cell(0, under_player, set_bloody_source_id, bloody_og_right_ground_atlas)
	elif cell_atlas_core_down == og_left_top_atlas && cell_source_id == set_bloody_source_id:
		tile_map.set_cell(0, under_player, set_bloody_source_id, top_and_left_painted_atlas)
	elif cell_atlas_core_down == og_right_top_atlas && cell_source_id == set_bloody_source_id:
		tile_map.set_cell(0, under_player, set_bloody_source_id, top_and_right_painted_atlas)
	else:
		pass
	
	#set og left ground to bloody tiles	
	left_player = Vector2i(parts_tile_pose.x - 1, parts_tile_pose.y)
	var cell_atlas_core_left = tile_map.get_cell_atlas_coords(0, left_player)
	var left_cell_id = tile_map.get_cell_source_id(0, left_player)
	if cell_atlas_core_left == og_left_top_ground && left_cell_id == set_original_source_id:
		tile_map.set_cell(0, left_player, set_bloody_source_id, og_left_top_atlas)
	elif cell_atlas_core_left == og_left_mid_ground && left_cell_id == set_original_source_id:
		tile_map.set_cell(0, left_player, set_bloody_source_id, og_left_mid_atlas)
	elif cell_atlas_core_left == og_left_down_ground && left_cell_id == set_original_source_id:
		tile_map.set_cell(0, left_player, set_bloody_source_id, og_left_down_atlas)
	elif cell_atlas_core_left == bloody_og_right_ground_atlas && left_cell_id == set_bloody_source_id:
		tile_map.set_cell(0, left_player, set_bloody_source_id, top_and_left_painted_atlas)
	else:
		pass
		
	#set og right ground to bloody tiles	
	right_player = Vector2i(parts_tile_pose.x + 1, parts_tile_pose.y)
	var right_cell_id = tile_map.get_cell_source_id(0, right_player)
	var cell_atlas_core_right = tile_map.get_cell_atlas_coords(0, right_player)
	if cell_atlas_core_right == og_right_top_ground && right_cell_id == set_original_source_id:
		tile_map.set_cell(0, right_player, set_bloody_source_id, og_right_top_atlas)
	elif cell_atlas_core_right == og_right_mid_ground && right_cell_id == set_original_source_id:
		tile_map.set_cell(0, right_player, set_bloody_source_id, og_right_mid_atlas)
	elif cell_atlas_core_right == og_right_down_ground && right_cell_id == set_original_source_id:
		tile_map.set_cell(0, right_player, set_bloody_source_id, og_right_down_atlas)
	elif cell_atlas_core_right == bloody_og_left_ground_atlas && right_cell_id == set_bloody_source_id:
		tile_map.set_cell(0, right_player, set_bloody_source_id, top_and_right_painted_atlas)
	else:
		pass
		
		
	#change sawblade tiles
	var cell_atlas_core_body = tile_map.get_cell_atlas_coords(0, parts_tile_pose)
	var player_cell_source_id = tile_map.get_cell_source_id(0, parts_tile_pose)
	if cell_atlas_core_body == saw_atlas_core1:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_core1)
	elif  cell_atlas_core_body == saw_atlas_core2:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_core2)
	elif  cell_atlas_core_body == saw_atlas_core3:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_core3)
	elif  cell_atlas_core_body == saw_atlas_core4:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_core4)	
	elif  cell_atlas_core_body == saw_atlas_core5:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_core5)
	elif  cell_atlas_core_body == saw_atlas_core6:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_core6)
	elif  cell_atlas_core_body == saw_atlas_core7:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_core7)
	elif  cell_atlas_core_body == saw_atlas_core8:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_core8)
	elif cell_atlas_core_body == saw_atlas_coor1:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_coor1)
	elif cell_atlas_core_body == saw_atlas_coor2:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_coor2)
	elif cell_atlas_core_body == saw_atlas_coor3:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_coor3)
	elif cell_atlas_core_body == saw_atlas_coor4:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_coor4)
	elif cell_atlas_core_body == saw_atlas_coor5:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_coor5)
	elif cell_atlas_core_body == saw_atlas_coor6:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_coor6)
	elif cell_atlas_core_body == saw_atlas_coor7:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_coor7)
	elif cell_atlas_core_body == saw_atlas_coor8:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_atlas_coor8)
	else:
		pass
	
	if cell_atlas_core_body == mptrail_coor1 && player_cell_source_id == og_mp_trail_id:
		tile_map.set_cell(0, parts_tile_pose, bloody_mp_trail_id, mptrail_coor1)
	elif cell_atlas_core_body == mptrail_coor2 && player_cell_source_id == og_mp_trail_id:
		tile_map.set_cell(0, parts_tile_pose, bloody_mp_trail_id, mptrail_coor2)
	elif cell_atlas_core_body == mptrail_coor3 && player_cell_source_id == og_mp_trail_id:
		tile_map.set_cell(0, parts_tile_pose, bloody_mp_trail_id, mptrail_coor3)
	else:
		pass
		
func update_flipped_tiles():
	#flipped top ground
	flipped_under_player = Vector2i(parts_tile_pose.x, parts_tile_pose.y - 1)
	var cell_atlas = tile_map.get_cell_atlas_coords(0, flipped_under_player)
	var cell_id = tile_map.get_cell_source_id(0, flipped_under_player)
	if cell_atlas == flipped_og_under_front_coor && cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_b_under_front_coor)
	elif cell_atlas == flipped_og_under_mid_coor && cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_b_under_mid_coor)
	elif cell_atlas == flipped_og_under_back_coor && cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_b_under_back_coor)
	elif cell_atlas == flipped_b_left_wall_top && cell_id == set_bloody_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_top_left_painted)
	elif cell_atlas == flipped_b_right_wall_top && cell_id == set_bloody_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_top_right_painted)
	elif cell_atlas == flipped_cement_under_front_coor && cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_cement_b_under_front)
	elif cell_atlas == flipped_cement_under_mid_coor && cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_cement_b_under_mid_coor)
	elif cell_atlas == flipped_cement_under_back_coor && cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_cement_b_under_back_coor)
	elif cell_atlas == flipped_cement_b_left_wall_top && cell_id == set_bloody_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_cement_top_left_painted)
	elif cell_atlas == flipped_cement_b_right_wall_top && cell_id == set_bloody_source_id:
		tile_map.set_cell(0, flipped_under_player, set_bloody_source_id, flipped_cement_top_right_painted)
	else:
		pass
	
	#flipped left ground
	flipped_left_wall = Vector2i(parts_tile_pose.x - 1, parts_tile_pose.y)
	var left_wall_cell_atlas = tile_map.get_cell_atlas_coords(0, flipped_left_wall)
	var left_wall_cell_id = tile_map.get_cell_source_id(0, flipped_left_wall)
	if left_wall_cell_atlas == flipped_og_under_front_coor && left_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_left_wall, set_bloody_source_id, flipped_b_left_wall_top)
	elif left_wall_cell_atlas == flipped_left_wall_mid_coor && left_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_left_wall, set_bloody_source_id, flipped_b_left_wall_mid)
	elif left_wall_cell_atlas == flipped_left_wall_down_coor && left_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_left_wall, set_bloody_source_id, flipped_b_left_wall_down)
	elif left_wall_cell_atlas == flipped_b_under_front_coor && left_wall_cell_id == set_bloody_source_id:
		tile_map.set_cell(0, flipped_left_wall, set_bloody_source_id, flipped_top_left_painted)
	elif left_wall_cell_atlas == flipped_cement_under_front_coor && left_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_left_wall, set_bloody_source_id, flipped_cement_b_left_wall_top)
	elif left_wall_cell_atlas == flipped_cement_left_wall_mid_coor && left_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_left_wall, set_bloody_source_id, flipped_cement_b_left_wall_mid)
	elif left_wall_cell_atlas == flipped_cement_left_wall_down_coor && left_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_left_wall, set_bloody_source_id, flipped_cement_b_left_wall_down)
	elif left_wall_cell_atlas == flipped_cement_b_under_front && left_wall_cell_id == set_bloody_source_id:
		tile_map.set_cell(0, flipped_left_wall, set_bloody_source_id, flipped_cement_top_left_painted)
	else:
		pass
	
		
	#flipped right ground
	flipped_right_wall = Vector2i(parts_tile_pose.x + 1, parts_tile_pose.y)
	var right_wall_cell_atlas = tile_map.get_cell_atlas_coords(0, flipped_right_wall)
	var right_wall_cell_id = tile_map.get_cell_source_id(0, flipped_right_wall)
	if right_wall_cell_atlas == flipped_og_under_back_coor && right_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_right_wall, set_bloody_source_id, flipped_b_right_wall_top)
	elif right_wall_cell_atlas == flipped_right_wall_mid_coor && right_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_right_wall, set_bloody_source_id, flipped_b_right_wall_mid)
	elif right_wall_cell_atlas == flipped_right_wall_down_coor && right_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_right_wall, set_bloody_source_id, flipped_b_right_wall_down)
	elif right_wall_cell_atlas == flipped_b_under_back_coor && right_wall_cell_id == set_bloody_source_id:
		tile_map.set_cell(0, flipped_right_wall, set_bloody_source_id, flipped_top_right_painted)
	elif right_wall_cell_atlas == flipped_cement_under_back_coor && right_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_right_wall, set_bloody_source_id, flipped_cement_b_right_wall_top)
	elif right_wall_cell_atlas == flipped_cement_right_wall_mid_coor && right_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_right_wall, set_bloody_source_id, flipped_cement_b_right_wall_mid)
	elif right_wall_cell_atlas == flipped_cement_right_wall_down_coor && right_wall_cell_id == set_original_source_id:
		tile_map.set_cell(0, flipped_right_wall, set_bloody_source_id, flipped_cement_b_right_wall_down)
	elif right_wall_cell_atlas == flipped_cement_b_under_back_coor && right_wall_cell_id == set_bloody_source_id:
		tile_map.set_cell(0, flipped_right_wall, set_bloody_source_id, flipped_cement_top_right_painted)
	else:
		pass
		
	# flipped sawblade trail
	var saw_cell_coor = tile_map.get_cell_atlas_coords(0, parts_tile_pose)
	var saw_cell_id = tile_map.get_cell_source_id(0, parts_tile_pose)
	if saw_cell_coor == saw_trail1 && saw_cell_id == set_original_source_id:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_trail1)
	elif saw_cell_coor == saw_trail2 && saw_cell_id == set_original_source_id:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_trail2)
	elif saw_cell_coor == saw_trail3 && saw_cell_id == set_original_source_id:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_trail3)
	elif saw_cell_coor == saw_trail4 && saw_cell_id == set_original_source_id:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_trail4)
	elif saw_cell_coor == saw_trail5 && saw_cell_id == set_original_source_id:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_trail5)
	elif saw_cell_coor == saw_trail6 && saw_cell_id == set_original_source_id:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_trail6)
	elif saw_cell_coor == saw_trail7 && saw_cell_id == set_original_source_id:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_trail7)
	elif saw_cell_coor == saw_trail8 && saw_cell_id == set_original_source_id:
		tile_map.set_cell(0, parts_tile_pose, set_bloody_source_id, saw_trail8)
	
