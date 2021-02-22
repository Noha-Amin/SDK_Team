//
//  WebsiteObject.m
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import "WebsiteObject.h"

@implementation WebsiteObject
-(instancetype)initWebSiteWith:(NSString *)name AndContent:(NSString *)contentSize AndImage:(nonnull NSString *)image AndLoaded:(NSString *)isLoad{
    self = [super init];
    if (self) {
        self.name = name;
        self.contentSize = contentSize;
        self.image= image;
        self.loaded = isLoad;
    }
    return self;
}
@end
