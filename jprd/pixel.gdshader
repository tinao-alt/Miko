shader_type canvas_item;

// Adjust these values in-game
uniform float bend_amount = 2.0; // How far grass bends
uniform float bend_speed = 5.0;  // How fast it wobbles
uniform vec2 bend_direction = vec2(1.0, 0.0); // Default bend (right)

void vertex() {
    // Only bend the top half of the sprite (UV.y > 0.5)
    if (UV.y > 0.5) {
        VERTEX.x += sin(TIME * bend_speed) * bend_amount * bend_direction.x;
        VERTEX.y += sin(TIME * bend_speed) * bend_amount * bend_direction.y * 0.5; // Less vertical bend
    }
}