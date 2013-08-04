//
//  EmitterTemplate.h
//  GLParticles1
//
//  Created by RRC on 5/2/13.
//  Copyright (c) 2013 Karl Andreas Johansen. All rights reserved.
//

#define NUM_PARTICLES 360

typedef struct Particle
{
    float       theta;
    float       shade[3];
}
Particle;

typedef struct Emitter
{
    Particle    particles[NUM_PARTICLES];
    int         k;
    float       color[3];
}
Emitter;

Emitter emitter = {0.0f};
