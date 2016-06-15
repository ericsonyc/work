

#import <Foundation/Foundation.h>

@interface CTCollectionViewDataSource : NSObject

@property (strong,nonatomic) NSMutableArray *courseInfoArray;

- (NSArray *)indexPathsOfEventsBetweenMinDay:(int)minDay andMaxDay:(int)maxDay betweenCourseNum:(int)startCourseNum andCourseNum:(int)endCourseNum;
- (NSArray *)sortByDayAndCourseNumber;

@end
