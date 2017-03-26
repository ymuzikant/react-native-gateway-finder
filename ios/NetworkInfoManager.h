//
//  NetworkInfoManager.h
//  testupnp
//
//  Created by yehonatan ben zion Tuval on 24/02/2017.
//  Copyright © 2017 livelock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkInfoManager : NSObject

+(NSString*)getSSIDDATA;
+(NSString*)getBSSID;
+(NSString*)getSSID;
+(NSString*)getGatewayIP;
+(NSString*)getInternalIP;
+(NSString*)getDefaultIp;

@end
