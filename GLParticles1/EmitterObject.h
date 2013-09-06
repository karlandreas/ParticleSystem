//
//  EmitterObject.h
//  GLParticles1
//
//  Created by Super User on 05.08.13.
//  Copyright (c) 2013 Ricardo Rendon Cepeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


@interface EmitterObject : NSObject

- (id)initWithTexture:(NSString *)fileName at:(GLKVector2)position;
- (void)renderWithProjection:(GLKMatrix4)projectionMatrix;
- (BOOL)updateLifeCycle:(float)timeElapsed;

@end
