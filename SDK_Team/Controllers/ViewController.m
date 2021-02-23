//
//  ViewController.m
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import "ViewController.h"
#import "Constant.h"
#import "NetworkManager.h"
#import "WebsiteObject.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CallLinkDelegate>

@end

@implementation ViewController

NSMutableArray * urls;
dispatch_group_t serviceGroup ;
NetworkManager* network;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"LinkTableViewCell" bundle:nil];
    [_linksTableView registerNib:nib forCellReuseIdentifier:@"LinkCell"];
    urls = [Constant getUrls];
    [_linksTableView reloadData];
    network= NetworkManager.sharedMySingleton;
    network.delegate = self;
    serviceGroup = dispatch_group_create();
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LinkTableViewCell *cell = (LinkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LinkCell" forIndexPath:indexPath];
    NSArray *components=[((WebsiteObject*)urls[indexPath.row]).name componentsSeparatedByString:@"www."];
    cell.urlTitle.text = components[1];
    WebsiteObject* webSite = urls[indexPath.row];
    if (((WebsiteObject*)urls[indexPath.row]).contentSize.length > 1) {
        cell.contentSize.text= [((WebsiteObject*)urls[indexPath.row]).contentSize stringByAppendingString:@" Bytes"];
    }
    if ([[urls[indexPath.row] valueForKey:@"loaded"]  isEqual: @"0"]) {
        cell.lblLeading.active = YES;
    }
    else{
        cell.lblLeading.active = NO;
        [cell.urlIcon setHidden:NO];
    }
//    if ([[urls[indexPath.row] valueForKey:@"loaded"]  isEqual: @"0"]) {
//        cell.backgroundColor = [UIColor lightGrayColor];
//    }else if ([[urls[indexPath.row] valueForKey:@"loaded"]  isEqual: @"1"]) {
//        cell.backgroundColor = [UIColor blueColor];
//    }else if ([[urls[indexPath.row] valueForKey:@"loaded"]  isEqual: @"2"]){
//        cell.backgroundColor = [UIColor greenColor];
//    }else if ([[urls[indexPath.row] valueForKey:@"loaded"]  isEqual: @"3"]){
//        cell.backgroundColor = [UIColor redColor];
//    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad )
        return 130;
    else
        return 80;
}
- (IBAction)startPressed:(id)sender {
    [self.startBtn setHidden:YES];
    
    // Async Call
    
//    for (int x=0; x<urls.count; x++) {
//        dispatch_group_enter(serviceGroup);
//        ((WebsiteObject*)urls[x]).loaded = @"1";
//        [self->_linksTableView reloadData];
//        [self requestWebsite:urls[x] AndIndex:x completion:^(id response) {
//            NSLog(@"%@", ((WebsiteObject*)response).contentSize);
//            dispatch_async(dispatch_get_main_queue(),
//                           ^{
//                [self->_linksTableView reloadData];
//            });
//
//            dispatch_group_leave(serviceGroup);
//        }];
//    }
    
    // sync call
    for (int index = 0; index < urls.count; index++) {
        WebsiteObject * site = urls[index];
        site.loaded = @"1";
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[site valueForKey:@"name"]]];
        [request setHTTPMethod:@"GET"];
        NSData * response = [network sendSynchronousRequest:request AndWebsite:site];
        NSString * kiloBytes = [NSString stringWithFormat:@"%ld",(long) response.length];
        site.contentSize = kiloBytes;
        NSLog(kiloBytes);
//        dispatch_async(dispatch_get_main_queue(),
//                       ^{
//            LinkTableViewCell *cell = [self.linksTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//            cell.contentSize.text =  [site.contentSize stringByAppendingString:@" Bytes"];
//            cell.backgroundColor = [UIColor greenColor];
            [self->_linksTableView reloadData];
//            [self->_linksTableView layoutIfNeeded];
//            [self->_linksTableView layoutSubviews];
//        });
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
        }
        dispatch_semaphore_signal(sem);
    }] resume];

    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);

   return result;
}
- (void)requestWebsite:(WebsiteObject*)site AndIndex :(int) index
            completion:(void(^)(id))completion
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[site valueForKey:@"name"]]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error!=nil) {
            ((WebsiteObject*) [Constant getUrls][index]).loaded = @"3";
        }else{
 
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSDictionary *responseHeaders = ((NSHTTPURLResponse *)response).allHeaderFields;
        NSString* content = [responseHeaders valueForKey:@"Content-Length"];
            NSString * kiloBytes = [NSString stringWithFormat:@"%ld",(long) data.length];
                ((WebsiteObject*) [Constant getUrls][index]).contentSize = kiloBytes;
        ((WebsiteObject*) [Constant getUrls][index]).loaded = @"2";
            site.contentSize = kiloBytes;
        }
        completion(site);
    }];
    [dataTask resume];
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Constant getUrls].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)didFinishWithFail:(nonnull NSString *)error {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:error
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didFinishWithSuccess:(nonnull WebsiteObject *)item {
    dispatch_async(dispatch_get_main_queue(),
                   ^{
        [self->_linksTableView reloadData];
        NSMutableArray* ar = [Constant getUrls];
    });
}

@end
