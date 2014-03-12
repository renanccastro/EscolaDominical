//
//  ClassCell.h
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 12/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
