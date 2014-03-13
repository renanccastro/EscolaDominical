//
//  SeeTeacherViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 13/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "SeeTeacherViewController.h"
#import "ClassCell.h"

@interface SeeTeacherViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *formation;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@end

@implementation SeeTeacherViewController

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
	
	self.navigationItem.title = self.selectedTeacher.name;
	self.photo.image = self.selectedTeacher.photo ? [UIImage imageWithData:self.selectedTeacher.photo] : self.photo.image;
	self.address.text = self.selectedTeacher.address;
	self.age.text = [self.selectedTeacher.age stringValue];
	self.phone.text = self.selectedTeacher.phone;

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
    
    return [self.selectedTeacher.responsibleClasses count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCell *cell = (ClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Teacher *object = [self.selectedTeacher.responsibleClasses allObjects][indexPath.row];
	
	cell.image.image = object.photo ? [UIImage imageWithData: object.photo] : cell.image.image;
	cell.name.text = object.name;
	
    return cell;
}




@end
