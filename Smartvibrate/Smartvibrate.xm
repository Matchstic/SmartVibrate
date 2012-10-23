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
                NSString *sbPath = @"/var/mobile/Library/Preferences/com.apple.springboard.plist";
                NSMutableDictionary *sbDict = [[NSMutableDictionary alloc] initWithContentsOfFile:sbPath];
                
                [sbDict setValue:[NSNumber numberWithBool:YES] forKey:@"silent-vibrate"];
                [sbDict writeToFile:filePath atomically: YES];
                
                // Update preferences
                notify_post("com.apple.SpringBoard/Prefs");
            }
            
            // wait 2 seconds
            sleep(2);
            
            // repeat loop
            }
        // elif proximity sensor reads (out pocket)
        else proximityState = NO
            {
            // set vibrate to off
            static void writeToPlist()
            {
                NSString *sbPath = @"/var/mobile/Library/Preferences/com.apple.springboard.plist";
                NSMutableDictionary *sbDict = [[NSMutableDictionary alloc] initWithContentsOfFile:sbPath];
                
                [sbDict setValue:[NSNumber numberWithBool:NO] forKey:@"silent-vibrate"];
                [sbDict writeToFile:filePath atomically: YES];
                
                // Update preferences
                notify_post("com.apple.SpringBoard/Prefs");
            }
            
            // wait 2 seconds
            sleep(2);
            
            // repeat loop
            }
    }

%end