//
//  Constant.m
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import "Constant.h"
#import "WebsiteObject.h"

static NSMutableArray * Urls = nil;

@implementation Constant

+ (NSMutableArray *)getUrls{
    
    Urls = [[NSMutableArray alloc]initWithObjects:[[WebsiteObject alloc]initWebSiteWith:@"https://www.apple.com" AndContent:@"" AndImage:@"" AndLoaded:@"0"],[[WebsiteObject alloc]initWebSiteWith:@"https://www.spacex.com" AndContent:@"" AndImage:@"" AndLoaded:@"0"],[[WebsiteObject alloc]initWebSiteWith:@"https://www.dapi.co" AndContent:@"" AndImage:@"" AndLoaded:@"0"],[[WebsiteObject alloc]initWebSiteWith:@"https://www.facebook.com" AndContent:@"" AndImage:@"" AndLoaded:@"0"],[[WebsiteObject alloc]initWebSiteWith:@"https://www.microsoft.com" AndContent:@"" AndImage:@"" AndLoaded:@"0"],[[WebsiteObject alloc]initWebSiteWith:@"https://www.amazon.com" AndContent:@"" AndImage:@"" AndLoaded:@"0"],[[WebsiteObject alloc]initWebSiteWith:@"https://www.boomsupersonic.com" AndContent:@"" AndImage:@"" AndLoaded:@"0"],[[WebsiteObject alloc]initWebSiteWith:@"https://www.twitter.com" AndContent:@"" AndImage:@"" AndLoaded:@"0"], nil];
    return Urls;
}
@end

