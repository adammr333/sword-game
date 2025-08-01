extends Node

@onready var gameUI: Node = $"../../SpringArmPivot/SpringArm3D/Camera3D/GameUI"
@onready var gameUISquares: Node = $"../../SpringArmPivot/SpringArm3D/Camera3D/GameUI/DirectionSquares"

var swordReady: bool


func _ready() -> void:
	swordReady = false
	gameUISquares.visible = false
	pass


func _physics_process(delta: float) -> void:
	if swordReady:
		gameUISquares.visible = true
	else:
		gameUISquares.visible = false
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		swordReady = true
		print("Sword is Ready")
	if event.is_action_released("left_click"):
		swordReady = false
		print("Sword is Not Ready")
	if event is InputEventMouseMotion:
		if event.relative.x < 0:
			print("left")
		if event.relative.x > 0:
			print("right")
		if event.relative.y < 0:
			print("up")
		if event.relative.y > 0:
			print("down")
		print(event.relative)
	pass
