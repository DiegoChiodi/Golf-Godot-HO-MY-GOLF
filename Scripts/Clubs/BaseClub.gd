extends Node2D
class_name BaseClub

var player : Player

var spr_golfClub

#Mouse
var pressioned = false
#Stats
var longDamage : float = 0
var attackWait : float = 1.0
var attackDelay : float =  1.0
var angle = 0.0
var anglePermition = true
var damage : float = 0

func _process(delta: float) -> void:
	var press = Input.is_action_just_pressed("left_click")
	var pressed = Input.is_action_pressed("left_click")
	var solt = Input.is_action_just_released("left_click")
	
	attackWait += delta
	if press:
		pressMouse()
	if anglePermition:
		setAngle()
	
	self.angle = int(self.rotation_degrees) % 360
	if (0 > self.angle):
		self.angle += 360

func pressMouse () -> void:
	if self.attackWait > self.attackDelay and !self.player.colBall and !self.player.drivingCart :
		attackGo()
		attackWait = 0.0
	
func attackGo() -> void:
	pass
func setAngle() -> void:
	look_at(get_global_mouse_position())

func setup(_player : Player) -> void:
	self.player = _player
