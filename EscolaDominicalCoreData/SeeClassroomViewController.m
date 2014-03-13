//
//  SeeClassroomViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 13/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "SeeClassroomViewController.h"

@interface SeeClassroomViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
