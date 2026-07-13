

vec4 effect(vec4 colour,Image texture,vec2 tc,vec2 screen_coords)
{
    tc.x = 1.0 - tc.x;
    vec4 tex=Texel(texture,tc);
    
    return tex;
}

#ifdef VERTEX
vec4 position(mat4 transform_projection,vec4 vertex_position)
{
    return transform_projection*vertex_position;
}
#endif