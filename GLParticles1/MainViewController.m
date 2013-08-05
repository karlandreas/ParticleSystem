//
//  MainViewController.m
//  GLParticles1
//
//  Created by RRC on 5/2/13.
//  Copyright (c) 2013 Ricardo Rendon Cepeda. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up context
    EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:context];
    
    // Set up view
    GLKView* view = (GLKView*)self.view;
    view.context = context;
    
    // Set up Emitter
    self.emitter = [[EmitterObject alloc] initEmitterObject];
}



#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    // Set the background color (green)
    glClearColor(0.53f, 0.81f, 0.92f, 1.00f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Create Projection Matrix
    float aspectRatio = view.frame.size.width / view.frame.size.height;
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeScale(1.0f, aspectRatio, 1.0f);
    
    // Render Emitter
    [self.emitter renderWithProjection:projectionMatrix];
}

- (void)update
{
    // Update Emitter
    [self.emitter updateLifeCycle:self.timeSinceLastUpdate];
}

@end
