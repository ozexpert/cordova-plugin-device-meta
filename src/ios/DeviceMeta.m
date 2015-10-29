/********* DeviceMeta.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "DeviceMeta.h"

@implementation DeviceMeta

- (CDVPluginResult *)getDeviceMeta:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    //NSString* echo = [command.arguments objectAtIndex:0];

    //if (echo != nil && [echo length] > 0) {
    //    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    //} else {
    //    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    //}
    NSDictionary* deviceProperties = [self deviceProperties];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsDictionary:deviceProperties];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSDictionary*)deviceProperties
{
    NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:4];
    [devProps setObject:@"Apple" forKey:@"manufacturer"];
    #ifdef DEBUG
        [devProps setObject:@"true" forKey:@"debug"];
    #else
        [devProps setObject:@"false" forKey:@"debug"];
    #endif

    NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

@end
