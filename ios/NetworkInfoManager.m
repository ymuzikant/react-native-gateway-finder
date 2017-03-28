#import "NetworkInfoManager.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "ALNetwork.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "rout.h"

// Inspired by https://github.com/pusherman/react-native-network-info

@implementation NetworkInfoManager

+(NSString*)getSSIDDATA
{
    NSString *ssidata =[self getNetworkValueForKey:@"SSIDDATA"];
    
    return ssidata;
}

+(NSString*)getBSSID
{
    NSString *bssid = [self getNetworkValueForKey:(NSString*)kCNNetworkInfoKeyBSSID];
    
    return bssid;
}
+(NSString*)getSSID
{
    NSString *bssid =[self getNetworkValueForKey:(NSString*)kCNNetworkInfoKeySSID];
    
    return bssid;
}

+(NSString*)getGatewayIP
{
    NSString *str =   [ALNetwork externalIPAddress];
    
    return str;
}

+(NSString*)getInternalIP
{
    NSString *str =   [self  getIPAddress];
    
    return str;
}

+(NSString*)getDefaultIp
{
    NSString *ip = routerIP();
    return ip;
}

+(NSString *)getIPAddress {
    
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



+(NSString*)getNetworkValueForKey:(NSString*)key
{
    NSString *value = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[key]) {
            value = info[key];
        }
    }
    if([value isKindOfClass:[NSData class]])
    {
        NSString *str = [[NSString alloc] initWithData:(NSData*)value encoding:NSUTF8StringEncoding];
        
        return str;
    
    }
    else
    {
        return value;
    }
}

@end
