//
//  Cell.h
//  vinacredit
//
//  Created by Vinacredit on 9/27/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell {
    
    IBOutlet UIImageView *image;
    IBOutlet UILabel *bill;
    IBOutlet UILabel *time;
    IBOutlet UILabel *sumItem;
}
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *bill;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *sumItem;

@end
