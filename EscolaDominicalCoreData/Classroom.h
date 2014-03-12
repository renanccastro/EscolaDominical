//
//  Classroom.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 12/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Material, Student, Teacher;

@interface Classroom : NSManagedObject

@property (nonatomic, retain) NSNumber * maxStudents;
@property (nonatomic, retain) NSNumber * minAge;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSSet *materials;
@property (nonatomic, retain) NSSet *students;
@property (nonatomic, retain) NSSet *teachers;
@end

@interface Classroom (CoreDataGeneratedAccessors)

- (void)addMaterialsObject:(Material *)value;
- (void)removeMaterialsObject:(Material *)value;
- (void)addMaterials:(NSSet *)values;
- (void)removeMaterials:(NSSet *)values;

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

- (void)addTeachersObject:(Teacher *)value;
- (void)removeTeachersObject:(Teacher *)value;
- (void)addTeachers:(NSSet *)values;
- (void)removeTeachers:(NSSet *)values;

@end
