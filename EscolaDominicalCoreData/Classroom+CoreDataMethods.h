//
//  Classroom+CoreDataMethods.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 11/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Classroom.h"

@interface Classroom (CoreDataMethods)
+(Classroom*) createNewClassroomInContext:(NSManagedObjectContext*)context WithName:(NSString*)name withMaxStudents:(NSNumber*)maxStudents withMinAge:(NSNumber*)minAge withMaterials:(NSSet*)materials withStudents:(NSSet*)students andWithTeachers:(NSSet*)teachers;
@end
