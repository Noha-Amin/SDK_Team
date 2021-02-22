//
//  LinkTableViewCell.h
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *urlIcon;
@property (weak, nonatomic) IBOutlet UILabel *urlTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblLeading;
@property (weak, nonatomic) IBOutlet UILabel *contentSize;

@end

NS_ASSUME_NONNULL_END
