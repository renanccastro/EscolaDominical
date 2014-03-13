//
//  Student+CoreDataMethods.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 27/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Student.h"
#import "Classroom.h"

@interface Student (CoreDataMethods)
+(Student*)createUniqueStudentInContext:(NSManagedObjectContext*)context withName:(NSString*)name withAge:(NSNumber*)age withPhone:(NSString*)phone withAddress:(NSString*)address withAttendingClass:(Classroom*)attendingClass;
@end
