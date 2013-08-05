//
//  MainViewController.h
//  GLParticles1
//
//  Created by RRC on 5/2/13.
//  Copyright (c) 2013 Ricardo Rendon Cepeda. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "EmitterObject.h"

@interface MainViewController : GLKViewController

// Properties
@property (strong) EmitterObject* emitter;

@end
