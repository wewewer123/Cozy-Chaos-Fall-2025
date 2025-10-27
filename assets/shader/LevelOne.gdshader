shader_type spatial;

uniform sampler2D albedo_texture : source_color;
uniform float tiling = 1.0;

void fragment() {
	// TODO: Put this into a script
	// This calculation is here for later, to sync the floor
	// and lane objects so they move at the same speed.
	// It should be refactored into a separate script later
	// if we implement different object movement speeds.
	vec2 meshSizeInMeter = vec2(2.0f, 2.0f);
	vec2 transformScale = vec2(50,50);
	vec2 objectMovemenSpeed = vec2(0, -20);
	vec2 uv_velocity = objectMovemenSpeed / (meshSizeInMeter * transformScale);

	// Called for every pixel the material is visible on.
	vec2 scrolled_uv = UV * tiling + uv_velocity * TIME;
	vec3 tex_color = texture(albedo_texture, scrolled_uv).rgb;
	ALBEDO = tex_color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
