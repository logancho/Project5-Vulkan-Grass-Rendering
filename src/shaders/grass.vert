
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

//Passing vertices to the tesselation stage (control first)

layout(location = 0) in vec4 in_v0;
layout(location = 1) in vec4 in_v1;
layout(location = 2) in vec4 in_v2;

layout(location = 0) out vec4 tesc_v0;
layout(location = 1) out vec4 tesc_v1;
layout(location = 2) out vec4 tesc_v2;

out gl_PerVertex {
    vec4 gl_Position;
};

vec4 multAndPreserveW(mat4 modelMat, vec4 inputVec) {
    vec4 outputVec = modelMat * inputVec;
    outputVec.w = inputVec.w;
    return outputVec;
}

void main() {

	// TODO: Write gl_Position and any other shader outputs
    tesc_v0 = multAndPreserveW(model, in_v0);
    tesc_v1 = multAndPreserveW(model, in_v1);
    tesc_v2 = multAndPreserveW(model, in_v2);

    gl_Position = tesc_v0;
}
