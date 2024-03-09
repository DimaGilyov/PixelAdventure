extends Path2D

@onready var path = $PathFollow2D
var step = 0.005
var isFlip = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if path.progress_ratio == 0 || path.progress_ratio == 1:
		isFlip = !isFlip
	if isFlip:
		path.progress_ratio -= step
	else:
		path.progress_ratio += step	
	
