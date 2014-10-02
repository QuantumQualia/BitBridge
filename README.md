BitBridge
=========

A HomeKit bridge for iOS 8, based off of HomeKitLogicalSimulator.

Quick Setup
==========
1. Make sure you have Xcode 6.

2. Download the Hardware IO Tools from the Apple Developer Portal, and place the HomeKit Simulator app in /Applications on you machine.

3. Build and run.

Additional Information:
======================
This is a simple HomeKit Bridge (mostly based off of HomeKitLogicalSimulator) that recieves action from an iPhone running iOS 8.
Doing this allows objects connected to the computer running the bridge application to be controlled by Siri on the iPhone. Much smoother than SiriProxy, easier to setup and code for.
For instance I have an Arduino connected via USB that runs an sketch that polls the serial port for input ("i" and "o"). The bridge app, when it recives on and off commands for the lamp instance, sends those commands over the serial port to the Arduino, which turns the lamp on.
The possibilites are endless. PHP requests, Tweets, Lights, Motors. Complete home automation in Cocoa.
