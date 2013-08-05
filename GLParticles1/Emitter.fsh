// Fragment shader

static const char* EmitterFS = STRINGIFY
(
 
 // Uniforms
 uniform highp float     u_Time;
 uniform highp vec3      u_eColorStart;
 uniform highp vec3      u_eColorEnd;
 uniform sampler2D       u_Texture;
 
 // Varying
 varying highp vec3      v_pColorOffset;
 varying highp float     v_Growth;
 varying highp float     v_Decay;

 void main(void)
{
    highp vec4 texture = texture2D(u_Texture, gl_PointCoord);
    
    // Color
    highp vec4 color = vec4(1.0);
    
    // If blast is growing
    if(u_Time < v_Growth)
    {
        // 1
        color.rgb = u_eColorStart;
    }
    
    // Else if blast is decaying
    else
    {
        highp float time = (u_Time - v_Growth) / v_Decay;
        
        // 2
        color.rgb = mix(u_eColorStart, u_eColorEnd, time);
    }
    
    // 3
    color.rgb += v_pColorOffset;
    color.rgb = clamp(color.rgb, vec3(0.0), vec3(1.0));
    
    // Required OpenGL ES 2.0 outputs
    gl_FragColor = texture * color;
}
 
);
