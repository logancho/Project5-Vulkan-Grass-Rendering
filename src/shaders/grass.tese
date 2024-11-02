#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) in vec4 tese_v0[];
layout(location = 1) in vec4 tese_v1[];
layout(location = 2) in vec4 tese_v2[];

layout(location = 0) out vec2 fs_uv;

void main() {

    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
// Extract Parameters
    float direction = tese_v0[0].w;
    float height = tese_v1[0].w;
    float width = tese_v2[0].w;
    
// De casteljau's for Bezier Curve point interpolation, copied from the paper:

    vec3 v0 = tese_v0[0].xyz;
    vec3 v1 = tese_v1[0].xyz;
    vec3 v2 = tese_v2[0].xyz;

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);

    vec3 t0 = normalize(b - a);

// bitangent, perpendicular to plane tangent along the width of the 
    vec3 t1 = normalize(vec3(-cos(direction), 0, sin(direction)));
    
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    float t = u + 0.5 * u * v; // basic t from the paper
    vec3 pos = mix(c0, c1, t); //lerp
    
    gl_Position = camera.proj * camera.view * vec4(pos, 1.0);

    fs_uv = vec2(u, v);
}
