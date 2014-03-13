//
//  SeeStudentViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 13/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "SeeStudentViewController.h"
#import "Classroom.h"

@interface SeeStudentViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIImageView *classPhoto;
@property (weak, nonatomic) IBOutlet UILabel *className;

@end

@implementation SeeStudentViewController

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
	self.navigationItem.title = self.selectedStudent.name;
	self.photo.image = self.selectedStudent.photo ? [UIImage imageWithData:self.selectedStudent.photo] : self.photo.image;
	self.address.text = self.selectedStudent.address;
	self.age.text = [self.selectedStudent.age stringValue];
	self.phone.text = self.selectedStudent.phone;
	self.classPhoto.image = self.selectedStudent.attendingClass.photo ? [UIImage imageWithData:self.selectedStudent.attendingClass.photo] : self.classPhoto.image;
	self.className.text = self.selectedStudent.attendingClass.name ? self.selectedStudent.attendingClass.name : @"Not attending any class";
	
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
