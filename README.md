BitBridge
=========
A HomeKit bridge for iOS 8, based off of HomeKitLogicalSimulator.

Prerequisites:
=============
A Mac with Xcode 6 and HomeKitSimulator.
An iPhone running iOS 8
HomeKitClient application.
An official developer licence (used to get the app on your phone).
Note: if anyone has a better solution, please let me know. 


Quick Setup
==========
1. Make sure you have Xcode 6.

2. Download the Hardware IO Tools from the Apple Developer Portal, and place the HomeKit Simulator app in /Applications on you machine.

3. Build and run.

Additional Information:
======================
This is a simple HomeKit Bridge (mostly based off of [HomeKitLogicalSimulator]  (https://github.com/KhaosT/HomeKitLogicalSimulator)) that recieves action from an iPhone running iOS 8.
Doing this allows objects connected to the computer running the bridge application to be controlled by Siri on the iPhone. Much smoother than SiriProxy, easier to setup and code for.
For instance I have an Arduino connected via USB that runs an sketch that polls the serial port for input ("i" and "o"). The bridge app, when it recives on and off commands for the lamp instance, sends those commands over the serial port to the Arduino, which turns the lamp on.
The possibilites are endless. PHP requests, Tweets, Lights, Motors. Complete home automation in Cocoa. This is not a complete implementation, just enough to get you off the ground. 

Demo:
====
https://www.youtube.com/watch?v=Bo3o6FmYd5Q

Thanks:
=======
%95 of this is KhaosT's work, I just tweaked it to help you guys out to add a bit of documentation and added a working Light class. Check out (and star) his repo [here] (https://github.com/KhaosT/HomeKitLogicalSimulator).
