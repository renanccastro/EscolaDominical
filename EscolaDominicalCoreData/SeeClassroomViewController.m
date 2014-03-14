//
//  SeeClassroomViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 13/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "SeeClassroomViewController.h"
#import "ClassCell.h"
#import "Material.h"
#import "Student.h"
#import "Teacher.h"
#import "Header.h"
@interface SeeClassroomViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *minAge;
@property (weak, nonatomic) IBOutlet UILabel *maxStudents;

@end

@implementation SeeClassroomViewController

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
	self.photo.image = self.selectedClassroom.photo ? [UIImage imageWithData: self.selectedClassroom.photo] : self.photo.image;
	self.navigationItem.title = self.selectedClassroom.name;
	self.minAge.text = [self.selectedClassroom.minAge stringValue];
	self.maxStudents.text = [self.selectedClassroom.maxStudents stringValue];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
		case 0:
			return [self.selectedClassroom.materials count];
			break;
		case 1:
			return [self.selectedClassroom.students count];
			break;
		case 2:
			return [self.selectedClassroom.teachers count];
			break;
		default:
			return 0;
	}
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCell *cell = (ClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	Material* mat;
	Student* std;
	Teacher* tch;
	switch (indexPath.section) {
		case 0:
			mat = [self.selectedClassroom.materials allObjects][indexPath.row];
			cell.image.image = mat.photo ? [UIImage imageWithData: mat.photo] : [UIImage imageNamed:@"bookCover"];
			cell.name.text = mat.name;
			break;
		case 1:
			std = [self.selectedClassroom.students allObjects][indexPath.row];
			cell.image.image = std.photo ? [UIImage imageWithData: std.photo] : [UIImage imageNamed:@"noPhoto"];
			cell.name.text = std.name;

			break;
		case 2:
			tch = [self.selectedClassroom.teachers allObjects][indexPath.row];
			cell.image.image = tch.photo ? [UIImage imageWithData: tch.photo] : [UIImage imageNamed:@"noPhoto"];
			cell.name.text = tch.name;

			break;
		default:
			return 0;
	}
	
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
	
    Header *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
								   UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    [self updateSectionHeader:headerView forIndexPath:indexPath];
	
    return headerView;
}

- (void)updateSectionHeader:(Header *)header forIndexPath:(NSIndexPath *)indexPath
{
	NSString *text;
	
	switch (indexPath.section) {
		case 0:
			text = @"Current using materials";
			break;
		case 1:
			text = @"Current enrolled students";
			break;
		case 2:
			text = @"Current teaching";
			break;
	}
	
    header.title.text = text;
}



@end
