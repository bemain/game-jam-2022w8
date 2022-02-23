shader_type canvas_item;

uniform vec2 position = vec2(1, 0);

void fragment() {
	// How much should the position affect the perspective, higher -> more perspective on lower position
	float effect = 3.0;
	
	vec2 uv = UV;
	// map uv from [0.0, 1.0] to [-0.5, 0.5]
	uv -= vec2(0.5, 0.5);
	
	// Calculate distance to position
	vec2 dis = vec2(1.0) - uv * position;
	// Calculate depth
	float z = 1.0 + dis.x * dis.y * effect;
	// Correct perspective
	uv /= z;
	
	// Scale to fill
	vec2 max_vec = vec2(1.0) - 0.5 * abs(position);
	float scale = 1.0 + max_vec.x * max_vec.y * effect;
	uv *= scale;

	// Map uv back from [-0.5, 0.5] to [0.0, 1.0] 
	uv += vec2(0.5, 0.5);
	
	COLOR = texture(TEXTURE, uv);
	
	// if uv outside texture - then use transparent color
	if (uv.x < 0.0 || uv.x > 1.0) {
		COLOR.a = 0.0;
	} else if (uv.y < 0.0 || uv.y > 1.0) {
		COLOR.a = 0.0;
	}
}

