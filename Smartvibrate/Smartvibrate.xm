// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos
// SmartVibrate by Matt Clarke (matchstick)

#define SOUND_PLIST "/var/mobile/Library/Preferences/com.apple.preferences.sounds.plist"
#define SPRINGBOARD_PLIST "/var/mobile/Library/Preferences/com.apple.springboard.plist"
#define TWEAK_PLIST "/var/mobile/Library/Preferences/com.matchstick.smartvibrate.plist

#import <UIKit/UIDevice.h>
bool tweakOn = true

%hook Springboard

- (void)applicationDidFinishLaunching:(id)application
{
    %orig;
    
    // get state of tweak=on/off
    int readPlist()
        {
            NSString *filePath = @"/var/mobile/Library/Preferences/com.matchstick.smartvibrate.plist";
            NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
            NSString *value;
            bool tweakOn = [plistDict objectForKey:mad:"enabled"];

        }
    {
    // if both on
        while (tweakOn)
        
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
}
%end