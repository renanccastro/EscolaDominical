//
//  ClassSelectionTableViewController.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 13/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassSelectionTableViewController : UITableViewController
@property (nonatomic) NSMutableSet* selectedClassrooms;
@property (nonatomic) NSManagedObjectContext *context;

@end
