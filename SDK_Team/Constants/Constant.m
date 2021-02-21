//
//  Constant.m
//  SDK_Team
//
//  Created by Administrator on 21/02/2021.
//

#import "Constant.h"

static NSMutableArray * Urls = nil;

@implementation Constant

+ (NSMutableArray *)getUrls{
    Urls = [[NSMutableArray alloc]initWithObjects:@{ @"name" : @"apple.com", @"image" : @"",@"loaded":@"0"},@{ @"name" : @"spacex.com", @"image" : @"",@"loaded":@"0"},@{ @"name" : @"dapi.co", @"image" : @"",@"loaded":@"0"},@{ @"name" : @"facebook.com", @"image" : @"",@"loaded":@"0"},@{ @"name" : @"microsoft.com", @"image" : @"",@"loaded":@"0"},@{ @"name" : @"amazon.com", @"image" : @"",@"loaded":@"0"},@{ @"name" : @"boomsupersonic.com", @"image" : @"",@"loaded":@"0"},@{ @"name" : @"twitter.com", @"image" : @"",@"loaded":@"0"}, nil];
    return Urls;
}
@end

