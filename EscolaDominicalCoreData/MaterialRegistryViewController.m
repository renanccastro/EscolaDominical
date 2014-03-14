//
//  MaterialRegistryViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 12/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "MaterialRegistryViewController.h"
#import "Store.h"
#import "Material+CoreDataMethods.h"

@interface MaterialRegistryViewController ()
@property (nonatomic) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic) NSManagedObjectContext* context;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *author;

@end

@implementation MaterialRegistryViewController

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
	self.context = [[Store sharedManager] newPrivateContext];
	self.context.undoManager = nil;
}

- (IBAction)saveMaterial:(id)sender {
	[self.context performBlockAndWait:^{
		[Material createUniqueMaterialInContext:self.context withName:[self.name.text isEqualToString:@"type here"] ? nil : self.name.text withAuthor:[self.author.text isEqualToString:@"type here"] ? nil : self.author.text];
	}];
	[self.navigationController popViewControllerAnimated:YES];
	

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSString*) formatPhoneNumber:(NSString*) simpleNumber deleteLastChar:(BOOL)deleteLastChar {
	if(simpleNumber.length==0) return @"";
	// use regex to remove non-digits(including spaces) so we are left with just the numbers
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
	simpleNumber = [regex stringByReplacingMatchesInString:simpleNumber options:0 range:NSMakeRange(0, [simpleNumber length]) withTemplate:@""];
	
	// check if the number is to long
	if(simpleNumber.length>11) {
		// remove last extra chars.
		simpleNumber = [simpleNumber substringToIndex:10];
	}
	
	if(deleteLastChar) {
		// should we delete the last digit?
		simpleNumber = [simpleNumber substringToIndex:[simpleNumber length] - 1];
	}
	
	// 123 456 7890
	// format the number.. if it's less then 7 digits.. then use this regex.
	if(simpleNumber.length<7)
		simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{2})(\\d+)"
															   withString:@"($1) $2"
																  options:NSRegularExpressionSearch
																	range:NSMakeRange(0, [simpleNumber length])];
	
	else   // else do this one..
		//(\\d{2})(\\d{4})(\\d+)
		simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{2})((?=[9])\\d{5}|\\d{4})(\\d+)"
															   withString:@"($1) $2-$3"
																  options:NSRegularExpressionSearch
																	range:NSMakeRange(0, [simpleNumber length])];
	
	
	
	return simpleNumber;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSString* totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
	
	// if it's the phone number textfield format it.
	if(textField.tag==102 ) {
		if (range.length == 1) {
			// Delete button was hit.. so tell the method to delete the last char.
			textField.text = [self formatPhoneNumber:totalString deleteLastChar:YES];
		} else {
			textField.text = [self formatPhoneNumber:totalString deleteLastChar:NO ];
		}
		return false;
	}
	
	return YES;
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
