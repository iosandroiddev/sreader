//
//  ItemCell.h
//  ExampleSale
//
//  Created by Vinacredit on 9/5/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Customized1CellDelegate;

@interface ItemCell : UITableViewCell<UITextFieldDelegate>{
    
    
    IBOutlet UIImageView *itemImage;
    IBOutlet UILabel     *itemLabel;
    IBOutlet UILabel *itemField;
    IBOutlet UIButton *buttonMinus;
    IBOutlet UIButton *buttonPlus;
    IBOutlet UILabel *itemNum;
}
@property (strong, nonatomic) IBOutlet UILabel *itemNum;
@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) IBOutlet UILabel *itemLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemField;
@property (strong, nonatomic) IBOutlet UIButton *buttonMinus;
@property (strong, nonatomic) IBOutlet UIButton *buttonPlus;
@property (assign) int idx;

@property (strong, nonatomic) id<Customized1CellDelegate>delegate;
- (IBAction)onMinusUpInside:(id)sender;
- (IBAction)onPlusUpInside:(id)sender;
@end
@protocol Customized1CellDelegate <NSObject>

@required
- (void)customized1CellDidPlus:(ItemCell *)customized1Cell;
- (void)customized1CellDidMinus:(ItemCell *)customized1Cell;
@end


