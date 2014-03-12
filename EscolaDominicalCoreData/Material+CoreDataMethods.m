//
//  Material+CoreDataMethods.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 12/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Material+CoreDataMethods.h"

@implementation Material (CoreDataMethods)
+(Material*)createUniqueMaterialInContext:(NSManagedObjectContext*)context withName:(NSString*)name withAuthor:(NSString*)author{
	NSEntityDescription *entityDescription = [NSEntityDescription
											  
											  entityForName:@"Material" inManagedObjectContext:context];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @" name == %d AND author == %@", name, author];
	[request setPredicate:predicate];
	NSError *error;
	NSArray *array = [context executeFetchRequest:request error:&error];
	Material* material = [array firstObject];
	
	if (![array count]){
		material = [NSEntityDescription
				   insertNewObjectForEntityForName:@"Material"
				   inManagedObjectContext:context];
		material.name = name;
		material.author = author;
		NSError *error;
		[context save:&error];
		[context.parentContext performBlock:^{
			NSError *error;
			[context.parentContext save:&error];
		}];
		
	}
	return material;
}
@end
