shader_type canvas_item;
uniform float redness;
uniform vec4 color1 = vec4(1,0,0,1);
uniform vec4 color2 = vec4(1,0,.5,1);
uniform float maxRedness = 0.6;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	vec4 mixColor;
	if(redness<50.){
		mixColor = mix(vec4(1,1,1,1),color1,redness/50.);
	} else{
		mixColor = mix(color1,color2,(redness-50.)/50.);
	}
	COLOR = mix(tex_color,mixColor,redness/100.*maxRedness-clamp(UV.y-1.,0,1000))*(1.-redness/200.);
	COLOR.a = tex_color.a;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
