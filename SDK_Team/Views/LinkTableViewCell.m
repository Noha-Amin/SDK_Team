//
//  LinkTableViewCell.m
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import "LinkTableViewCell.h"


@interface LinkTableViewCell ()

-(void)showSata:(NSDictionary*)data;

@end

@implementation LinkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(void)showSata:(NSDictionary *)data{
    
}
-(void) SetupCell:(NSDictionary*) item{
    if (item.allKeys.count == 2) {
        self.urlIcon.image = [item valueForKey:@"image"];
        self.urlTitle.text = [item valueForKey:@"title"];
    }else{
        self.urlTitle.text = [item valueForKey:@"title"];
    
    }
}

@end
