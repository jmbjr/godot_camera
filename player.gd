extends KinematicBody2D


#move variables
var MAX_SPEED = 300
var ACCELERATION = 1000 #huge because we apply delta to it
var FRICTION = 2000 #huge because we apply delta to it
var motion = Vector2.ZERO

#THIS SCRIPT WILL HANDLE SPRITE LOGIC
#To create a new sprite:
#1. inherit new scene from src/sprites/sprite.tscn
#1b. save as new sprite in sprites, eg player.tscn.
#1c. rename spritenode root node
#2. inherit new scene from src/obj/spriteobj.tscn
#2b. save as new spriteobj in obj (eg playerobj.tscn)
#2c. rename spriteobj to something that makes sense (playerobj)
#3. from FileSystem, drag playerobj.tscn to your player.tscn Scene
#3b. click root node and set nodepath for playerobj
#3c. click playerobj node and set sprite offset (usually half of the sprite height)
#4. in playerobj.tscn, use Aseprite Importer to load in json file for sprite
#4b. select the proper nodes and generate
#4c. due to an importer issue, all animations are created without looping, so enable looping for the anims that need it
#4d. save playerobj.tscn and go back to player.tscn and click the spriteobj


func _ready() -> void:
	var _connerr
	print("ready")
	add_to_group("sprites")

func _physics_process(delta: float) -> void:
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(FRICTION*delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()
	
func apply_friction(amount):
	if motion.length() >  amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(accel):
	motion +=accel
	motion = motion.clamped(MAX_SPEED)


	

