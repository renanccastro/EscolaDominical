//
//  Material+CoreDataMethods.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 12/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Material.h"

@interface Material (CoreDataMethods)
+(Material*)createUniqueMaterialInContext:(NSManagedObjectContext*)context withName:(NSString*)name withAuthor:(NSString*)author;
@end
