extends Node3D

@onready var left_arm = $LeftArmBody
@onready var right_arm = $RightArmBody
@onready var left_leg = $LeftLegBody
@onready var right_leg = $RightLegBody
@onready var head = $HeadBody

var body_part_behavior_num = randi_range(0, 4)


func body_part_behavior():
	if is_instance_valid(left_arm) && is_instance_valid(right_arm) && is_instance_valid(left_leg) && is_instance_valid(right_leg) && is_instance_valid(head):
		match body_part_behavior_num:
			0: left_arm.queue_free()
			1: right_arm.queue_free()
			2: left_leg.queue_free()
			3: right_leg.queue_free()
			4: head.queue_free()
