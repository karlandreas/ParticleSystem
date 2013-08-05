//
//  EmitterObject.h
//  GLParticles1
//
//  Created by Super User on 05.08.13.
//  Copyright (c) 2013 Ricardo Rendon Cepeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "EmitterShader.h"

#define NUM_PARTICLES 180

typedef struct Particle
{
    float       pID;
    float       pRadiusOffset;
    float       pVelocityOffset;
    float       pDecayOffset;
    float       pSizeOffset;
    GLKVector3  pColorOffset;
}
Particle;

typedef struct Emitter
{
    Particle    eParticles[NUM_PARTICLES];
    float       eRadius;
    float       eVelocity;
    float       eDecay;
    float       eSizeStart;
    float       eSizeEnd;
    GLKVector3  eColorStart;
    GLKVector3  eColorEnd;
}
Emitter;

@interface EmitterObject : NSObject

@property (assign) Emitter emitter;
@property (strong) EmitterShader* shader;

- (id)initWithTexture:(NSString *)fileName;
- (void)renderWithProjection:(GLKMatrix4)projectionMatrix;
- (void)updateLifeCycle:(float)timeElapsed;

@end
