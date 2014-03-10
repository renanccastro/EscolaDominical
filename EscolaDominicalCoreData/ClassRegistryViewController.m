//
//  ClassRegistryViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 10/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ClassRegistryViewController.h"
#import "StudentsSelectionViewController.h"

@interface ClassRegistryViewController ()
@property (nonatomic) NSMutableArray* selectedStudents;
@end

@implementation ClassRegistryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.selectedStudents = [[NSMutableArray alloc] init];
}
-(void)viewWillAppear:(BOOL)animated{
	NSLog(@"%@", self.selectedStudents);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if ([[segue identifier]isEqualToString:@"students"]) {
		StudentsSelectionViewController * students = [segue destinationViewController];
		students.selectedStudents = self.selectedStudents;
	}
}

@end