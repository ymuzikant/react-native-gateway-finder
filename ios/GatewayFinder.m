#import "GatewayFinder.h"
#import "NetworkInfoManager.h"
#import "Base/RCTConvert.h"

@implementation GatewayFinder

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(getGatewayInfo:(RCTResponseSenderBlock)onGatewayInfoFetched onError:(RCTResponseSenderBlock)onError)
{
    NSString *routerIp = [NetworkInfoManager getDefaultIp];
    NSString *bssid = [NetworkInfoManager getBSSID];
    NSString *ssid = [NetworkInfoManager getSSID];
    
    if (routerIp == nil || bssid == nil || ssid == nil)
    {
        if (onError)
        {
            NSLog(@"Error: ip='%@', bssid='%@', ssid='%@'", routerIp, bssid, ssid);
            onError(@[[NSString stringWithFormat:@"Cannot extract info - got ip='%@', bssid='%@', ssid='%@'",
                    routerIp, bssid, ssid]]);
        }
        return;
    }
    
    NSMutableDictionary *gatewayInfo = [NSMutableDictionary dictionary];
    
    [gatewayInfo setObject:routerIp forKey:@"ip"];
    [gatewayInfo setObject:bssid forKey:@"bssid"];
    [gatewayInfo setObject:ssid forKey:@"ssid"];
  
    onGatewayInfoFetched(@[gatewayInfo]);
}

@end
