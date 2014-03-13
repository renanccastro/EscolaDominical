//
//  SelectUniqueClassromTableViewController.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 13/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "Classroom.h"


@protocol SecondViewControllerDelegate
- (void)secondViewControllerDidFinish:(Classroom*)selectedClassroom;
@end

@interface SelectUniqueClassromTableViewController : UITableViewController

@property     id<SecondViewControllerDelegate> delegate;
@property (nonatomic) NSManagedObjectContext *context;



@end
