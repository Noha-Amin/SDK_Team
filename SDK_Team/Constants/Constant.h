//
//  Constant.h
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Constant : NSObject

struct WebSite {
    NSString *name;
    NSString *contentSize;
    NSString *image;
    bool loaded;
};

+(NSMutableArray*) getUrls;

@end

NS_ASSUME_NONNULL_END
