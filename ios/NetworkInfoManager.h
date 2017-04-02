#import <Foundation/Foundation.h>

@interface NetworkInfoManager : NSObject

+(NSString*)getSSIDDATA;
+(NSString*)getBSSID;
+(NSString*)getSSID;
+(NSString*)getGatewayIP;
+(NSString*)getInternalIP;
+(NSString*)getDefaultIp;

@end
