#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec2 fs_uv;


layout(location = 0) out vec4 outColor;


void main() {
    float v = fs_uv.y;
    outColor = vec4(0.2 + v * 0.3,0.2 + v * 0.8,0.3 + v * 0.3, 1.0);
}
