//
//  Teacher+CoreDataMethods.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 11/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Teacher+CoreDataMethods.h"

@implementation Teacher (CoreDataMethods)
+(Teacher*)createUniqueTeacherInContext:(NSManagedObjectContext*)context withName:(NSString*)name withAge:(NSNumber*)age withPhone:(NSString*)phone withAddress:(NSString*)address withFormation:(NSString*)formation{
	NSEntityDescription *entityDescription = [NSEntityDescription
											  
											  entityForName:@"Teacher" inManagedObjectContext:context];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @" name == %d AND age == %@ AND phone == %@", name, age, phone];
	[request setPredicate:predicate];
	NSError *error;
	NSArray *array = [context executeFetchRequest:request error:&error];
	Teacher* teacher = [array firstObject];
	
	if (![array count]){
		teacher = [NSEntityDescription
				   insertNewObjectForEntityForName:@"Teacher"
				   inManagedObjectContext:context];
		teacher.name = name;
		teacher.age = age;
		teacher.phone = phone;
		teacher.address = address;
		teacher.formation = formation;
		NSError *error;
		[context save:&error];
		[context.parentContext performBlock:^{
			NSError *error;
			[context.parentContext save:&error];
		}];
		
	}
	return teacher;
}
@end
