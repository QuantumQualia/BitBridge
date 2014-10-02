//
//  GarageDoorOpener.h
//  HomeKitLogicalSimulator
//
//  Created by Khaos Tian on 8/21/14.
//  Copyright (c) 2014 Oltica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@class HAKAccessory, OTIHAPCore;

@interface Light : NSObject


@property (nonatomic,strong) Light *huelight;

- (id)initWithSerialNumber:(NSString *)serialNumber Core:(OTIHAPCore *)core;
- (HAKAccessory *)accessory;
- (HAKAccessory *)getLightAccessoryWithName:(NSString *)name;

@end
