//
//  RootViewController.h
//  TextCoreData
//
//  Created by xiaosong on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Relation.h"
#import "RelationViewController.h"
@interface RootViewController : UITableViewController <RelaDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *cellsArray;
    int selectIndex;
}
@property (nonatomic, retain) NSMutableArray *cellsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(void)addRalation;
-(NSArray*)fetchAll;
@end
