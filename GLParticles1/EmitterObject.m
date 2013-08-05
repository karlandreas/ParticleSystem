//
//  EmitterObject.m
//  GLParticles1
//
//  Created by Super User on 05.08.13.
//  Copyright (c) 2013 Ricardo Rendon Cepeda. All rights reserved.
//

#import "EmitterObject.h"

@implementation EmitterObject {
    // Instance variables
    GLKVector2  _gravity;
    float       _life;
    float       _time;
}

- (id)initEmitterObject
{
    if(self = [super init])
    {
        // Initialize variables
        _gravity = GLKVector2Make(0.0f, 0.0f);
        _life = 0.0f;
        _time = 0.0f;
        
        // Load Shader
        [self loadShader];
        
        // Load Particle System
        [self loadParticleSystem];
    }
    return self;
}

- (void)renderWithProjection:(GLKMatrix4)projectionMatrix
{
    // Uniforms
    glUniformMatrix4fv(self.shader.u_ProjectionMatrix, 1, 0, projectionMatrix.m);
    glUniform2f(self.shader.u_Gravity, _gravity.x, _gravity.y);
    glUniform1f(self.shader.u_Time, _time);
    glUniform1f(self.shader.u_eRadius, self.emitter.eRadius);
    glUniform1f(self.shader.u_eVelocity, self.emitter.eVelocity);
    glUniform1f(self.shader.u_eDecay, self.emitter.eDecay);
    glUniform1f(self.shader.u_eSize, self.emitter.eSize);
    glUniform3f(self.shader.u_eColor, self.emitter.eColor.r, self.emitter.eColor.g, self.emitter.eColor.b);
    
    // Attributes
    glEnableVertexAttribArray(self.shader.a_pID);
    glEnableVertexAttribArray(self.shader.a_pRadiusOffset);
    glEnableVertexAttribArray(self.shader.a_pVelocityOffset);
    glEnableVertexAttribArray(self.shader.a_pDecayOffset);
    glEnableVertexAttribArray(self.shader.a_pSizeOffset);
    glEnableVertexAttribArray(self.shader.a_pColorOffset);
    
    glVertexAttribPointer(self.shader.a_pID, 1, GL_FLOAT, GL_FALSE, sizeof(Particle), (void*)(offsetof(Particle, pID)));
    glVertexAttribPointer(self.shader.a_pRadiusOffset, 1, GL_FLOAT, GL_FALSE, sizeof(Particle), (void*)(offsetof(Particle, pRadiusOffset)));
    glVertexAttribPointer(self.shader.a_pVelocityOffset, 1, GL_FLOAT, GL_FALSE, sizeof(Particle), (void*)(offsetof(Particle, pVelocityOffset)));
    glVertexAttribPointer(self.shader.a_pDecayOffset, 1, GL_FLOAT, GL_FALSE, sizeof(Particle), (void*)(offsetof(Particle, pDecayOffset)));
    glVertexAttribPointer(self.shader.a_pSizeOffset, 1, GL_FLOAT, GL_FALSE, sizeof(Particle), (void*)(offsetof(Particle, pSizeOffset)));
    glVertexAttribPointer(self.shader.a_pColorOffset, 3, GL_FLOAT, GL_FALSE, sizeof(Particle), (void*)(offsetof(Particle, pColorOffset)));
    
    // Draw particles
    glDrawArrays(GL_POINTS, 0, NUM_PARTICLES);
    glDisableVertexAttribArray(self.shader.a_pID);
    glDisableVertexAttribArray(self.shader.a_pRadiusOffset);
    glDisableVertexAttribArray(self.shader.a_pVelocityOffset);
    glDisableVertexAttribArray(self.shader.a_pDecayOffset);
    glDisableVertexAttribArray(self.shader.a_pSizeOffset);
    glDisableVertexAttribArray(self.shader.a_pColorOffset);
}

- (void)updateLifeCycle:(float)timeElapsed
{
    _time += timeElapsed;
    
    if(_time > _life)
        _time = 0.0f;
}

- (void)loadShader
{
    self.shader = [[EmitterShader alloc] init];
    [self.shader loadShader];
    glUseProgram(self.shader.program);
}

// 1
- (float)randomFloatBetween:(float)min and:(float)max
{
    float range = max - min;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * range) + min;
}

- (void)loadParticleSystem
{
    // 2
    Emitter newEmitter = {0.0f};
    
    // 3
    // Offset bounds
    float oRadius = 0.10f;      // 0.0 = circle; 1.0 = ring
    float oVelocity = 0.50f;    // Speed
    float oDecay = 0.25f;       // Time
    float oSize = 8.00f;        // Pixels
    float oColor = 0.25f;       // 0.5 = 50% shade offset
    
    // 4
    // Load Particles
    for(int i = 0; i < NUM_PARTICLES; i++)
    {
        // Assign a unique ID to each particle, between 0 and 360 (in radians)
        newEmitter.eParticles[i].pID = GLKMathDegreesToRadians(((float)i/(float)NUM_PARTICLES)*360.0f);
        
        // Assign random offsets within bounds
        newEmitter.eParticles[i].pRadiusOffset = [self randomFloatBetween:oRadius and:1.00f];
        newEmitter.eParticles[i].pVelocityOffset = [self randomFloatBetween:-oVelocity and:oVelocity];
        newEmitter.eParticles[i].pDecayOffset = [self randomFloatBetween:-oDecay and:oDecay];
        newEmitter.eParticles[i].pSizeOffset = [self randomFloatBetween:-oSize and:oSize];
        float r = [self randomFloatBetween:-oColor and:oColor];
        float g = [self randomFloatBetween:-oColor and:oColor];
        float b = [self randomFloatBetween:-oColor and:oColor];
        newEmitter.eParticles[i].pColorOffset = GLKVector3Make(r, g, b);
    }
    
    // 5
    // Load Properties
    newEmitter.eRadius = 0.75f;                                     // Blast radius
    newEmitter.eVelocity = 3.00f;                                   // Explosion velocity
    newEmitter.eDecay = 2.00f;                                      // Explosion decay
    newEmitter.eSize = 32.00f;                                      // Fragment size
    newEmitter.eColor = GLKVector3Make(1.00f, 0.50f, 0.00f);        // Fragment color
    
    // 6
    // Set global factors
    float growth = newEmitter.eRadius / newEmitter.eVelocity;       // Growth time
    _life = growth + newEmitter.eDecay + oDecay;                    // Simulation lifetime
    
    float drag = 10.00f;                                            // Drag (air resistance)
    _gravity = GLKVector2Make(0.00f, -9.81f*(1.0f/drag));           // World gravity
    
    // 7
    // Set Emitter & VBO
    self.emitter = newEmitter;
    GLuint particleBuffer = 0;
    glGenBuffers(1, &particleBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, particleBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(self.emitter.eParticles), self.emitter.eParticles, GL_STATIC_DRAW);
}

@end
