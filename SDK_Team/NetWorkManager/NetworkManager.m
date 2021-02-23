//
//  NetworkManager.m
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import "NetworkManager.h"
#import "WebsiteObject.h"
#import "Constant.h"


@implementation NetworkManager
static NetworkManager * NetworkClient = nil;
//dispatch_group_t serviceGroup ;
@synthesize delegate;
+(NetworkManager *)sharedMySingleton {
    @synchronized([NetworkManager class]) {
        if (!NetworkClient)
            NetworkClient = [[self alloc] init];
        return NetworkClient;
    }
    return nil;
}

-(void) CallWebistes{
   // serviceGroup = dispatch_group_create();
    for (int index = 0; index < Constant.getUrls.count; index++) {
      //  dispatch_group_enter(serviceGroup);
        WebsiteObject * item = Constant.getUrls[index];
       // [self callRequestWithItem:Constant.getUrls[index] AndIndex:index];
       // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:[item valueForKey:@"name"]]];
            [request setHTTPMethod:@"GET"];

            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                NSDictionary *responseHeaders = ((NSHTTPURLResponse *)response).allHeaderFields;
             NSString* content = [responseHeaders valueForKey:@"Content-Length"];
                ((WebsiteObject*) [Constant getUrls][index]).contentSize = content;
                item.contentSize = content;
                if([self.delegate respondsToSelector:@selector(didFinishWithSuccess:)]) {
                    [self.delegate didFinishWithSuccess:item];
                }
               // dispatch_group_leave(serviceGroup);
            }] resume];
        //});
    }
}
-(NSData *)sendSynchronousRequest:(NSURLRequest *)request AndWebsite:(WebsiteObject*) site{
    dispatch_semaphore_t    sem;
    __block NSData *        result;

    result = nil;
    
    sem = dispatch_semaphore_create(0);

    [[[NSURLSession sharedSession] dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            result = data;
            site.loaded = @"2";
        }else{
            site.loaded = @"3";
        }
        dispatch_semaphore_signal(sem);
    }] resume];

    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSString * kiloBytes = [NSString stringWithFormat:@"%ld",(long) result.length];
    site.contentSize = kiloBytes;
    
   return result;
}
-(void)callRequestWithItem:(WebsiteObject*) item AndIndex:(int)index{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[item valueForKey:@"name"]]];
        [request setHTTPMethod:@"GET"];

        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSDictionary *responseHeaders = ((NSHTTPURLResponse *)response).allHeaderFields;
         NSString* content = [responseHeaders valueForKey:@"Content-Length"];
            ((WebsiteObject*) [Constant getUrls][index]).contentSize = content;
            item.contentSize = content;
            if([self.delegate respondsToSelector:@selector(didFinishWithSuccess:)]) {
                [self.delegate didFinishWithSuccess:item];
            }
           // dispatch_group_leave(serviceGroup);
        }] resume];
    });
}
@end
