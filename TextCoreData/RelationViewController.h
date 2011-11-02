//
//  RelationViewController.h
//  TextCoreData
//
//  Created by xiaosong on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RelaDelegate <NSObject>

-(void)commit:(NSArray*)array;

-(void)commitChange:(NSArray*)array;
@end

@interface RelationViewController : UIViewController
{
    id<RelaDelegate> relaDelegate;
    IBOutlet UITextField *field1;
    IBOutlet UITextField *field2;
    IBOutlet UITextField *field3;
    IBOutlet UITextField *field4;
}
@property (nonatomic, assign) id<RelaDelegate> relaDelegate;
-(void)setData:(NSArray*)array;
-(IBAction)buttonPressed:(id)sender;
@end
