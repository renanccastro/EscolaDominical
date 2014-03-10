//
//  Attendence.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 10/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Attendence : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Student *student;

@end
