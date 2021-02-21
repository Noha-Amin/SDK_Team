//
//  ViewController.m
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import "ViewController.h"
#import "Constant.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

NSMutableArray * urls;

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"LinkTableViewCell" bundle:nil];
    [_linksTableView registerNib:nib forCellReuseIdentifier:@"LinkCell"];
    urls = [Constant getUrls];
    [_linksTableView reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LinkTableViewCell *cell = (LinkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LinkCell"];
    cell.urlTitle.text = [urls[indexPath.row] valueForKey:@"name"];
    
    if ([[urls[indexPath.row] valueForKey:@"loaded"]  isEqual: @"0"]) {
        cell.lblLeading.active = YES;
       // cell.urlIcon.isHidden = YES ;
    }else{
        cell.lblLeading.active = NO;
        //cell.urlIcon.isHidden = NO ;
    }
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Constant getUrls].count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



@end
