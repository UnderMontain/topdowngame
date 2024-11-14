shader_type canvas_item;

uniform sampler2D overlay_tex: repeat_enable, filter_nearest;
uniform float scale = 0.006944444; // calculated by 1/texture size e.g. 1/144
varying vec2 world_position;

// Define the target color to match (approximately #BA1C21 in vec3 format)
const vec3 target_color = vec3(0.729, 0.11, 0.129);
uniform float tolerance = 0.05; // Adjust this value to make the match more or less strict

void vertex() {
    // Calculate the world position for use in the fragment shader
    world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
    // Check if the current color is close to the target color
    float color_match = step(distance(COLOR.rgb, target_color), tolerance);

    // Sample the overlay texture using the world position
    vec4 overlay_color = texture(overlay_tex, world_position * scale);

    // Combine the original color and overlay color based on the color match
    COLOR = mix(COLOR, overlay_color, color_match);
}