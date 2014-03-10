//
//  Material.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 10/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Classroom;

@interface Material : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) Classroom *classesThatUses;

@end
