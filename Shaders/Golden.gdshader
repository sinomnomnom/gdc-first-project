shader_type canvas_item;
uniform vec4 gold = vec4(1.0, 0.9, 0.0, 1.0);
uniform float goldeness = 0;
uniform float maxGoldeness = 0.4;
uniform float shine_speed = 2;
uniform float shine_intensity = 0.9;
uniform float shine_hardness = 0;
uniform float shine_size = 0.2;
uniform float shine_frequency = 5;
uniform float shine_slope = 1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
    vec4 color = mix(tex_color, gold, (goldeness / 100.0) * maxGoldeness);

    float shine_position = sin((UV.y + UV.x * shine_slope) / shine_frequency + TIME * shine_speed) - 0.9;
    float shine_effect = smoothstep(shine_hardness, shine_size, shine_position);

    vec4 shine_color = tex_color.a * vec4(1.0, 1.0, 1.0, 1.0) * shine_intensity * shine_effect * 
                       pow((goldeness / 100.0), 3.0);
    COLOR = (color + shine_color) * tex_color.a;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
