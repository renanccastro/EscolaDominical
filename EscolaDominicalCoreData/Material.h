//
//  Material.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 12/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Classroom;

@interface Material : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSSet *classesThatUses;
@end

@interface Material (CoreDataGeneratedAccessors)

- (void)addClassesThatUsesObject:(Classroom *)value;
- (void)removeClassesThatUsesObject:(Classroom *)value;
- (void)addClassesThatUses:(NSSet *)values;
- (void)removeClassesThatUses:(NSSet *)values;

@end
