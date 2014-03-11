//
//  Teacher+CoreDataMethods.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 11/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Teacher.h"

@interface Teacher (CoreDataMethods)
+(Teacher*)createUniqueTeacherInContext:(NSManagedObjectContext*)context withName:(NSString*)name withAge:(NSNumber*)age withPhone:(NSString*)phone withAddress:(NSString*)address withFormation:(NSString*)formation;
@end
