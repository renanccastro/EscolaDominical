//
//  MaterialsSelectionViewController.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 10/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialsSelectionViewController : UITableViewController
@property (nonatomic) NSMutableSet* selectedMaterials;
@property (nonatomic) NSManagedObjectContext *context;
@end
