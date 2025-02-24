extends CharacterBody3D
class_name Player

#player attribute variables.
var speed = 0
var max_endurance = clamp(100, 0, 100)
var player_health  = clamp(100, 0, 100)
const CROUCH_SPEED  = 1.5
const WALK_SPEED = 2.0
const RECEPTACLE_SPEED  = 3.5
const JOG_SPEED = 5.0
const SPRINT_SPEED  = 7.0
const JUMP_VELOCITY  = 4.5
const SENSITIVTY  = 0.01
var pull_power : int = 35

#boolean/state machine/group variables.
var endurance_check : bool = true
var picked_up_object
var hit_detec_check


#headbob variables.
const BOB_FREQ : float = 2.0
const BOB_AMP : float= 0.08
var t_bob : float = 0.0

#variables for importing nodes/scenes.
@onready var player = $"."
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var pick_up = $Head/Camera3D/Pickup
@onready var hold = $Head/Camera3D/Hold
@onready var player_mesh = $PlayerMesh
@onready var player_shape = $PlayerShape
@onready var item_drop = $Head/Camera3D/itemdrop



#ready function.
func _ready():
	#intializes the mouse for first person.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#signal connections through event class.
	Events.connect("call_receptacle_speed", Callable(self, "receptacle_speed"))
	Events.connect("call_normal_speed", Callable(self, "normal_speed"))
	#intializations for effect value bars.
	HealthBar.value = player_health
	
	#function for handling mouse when moving/rotating the camera.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVTY)
		camera.rotate_x(-event.relative.y * SENSITIVTY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(60))
		
	#function for picking up objects around the world.
func pick_up_object():
	var collider = pick_up.get_collider()
	if collider != null and collider is PickupComponent: 
		print(collider.get_name())
		picked_up_object = collider
	#function for dropping picked up objects.
func drop_object():
	if picked_up_object != null:
		picked_up_object = null

	#"main"
func _physics_process(delta: float):
	
	#for picked up objects to be dropped if moved away from player too far.	
	if picked_up_object != null and global_position.distance_to(picked_up_object.global_position) >= 3:
		drop_object()
	#locks the rotation of picked up objects.
	if picked_up_object != null:
		picked_up_object.get_parent().lock_rotation = true
	#sets the velocity of the picked up object at the time of picking up to pull power. 
	#it subtracts the hold and objects global position and multiplies them by pull power.
	if picked_up_object != null:
		var a = picked_up_object.global_position
		var b = hold.global_position
		picked_up_object.get_parent().set_linear_velocity((b-a) * pull_power)
	#this is for picking up and dropping objects if E is pressed.
	if Input.is_action_just_pressed("interact"):
		if picked_up_object == null:
			pick_up_object()
		elif picked_up_object != null:
			drop_object()
	
	#checks hit detection boolean to damage the player.
	if hit_detec_check == true:
		HealthBar.value = player_health
		player_health -= 1
		
	#allows the player to crouch by reducing the y axis. endurance check to avoid sprinting while crounching.
	if Input.is_action_pressed("crouch"):
		speed = CROUCH_SPEED
		player_mesh.position.y = -0.2
		player_shape.shape.height = 1.5
		endurance_check = false
	else:
		player_mesh.position.y = 0
		player_shape.position.y = 0
		
		
	#add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#add walking and sprinting
	if Input.is_action_pressed("sprint") and endurance_check == true:
		speed = SPRINT_SPEED
	elif Input.is_action_pressed("walk"):
		speed = WALK_SPEED
		
	#handles jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#get the input direction and handle the movement/deceleration.
	#as good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#allows the character to move and adds intertia using lerp.
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
	#adds sprinting and reduces endurance while sprinting.
	if Input.is_action_pressed("sprint") and endurance_check == true and input_dir and is_on_floor():
		max_endurance -= 0.5
		StaminaBar.value = max_endurance
	#increases stamina slowly overtime when not sprinting.
	if max_endurance < 100:
		max_endurance += 0.05
		StaminaBar.value = max_endurance
	#if the player is standing still, this increases endurance faster.
	if max_endurance < 100 and not input_dir:
		max_endurance += 0.1
		StaminaBar.value = max_endurance
		
	#head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = headbob(t_bob)
	
	move_and_slide()
	
	#function for headbob to be used for previous algorithm.
func headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	#function for hit detection on player collision shape being entered.
func _on_player_hitbox_body_entered(body):
	if body is Enemy:
		hit_detec_check = true

	#function for hit detection on player collision shape being exited.
func _on_player_hitbox_body_exited(_body):
	hit_detec_check = false
	
	#function reducing the speed and disabling sprint while holding receptacle.
func receptacle_speed():
	speed = RECEPTACLE_SPEED
	endurance_check = false
	#function for normal jog speed and allowing sprint.
func normal_speed():
	speed = JOG_SPEED
	endurance_check = true
