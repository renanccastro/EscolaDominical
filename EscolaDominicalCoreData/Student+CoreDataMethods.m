//
//  Student+CoreDataMethods.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 27/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Student+CoreDataMethods.h"

@implementation Student (CoreDataMethods)

+(Student*)createUniqueStudentInContext:(NSManagedObjectContext*)context withName:(NSString*)name withAge:(NSNumber*)age withPhone:(NSString*)phone withAddress:(NSString*)address withAttendingClass:(Classroom*)attendingClass{
	NSEntityDescription *entityDescription = [NSEntityDescription
											  
											  entityForName:@"Student" inManagedObjectContext:context];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @" name == %d AND age == %@ AND phone == %@", name, age, phone];
	[request setPredicate:predicate];
	NSError *error;
	NSArray *array = [context executeFetchRequest:request error:&error];
	Student* student = [array firstObject];
	
	if (![array count]){
		student = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Student"
                              inManagedObjectContext:context];
		student.name = name;
		student.age = age;
		student.phone = phone;
		student.address = address;
		student.attendingClass = attendingClass;
		NSError *error;
		[context save:&error];
		[context.parentContext performBlockAndWait:^{
			NSError *error;
			[context.parentContext save:&error];
		}];
		
	}
	return student;
}

@end
