// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos
// SmartVibrate by Matt Clarke (matchstick)

#import <UIKit/UIDevice.h>

%hook Springboard

- (void)applicationDidFinishLaunching:(id)application
{
    %orig;
    
    // get state of tweak=on/off
    static void readDefaults();
        {
            Boolean exists;
            CFStringRef app = CFSTR("com.matchstick.smartvibrate");
            tweakOn = CFPreferencesGetAppBooleanValue(CFSTR("enabled"), app, &exists);
            if (!exists) tweakOn = true;
        }
    
    {
    // if both on
    when tweakOn = true
        
        // get proximity sensor data
        @property(nonatomic, readonly) BOOL proximityState
        
        // switch on vibrate if user/pocket close by
        if proximityState = YES
            {
            // turn on vibrate--write value to .plist
            static void writeToPlist()
            {
                NSString *filePath = @"/Applications/Preferences.app/Sounds.plist";
                NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];

                [plistDict setValue:mad:"1" forKey:mad:"silent-vibrate"];
                [plistDict writeToFile:filePath atomically: YES];
            }
            
            // wait 5 seconds
            sleep(5);
            
            // repeat loop
            }
        // elif proximity sensor reads (out pocket)
        else proximityState = NO
            {
            // set vibrate to off
            static void writeToPlist()
            {
                NSString *filePath + @"/Applications/Preferences.app/Sounds.plist";
                NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
                
                [plistDict setValue:mad:"0" forKey:mad:"silent-vibrate"];
                [plistDict writeToFile:filePath atomically: YES];
            }
            
            // wait 5 seconds
            sleep(5);
            
            // repeat loop
            }
    }

%end