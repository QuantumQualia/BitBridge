
//  HueLight.m
//  HomeKitBridge
//
//  Created by Khaos Tian on 7/18/14.
//  Copyright (c) 2014 Oltica. All rights reserved.
//

#import "Light.h"

#import "HAKIdentifyCharacteristic.h"
#import "HAKOnCharacteristic.h"
#import "HAKLightBulbService.h"
#import "OTIHAPCore.h"
#import "HAKAccessory.h"
#import "HAKAccessoryInformationService.h"
#import "ORSSerialPort.h"
#import "HAKCharacteristic.h"
#import "HAKNameCharacteristic.h"
#import "HAKSerialNumberCharacteristic.h"
#import "HAKManufacturerCharacteristic.h"
#import "HAKModelCharacteristic.h"
@interface Light () {
    HAKOnCharacteristic *_state;
     BOOL                        _pendingUpdate;
    BOOL _isLightOn;
Light *_light;
    
    OTIHAPCore *_accessoryCore;
    
    HAKAccessory *_lightAccessory;
}

@end

@implementation Light

- (id)initWithSerialNumber:(NSString *)serialNumber Core:(OTIHAPCore *)core {
    self = [super init];
    if (self) {
        _accessoryCore = core;
        
        _lightAccessory = [self createLightAccessoryWithSerialNumber:serialNumber];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(characteristicDidUpdateValueNotification:) name:@"HAKCharacteristicDidUpdateValueNotification" object:nil];
    }
    return self;
}

- (void)processLightAccessory {
    for (HAKService *service in _lightAccessory.services) {
        for (HAKCharacteristic *characteristic in service.characteristics) {
            if ([characteristic isKindOfClass:[HAKOnCharacteristic class]]) {
                _state = (HAKOnCharacteristic *)characteristic;
            }
            
            }
    }
    
    [self updateLightValue];
}

- (HAKAccessory *)accessory {
    return _lightAccessory;
}

- (void)updateLightValue {
    if (!_pendingUpdate) {
        HAKLightBulbService *light;
  
        if (_state.on !=light.onCharacteristic.boolValue) {
            _state.on = light.onCharacteristic.boolValue;
        }
        
     
    }else{
        _pendingUpdate = NO;
    }
}

- (void)updateLightValueWithLight:(Light *)light {
    _light = light;
    [self updateLightValue];
}

- (HAKAccessory *)getLightAccessoryWithName:(NSString *)name {
    HAKAccessory *accessory = [self createLightAccessoryWithSerialNumber:@"salty"];
    
    HAKAccessoryInformationService *infoService = [[HAKAccessoryInformationService alloc] init];
    
    infoService.nameCharacteristic.name = @"ArduLamp";
    infoService.serialNumberCharacteristic.serialNumber = @"UNOr3-E208097";
    infoService.manufacturerCharacteristic.manufacturer = @"Target";
    infoService.modelCharacteristic.model = @"ArduLamp Rev. 1";
    
   accessory.accessoryInformationService = infoService;
    
    [accessory addService:infoService];
    

    return accessory;
}



- (HAKAccessory *)createLightAccessoryWithSerialNumber:(NSString *)serialNumber {
    NSLog(@"Init Accessory With Serial Number:%@",serialNumber);
    HAKAccessory *garageDoor = [_accessoryCore getAccessoryWithSerialNumber:serialNumber];
    
    if (garageDoor != nil) {
        for (HAKService *service in garageDoor.services) {
            if ([service isKindOfClass:[HAKLightBulbService class]]) {
                HAKLightBulbService *gcs = (HAKLightBulbService *)service;
               
                _state = gcs.onCharacteristic;
                if (_state.boolValue == 0) {
                    _isLightOn = YES;
                } else {
                    _isLightOn = NO;
                }
            }
        }
    } else {
        garageDoor = [[HAKAccessory alloc]init];
        
        HAKAccessoryInformationService *infoService = [[HAKAccessoryInformationService alloc] init];
     
        
        infoService.nameCharacteristic.name = @"ArduLamp";
        infoService.serialNumberCharacteristic.serialNumber = @"UNOr3-E208097";
        infoService.manufacturerCharacteristic.manufacturer = @"Target";
        infoService.modelCharacteristic.model = @"ArduLamp Rev. 1";

        
        garageDoor.accessoryInformationService = infoService;
        [garageDoor addService:infoService];
       [garageDoor addService:[self setupLightService]];
    }
    
    return garageDoor;
}


- (void)characteristicDidUpdateValueNotification:(NSNotification *)aNote {
    HAKOnCharacteristic *characteristic = aNote.object;
    
    ORSSerialPort *serialPort = [ORSSerialPort serialPortWithPath:@"/dev/tty.usbmodem1d21"];
    serialPort.baudRate = [NSNumber numberWithInteger:9600];
    [serialPort open];
    NSData *someData;
    _state = characteristic;
    if(characteristic.boolValue == YES){
        NSLog(@"yes!");
    
        someData = [@"i" dataUsingEncoding:NSUTF8StringEncoding];

      //  popen("echo i > /dev/cu.usbmodem1d11", "r");

    }else{
        NSLog(@"no!");

        someData = [@"o" dataUsingEncoding:NSUTF8StringEncoding];
           // popen("echo o > /dev/cu.usbmodem1d11", "r");

    }
    sleep(5);
       [serialPort sendData:someData];
    sleep(5);
    [serialPort close];
}


- (HAKLightBulbService *)setupLightService {
    HAKLightBulbService*service = [[HAKLightBulbService alloc] init];
    

    
    _state = service.onCharacteristic;
    if (_state.boolValue == YES) {
        _isLightOn = YES;
    } else {
        _isLightOn = NO;
    }
    
    return service;
}




@end
