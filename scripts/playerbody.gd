extends CharacterBody3D

var speed = 0
var max_endurance = clamp(100, 0, 100)
var endurance_check 
const WALK_SPEED = 2.0
const JOG_SPEED = 5.0
const SPRINT_SPEED = 7.0
const JUMP_VELOCITY = 4.5
const SENSITIVTY = 0.01
var picked_up_object 
var pull_power = 6

# Headbob variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var pick_up = $Head/Camera3D/Pickup
@onready var hold = $Head/Camera3D/Hold


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVTY)
		camera.rotate_x(-event.relative.y * SENSITIVTY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(60))
	
func pick_up_object():
	var collider = pick_up.get_collider()
	if collider != null and collider is RigidBody3D:
		picked_up_object = collider
		
func drop_object():
	if picked_up_object != null:
		picked_up_object = null


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("grind") and picked_up_object != null:
		picked_up_object.queue_free()
		
	
	if picked_up_object != null:
		var a = picked_up_object.global_position
		var b = hold.global_position
		picked_up_object.set_linear_velocity((b-a) * pull_power)
	
	if Input.is_action_just_pressed("interact"):
		if picked_up_object == null:
			pick_up_object()
		elif picked_up_object != null:
			drop_object()
			
	if Input.is_action_pressed("sprint") and endurance_check == true:
		max_endurance -= 0.5
		StaminaBar.value = max_endurance
		print(max_endurance)
	if max_endurance < 100:
		max_endurance += 0.1
		print(max_endurance)
		
	if max_endurance > 0:
		endurance_check = true
	else:
		endurance_check = false
		
	if Input.is_action_pressed("crouch"):
		head.position.y = -0.3
		endurance_check = false
	else:
		head.position.y = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#Add walking and sprinting
	if Input.is_action_pressed("sprint") and endurance_check == true:
		speed = SPRINT_SPEED
	elif Input.is_action_pressed("walk"):
		speed = WALK_SPEED
	else:
		speed = JOG_SPEED

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#Allows the character to move and adds intertia using lerp.
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 6.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 6.0)

	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.5)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.5)
		
		
# Head Bob

	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	move_and_slide()
	
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	

	
