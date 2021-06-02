#import <Foundation/Foundation.h>
#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>

CFStringRef const key = CFSTR("SBSupportLiftToWake");
CFStringRef const kDomain = CFSTR("com.apple.springboard");

@interface RaiseToWakeSwitch : NSObject <FSSwitchDataSource>
@end

@implementation RaiseToWakeSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
    Boolean keyExist;
    Boolean enabled = CFPreferencesGetAppBooleanValue(key, kDomain, &keyExist);
    if (!keyExist)
        return FSSwitchStateOn;
    return enabled ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
    if (newState == FSSwitchStateIndeterminate)
        return;
    CFBooleanRef enabled = newState == FSSwitchStateOn ? kCFBooleanTrue : kCFBooleanFalse;
    CFPreferencesSetAppValue(key, enabled, kDomain);
    CFPreferencesAppSynchronize(kDomain);
}

- (void)applyAlternateActionForSwitchIdentifier:(NSString *)switchIdentifier {
    NSURL *url = [NSURL URLWithString:@"prefs:root=DISPLAY#RAISE_TO_WAKE"];
    [[FSSwitchPanel sharedPanel] openURLAsAlternateAction:url];
}

@end