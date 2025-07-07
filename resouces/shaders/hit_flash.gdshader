shader_type canvas_item;

uniform float flash_intensity : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    
    vec3 white = vec3(1.0);
    vec3 blended_color = mix(original_color.rgb, white, flash_intensity);
    
    COLOR = vec4(blended_color, original_color.a);
}