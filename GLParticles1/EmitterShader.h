//
//  EmitterShader.h
//  GLParticles1
//
//  Created by RRC on 5/2/13.
//  Copyright (c) 2013 Ricardo Rendon Cepeda. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface EmitterShader : NSObject

// Program Handle
@property (readwrite) GLint program;

// Attribute Handles
@property (readwrite) GLint aTheta;

// Uniform Handles
@property (readwrite) GLint uProjectionMatrix;
@property (readwrite) GLint uK;

// Methods
- (void)loadShader;

@end
