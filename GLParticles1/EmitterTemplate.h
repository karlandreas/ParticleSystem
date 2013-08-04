//
//  EmitterTemplate.h
//  GLParticles1
//
//  Created by RRC on 5/2/13.
//  Copyright (c) 2013 Ricardo Rendon Cepeda. All rights reserved.
//

#define NUM_PARTICLES 360

typedef struct Particle
{
    float       theta;
}
Particle;

typedef struct Emitter
{
    Particle    particles[NUM_PARTICLES];
    int         k;
}
Emitter;

Emitter emitter = {0.0f};
