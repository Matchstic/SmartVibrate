
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos
// SmartVibrate by Matt Clarke (matchstick)

#import <NSObject/UIDevice.h>

%hook Springboard

- (void)applicationDidFinishLaunching:(id)application
{
    %orig
    // get state of silent mode=on/off and tweak=on/off
    static void readDefaults() {
            Boolean exists;
            CFStringRef app = CFSTR("com.apple.*silent*");
            
            silentMode = CFPreferencesGetAppBooleanValue(CFSTR("????"), app, &exists);
            if (!exists) silentMode = true;

            // Changing CFStringRef--should work?

            Boolean exists;
            CFStringRef app = CFSTR("com.matchstick.smartvibrate");
            
            tweakOn = CFPreferencesGetAppBooleanValue(CFSTR("enabled"), app, &exists);
            if (!exists) tweakOn = true;
        
    
    // if both on
    when silentMode = true and tweakOn = true
        
        // get proximity sensor data
        @property(nonatomic, readonly) BOOL proximityState
        
        // switch off vibrate if user/pocket close by
        if proximityState = YES
            // turn off vibrate--write value to .plist
            static void writeToPlist()
            {
                NSString *filePath = @"/System/Library/PrivateFrameworks/Celestial.framework/******.plist";
                NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];

                [plistDict setValue:mad:"****" forKey:mad:"****"];
                [plistDict writeToFile:filePath atomically: YES];
            }
            
            // wait 5 seconds
            sleep(5);
            
            // repeat loop
        
        // elif proximity sensor reads (out pocket)
        elif proximityState = NO
            // set vibrate to on
            static void writeToPlist()
            {
                NSString *filePath + @"/System/Library/PrivateFrameworks/Celestial.framework/******.plist";
                NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
                
                [plistDict setValue:mad:"****" forKey:mad:"****"];
                [plistDict writeToFile:filePath atomically: YES];
            }
            
            // wait 5 seconds
            sleep(5);
            
            // repeat loop
}
%end