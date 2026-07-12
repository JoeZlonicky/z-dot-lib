class_name MathUtility


## Returns a random normalized [Vector2]
static func random_direction() -> Vector2:
	var angle := randf() * TAU
	return Vector2.from_angle(angle)


## Returns a random [Vector2] in a circle's area
static func random_point_in_radius(center: Vector2, radius: float) -> Vector2:
	var distance: float = randf() * radius
	var offset: Vector2 = random_direction() * distance
	return center + offset


## Returns a random [Vector2] on a circle's circumference
static func random_point_on_circumference(center: Vector2, radius: float) -> Vector2:
	var offset: Vector2 = random_direction() * radius
	return center + offset


## A lerp that behaves consistently accross different framerates
static func delta_lerp(a: float, b: float, speed: float, delta: float) -> float:
	return lerpf(a, b, 1.0 - exp(-speed * delta))


## Rotate a [Vector2] towards another [Vector2] by a given number of radians
static func rotate_towards_vector(v: Vector2, target: Vector2, rad: float) -> Vector2:
	var current_angle := v.angle()
	var target_angle := target.angle()
	var new_angle := move_toward(current_angle, target_angle, rad)
	return Vector2.from_angle(new_angle)
