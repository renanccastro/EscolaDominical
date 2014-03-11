//
//  Classroom+CoreDataMethods.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 11/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Classroom+CoreDataMethods.h"

@implementation Classroom (CoreDataMethods)

+(Classroom*) createNewClassroomInContext:(NSManagedObjectContext*)context WithName:(NSString*)name withMaxStudents:(NSNumber*)maxStudents withMinAge:(NSNumber*)minAge withMaterials:(NSSet*)materials withStudents:(NSSet*)students andWithTeachers:(NSSet*)teachers{
	NSEntityDescription *entityDescription = [NSEntityDescription
											  
											  entityForName:@"Classroom" inManagedObjectContext:context];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @" name == %d AND maxStudents == %@ AND minAge == %@", name, maxStudents, minAge];
	[request setPredicate:predicate];
	NSError *error;
	NSArray *array = [context executeFetchRequest:request error:&error];
	Classroom* class = [array firstObject];
	
	if (!class){
		class = [NSEntityDescription
				   insertNewObjectForEntityForName:@"Classroom"
				   inManagedObjectContext:context];
		class.name = name;
		class.minAge = minAge;
		class.maxStudents = maxStudents;
		[class addTeachers:teachers];
		[class addStudents:students];
		[class addMaterials:materials];
		
		NSError *error;
		[context save:&error];
		[context.parentContext performBlock:^{
			NSError *error;
			[context.parentContext save:&error];
		}];
		
	}
	return class;

	
}


@end
