shader_type canvas_item;

uniform sampler2D dissolvePattern;
uniform float progress : hint_range(0.0, 1.1) = 0;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	float patternVal = texture(dissolvePattern, UV).r;
	COLOR.a = step(progress, patternVal);
}