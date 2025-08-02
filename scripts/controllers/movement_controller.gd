extends Node

@onready var character: Node = $"../.."
@onready var armature: Node = $"../../PlayerBody"
@onready var cameraController: Node = $"../CameraController"

@export_group("Movement")
@export var moveSpeed: float = 5.0
@export var acceleration: float = 15.0
@export var rotationSpeed: float = 15.0
@export var jumpImpulse: float = 10.0 #jump strength

var lastMovementDirection: Vector3 = Vector3.FORWARD #used to make sure that character does not turn when the movement keys are released
var gravity: float = 30.0


func _physics_process(delta: float) -> void:
	var verticalVelocity: float = character.velocity.y
	character.velocity.y = 0.0
	character.velocity.y = verticalVelocity - gravity * delta
	#var isStartingJump: bool = Input.is_action_just_pressed("jump") and is_on_floor()
	#if isStartingJump:
		#velocity.y += jumpImpulse
	var moveInput: Vector2 = Input.get_vector("left", "right", "up", "down")
	var moveDirection = (character.transform.basis * Vector3(moveInput.x, 0, moveInput.y)).normalized()
	moveDirection = moveDirection.rotated(Vector3.UP, cameraController.cameraPivot.rotation.y)
	character.velocity = character.velocity.move_toward(moveDirection * moveSpeed, acceleration * delta)
	if moveDirection.length() > 0.1: #when the character is moving
		lastMovementDirection = moveDirection #stores the movement direction
	var targetAngle: float = Vector3.FORWARD.signed_angle_to(lastMovementDirection, Vector3.UP)
	#^assigns the angle that the characters needs to turn toward (the target angle, the axis that the character rotates on)
	#armature.global_rotation.y = lerp_angle(armature.global_rotation.y, targetAngle, rotationSpeed * delta)
	#^moves the characters rotation angle from the current angle toward the targetAngle at the rate of rotationSpeed multiplied by delta
	armature.global_rotation.y = lerp_angle(armature.global_rotation.y, targetAngle, rotationSpeed * delta)
	character.move_and_slide()
	pass
