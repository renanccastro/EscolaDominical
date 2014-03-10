//
//  Student.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 10/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Attendence, Classroom;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSSet *attendances;
@property (nonatomic, retain) Classroom *attendingClass;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addAttendancesObject:(Attendence *)value;
- (void)removeAttendancesObject:(Attendence *)value;
- (void)addAttendances:(NSSet *)values;
- (void)removeAttendances:(NSSet *)values;

@end
