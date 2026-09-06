shader_type canvas_item;

uniform vec2 mouse_position;
uniform float radius = 150.0;
uniform float softness = 50.0;

void fragment() {
	vec2 pixel_position = FRAGCOORD.xy;

	float distance_from_mouse = distance(pixel_position, mouse_position);

	float alpha = smoothstep(
		radius - softness,
		radius,
		distance_from_mouse
	);

	COLOR = vec4(0.0, 0.0, 0.0, alpha * 0.95);
}