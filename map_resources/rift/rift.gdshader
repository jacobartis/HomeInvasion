shader_type spatial;
render_mode unshaded;

uniform bool y_billboard = false;
uniform float opacity: hint_range(0.0, 1.0, 0.1) = 1.0;
uniform vec2 resolution = vec2(600.0, 400.0);
uniform vec3 spiral_color: source_color = vec3(0.2, 0.6, 0.3);
uniform float frequency: hint_range(1.0, 10.0, 0.1) = 8.0;
uniform float speed: hint_range(1.0, 20.0, 0.1) = 8.0;
uniform float brightness: hint_range(1.0, 10.0, 0.1) = 5.0;
uniform float balance: hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float octaves: hint_range(1.0, 10.0, 1.0) = 4.0;

void vertex() {
	if (y_billboard == true) {
		MODELVIEW_MATRIX = VIEW_MATRIX * mat4(vec4(normalize(cross(vec3(0.0, 1.0, 0.0), INV_VIEW_MATRIX[2].xyz)), 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(normalize(cross(INV_VIEW_MATRIX[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0), MODEL_MATRIX[3]);
	}
	else {
		MODELVIEW_MATRIX = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
	}
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

float draw_spiral(vec2 uv, float rotation) {
	float uv_radius = length(uv);
	float uv_phi = atan(uv.y, uv.x) + rotation;
	float spiral_phi = (log(uv_radius) * frequency - uv_phi) / TAU;
	float spiral_ceil_radius = exp((TAU * ceil(spiral_phi) + uv_phi) / frequency);
	float spiral_floor_radius = exp((TAU * floor(spiral_phi) + uv_phi) / frequency);
	return mix(mix(abs(uv_radius - spiral_ceil_radius), abs(uv_radius - spiral_floor_radius), balance), max(abs(uv_radius - spiral_ceil_radius), abs(uv_radius - spiral_floor_radius)), balance);
}

void fragment() {
	vec2 uv = UV - 0.5;
	uv *= resolution.x / resolution.y;
	float spiral = 0.0;
	for (float i = 0.0; i < octaves; i += 1.0) {
		spiral += draw_spiral(uv, TIME * speed * (0.5 + sin(i)));
	}
	spiral /= octaves;
	vec3 color = spiral * spiral_color;
	ALBEDO = vec3(color * brightness);
	ALPHA = smoothstep(-.5,.5,opacity-4.0*(uv.x*uv.x+uv.y*uv.y));
}
