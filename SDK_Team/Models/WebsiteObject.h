//
//  WebsiteObject.h
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebsiteObject : NSObject

@property (weak,nonatomic) NSString* name;
@property (weak,nonatomic) NSString* contentSize;
@property (weak,nonatomic) NSString* image;
@property (weak,nonatomic) NSString* loaded;

-(instancetype)initWebSiteWith:(NSString*)name AndContent :(NSString*)contentSize AndImage :(NSString*)image AndLoaded:(NSString*) isLoad;
@end

NS_ASSUME_NONNULL_END
