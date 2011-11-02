//
//  RelationViewController.m
//  TextCoreData
//
//  Created by xiaosong on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RelationViewController.h"

@implementation RelationViewController

@synthesize relaDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITextField *field1 = [self.view viewWithTag:1]
    [[self.view viewWithTag:1] resignFirstResponder];
    [[self.view viewWithTag:2] resignFirstResponder];
    [[self.view viewWithTag:3] resignFirstResponder];
    [[self.view viewWithTag:4] resignFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)setData:(NSArray*)array{
    field1.text = [array objectAtIndex:0];
    field2.text = [array objectAtIndex:1];
    field3.text = [array objectAtIndex:2];
    field4.text = [array objectAtIndex:3];
    
    
//    field1.text = @"xxxxxx";
//    NSLog(@"%@",array);
}




-(IBAction)buttonPressed:(id)sender{
    UIButton *button = sender;
    
    
    if (button.tag == 5) {      //新建
        NSString *str1 = field1.text;
        NSString *str2 = field2.text;
        NSString *str3 = field3.text;
        NSString *str4 = field4.text;
        NSArray *array = [[NSArray alloc] initWithObjects:str1,str2,str3,str4, nil];
        [self.relaDelegate commit:array];
        [array release];
        [self.navigationController popViewControllerAnimated:YES];
    }else if(button.tag == 7){      //修改
        NSString *str1 = field1.text;
        NSString *str2 = field2.text;
        NSString *str3 = field3.text;
        NSString *str4 = field4.text;
        NSArray *array = [[NSArray alloc] initWithObjects:str1,str2,str3,str4, nil];
        [self.relaDelegate commitChange:array];
        [array release];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
@end
