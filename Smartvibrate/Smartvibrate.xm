// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos
// SmartVibrate by Matt Clarke (matchstick)

#import <UIKit/UIDevice.h>

static BOOL tweakOn=YES

@interface SmartVibrate : NSObject <UIAlertViewDelegate>

    NSString *plistPath;
    BOOL *tweakOn;

@end

@implementation SmartVibrate

-(id)init
{
    //Set variabiles for tweak
    plistPath = [NSString stringWithString:@"/var/mobile/Library/Preferences/com.matchstick.smartvibrate.plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    tweakOn = [[dict objectForKey:@"enabled"] boolValue];
}

//Debug only
-(void)showAlert
{
    if (tweakOn) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Testing"
        message:@"Tweak should now be on!"
        delegate:nil
        cancelButtonTitle:@"Thanks"
        otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Testing"
        message:@"Tweak is disabled"
        delegate:nil
        cancelButtonTitle:@"Thanks"
        otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

// get proximity value
@property(nonatomic, getter=isProximityMonitoringEnabled)BOOL proximityMonitoringEnabled

-(BOOL)proximitySensoredIsEnabled {
    {
        [UIDevice currentDevice].proximityMonitoringEnabled=YES;
        return [[UIDevice currentDevice].isProximityMonitoringEnabled;
    }
            
    if ([self proximitySensoredIsEnabled]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(handleProximityChangeNotification:)
        name:UIDeviceProximityStateDidChangeNotification object:nil];
        }
}

@property(nonatomic, readonly) BOOL proximityState

-(void)handleProximityChangeNotification:(NSNotification*)notification {
    while (tweakOn) {
        if ([UIDevice currentDevice].proximityState) {
           // Set vibrate to on
            NSString *sbPath = @"/var/mobile/Library/Preferences/com.apple.springboard.plist";
            NSMutableDictionary *sbDict = [[NSMutableDictionary alloc] initWithContentsOfFile:sbPath];
            [sbDict setValue:[NSNumber numberWithBool:YES] forKey:@"silent-vibrate"];
            [sbDict writeToFile:filePath atomically: YES];
            
            // Update preferences
            notify_post("com.apple.SpringBoard/Prefs");
            sleep(2);
        }
        else {
            // Set vibrate to off
            NSString *sbPath = @"/var/mobile/Library/Preferences/com.apple.springboard.plist";
            NSMutableDictionary *sbDict = [[NSMutableDictionary alloc] initWithContentsOfFile:sbPath];
            [sbDict setValue:[NSNumber numberWithBool:NO] forKey:@"silent-vibrate"];
            [sbDict writeToFile:filePath atomically: YES];
            
            // Update preferences
            notify_post("com.apple.SpringBoard/Prefs");
            sleep(2);
        }
    }
}
    
@end