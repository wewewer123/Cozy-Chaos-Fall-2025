shader_type spatial;

uniform sampler2D albedo_texture : source_color;
uniform vec2 uv_scroll = vec2(0.0, 0.0);
uniform float tiling = 1.0;

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 scrolled_uv = UV * tiling + uv_scroll * TIME;
	vec3 tex_color = texture(albedo_texture, scrolled_uv).rgb;
	ALBEDO = tex_color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
