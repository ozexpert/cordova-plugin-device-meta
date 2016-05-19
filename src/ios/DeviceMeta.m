/********* DeviceMeta.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "DeviceMeta.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation DeviceMeta

- (void)getDeviceMeta:(CDVInvokedUrlCommand*)command
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
    [devProps setObject:@([self isDebug]) forKey:@"debug"];
    [devProps setObject:[self getIPAddress] forKey:@"ip"];
    [devProps setObject:[self getNetworkProvider] forKey:@"networkProvider"];

    NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

- (BOOL)isDebug
{
#ifdef DEBUG
    return true;
#else
    return false;
#endif
}


- (NSString *)getIPAddress {

    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];

                }

            }

            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (NSString *)getNetworkProvider {
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    return @"%@M", [carrier carrierName];
}

@end
