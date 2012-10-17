//
//  AddCell.h
//  Sale
//
//  Created by Vinacredit on 9/19/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddCellDelegate;
@interface AddCell : UITableViewCell
{
    
    IBOutlet UIImageView *imageItem;
    IBOutlet UITextField *textItem;
    IBOutlet UILabel *labelItem;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageItem;
@property (strong, nonatomic) IBOutlet UITextField *textItem;
@property (strong, nonatomic) IBOutlet UILabel *labelItem;
@property (assign) int adx;
@property (strong, nonatomic) id<AddCellDelegate>delegate;
- (IBAction)onAddUpInside:(id)sender;
@end
@protocol AddCellDelegate <NSObject>

@required
- (void)addCellDidAdd:(AddCell*)addCell;

@end
