//
//  AppDelegate.m
//  BitBridge
//
//  Created by Keaton Burleson on 10/2/14.
//  Copyright (c) 2014 BitTank. All rights reserved.
//

#import "AppDelegate.h"
#import "OTIHAPCore.h"
#import "GarageDoorOpener.h"
#import "Thermostat.h"
#import "Light.h"
#import "ORSSerialPortManager.h"
@interface AppDelegate (){
        NSArray *ports;
    IBOutlet NSComboBox *dropdown;
}

@property (weak) IBOutlet NSWindow *window;
@property (strong, nonatomic) OTIHAPCore *accessoryCore;
@property (strong, nonatomic) GarageDoorOpener *doorOpener;
@property (strong, nonatomic) Thermostat *thermostat;
@property (strong, nonatomic) Light *light;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _accessoryCore = [[OTIHAPCore alloc]initAsBridge:YES];
    
    _doorOpener = [[GarageDoorOpener alloc] initWithSerialNumber:@"B0107469FA37" Core:_accessoryCore];
    NSLog(@"Opener:%@",_doorOpener);
    
    [_accessoryCore addAccessory:[_doorOpener accessory]];
    
    _thermostat = [[Thermostat alloc] initWithSerialNumber:@"E1E46A9C0345" Core:_accessoryCore];
    NSLog(@"Thermostat:%@",_thermostat);
    
    [_accessoryCore addAccessory:[_thermostat accessory]];
    
    
    _light = [[Light alloc] initWithSerialNumber:@"E1E46A9C0346" Core:_accessoryCore];
    NSLog(@"Light:%@",_thermostat);
    
    [_accessoryCore addAccessory:[_light accessory]];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"Bridge"];
    [statusItem setHighlightMode:YES];
    [statusMenu addItemWithTitle:[NSString stringWithFormat:@"PIN: %@", _accessoryCore.password] action:nil keyEquivalent:_accessoryCore.password];



}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    _accessoryCore = nil;
}




@end
