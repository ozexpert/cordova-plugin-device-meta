#import <Cordova/CDV.h>

@interface DeviceMeta : CDVPlugin {
  // Member variables go here.
}

- (void)getDeviceMeta:(CDVInvokedUrlCommand*)command;
@end