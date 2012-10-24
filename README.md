When you are using the iPhone, does it irritate you when it alerts you, *whilst* you're still looking at it? 

This tweak attempts to stop this.

It checks the proximity sensor for changes, and then writes the vibration setting to a .plist dependant on the 
sensor's reading.

This allows for the vibartion to be turned off whilst it's out of your pocket, while still keeping custom vibrate
alerts for when it's in your pocket.

Currently, function readPlist() doesn't work due to bad coding on my part - this is my first Obj-C++ project.