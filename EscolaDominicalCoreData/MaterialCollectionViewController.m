//
//  MaterialCollectionViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 12/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "MaterialCollectionViewController.h"
#import "Store.h"
#import "Material.h"
#import "ClassCell.h"
#import "Classroom.h"

@interface MaterialCollectionViewController () <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation MaterialCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.name.text = self.currentMaterial.name;
	NSLog(@"%@",self.currentMaterial);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.currentMaterial.classesThatUses count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCell *cell = (ClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Classroom *object = [self.currentMaterial.classesThatUses allObjects][indexPath.row];
	
	cell.image.image = object.photo ? [UIImage imageWithData: object.photo] : cell.image.image;
	cell.name.text = object.name;
	
    return cell;
}





@end
