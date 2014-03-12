//
//  ClassRegistryViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 10/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ClassRegistryViewController.h"
#import "StudentsSelectionViewController.h"
#import "TeachersSelectionViewController.h"
#import "Classroom+CoreDataMethods.h"
#import "MaterialsSelectionViewController.h"
#import "Store.h"

@interface ClassRegistryViewController ()
@property (nonatomic) NSMutableSet* selectedStudents;
@property (nonatomic) NSMutableSet* selectedTeachers;
@property (nonatomic) NSMutableSet* selectedMaterials;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UILabel *minAge;
@property (weak, nonatomic) IBOutlet UILabel *maxStudents;
@property (nonatomic) NSManagedObjectContext* context;
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
- (IBAction)minAgeChanged:(UIStepper*)sender {
	self.minAge.text = [NSString stringWithFormat:@"%1.0f", [sender value]];
}
- (IBAction)maxStudentsChanged:(UIStepper*)sender {
	self.maxStudents.text = [NSString stringWithFormat:@"%1.0f", [sender value]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.context = [[Store sharedManager] newPrivateContext];
	self.context.undoManager = nil;

	self.selectedStudents = [[NSMutableSet alloc] init];
	self.selectedMaterials = [[NSMutableSet alloc] init];
	self.selectedTeachers = [[NSMutableSet alloc] init];
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
		students.context = self.context;
	} else if([[segue identifier]isEqualToString:@"teachers"]) {
		TeachersSelectionViewController * teachers = [segue destinationViewController];
		teachers.selectedTeachers = self.selectedTeachers;
		teachers.context = self.context;
	} else if([[segue identifier]isEqualToString:@"materials"]) {
		MaterialsSelectionViewController * materials = [segue destinationViewController];
		materials.selectedMaterials = self.selectedMaterials;
		materials.context = self.context;
	}

}
- (IBAction)createClass:(id)sender {
	[self.context performBlockAndWait:^{
		NSNumber* maxStudents = [NSNumber numberWithInt:[self.maxStudents.text intValue] ];
		NSNumber* minAge = [NSNumber numberWithInt:[self.minAge.text intValue] ];
		
		Classroom* classroom = [Classroom createNewClassroomInContext:self.context WithName:[self.name.text isEqualToString:@"type here"] ? nil : self.name.text withMaxStudents:maxStudents withMinAge:minAge withMaterials:self.selectedMaterials withStudents:self.selectedStudents andWithTeachers:self.selectedTeachers];
		NSLog(@"%@",classroom.name);
		
	}];
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
	if ([textField.text isEqualToString:@"type here"]) {
		textField.text = @"";
	}
	return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
	if ([textField.text isEqualToString:@""]) {
		textField.text = @"type here";
	}
	return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}


@end