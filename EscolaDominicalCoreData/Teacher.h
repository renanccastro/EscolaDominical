//
//  Teacher.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 11/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Classroom;

@interface Teacher : NSManagedObject

@property (nonatomic, retain) NSString * formation;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSSet *responsibleClasses;
@end

@interface Teacher (CoreDataGeneratedAccessors)

- (void)addResponsibleClassesObject:(Classroom *)value;
- (void)removeResponsibleClassesObject:(Classroom *)value;
- (void)addResponsibleClasses:(NSSet *)values;
- (void)removeResponsibleClasses:(NSSet *)values;

@end
