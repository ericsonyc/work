

#import <UIKit/UIKit.h>
#import "CTCollectionViewDataSource.h"

@interface CTCollectionViewLayout : UICollectionViewLayout

@property (strong,nonatomic) CTCollectionViewDataSource* dataSource;

@end
