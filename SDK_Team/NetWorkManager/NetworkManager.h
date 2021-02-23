//
//  NetworkManager.h
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import <Foundation/Foundation.h>
#import "WebsiteObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CallLinkDelegate <NSObject>
- (void)didFinishWithSuccess:(WebsiteObject*)item;
- (void)didFinishWithFail:(NSString *)error;
@end

@interface NetworkManager : NSObject
+(NetworkManager *)sharedMySingleton;
-(void) CallWebistes;
-(void)callRequestWithItem:(WebsiteObject*) item AndIndex:(int)index;
-(NSData *)sendSynchronousRequest:(NSURLRequest *)request AndWebsite:(WebsiteObject*) site;
@property (nonatomic, weak) id <CallLinkDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
