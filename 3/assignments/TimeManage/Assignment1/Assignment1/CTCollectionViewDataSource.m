

#import "CTCollectionViewDataSource.h"
#import "CTCourseInfo.h"
#import "CTCollectionViewCell.h"
#import "CTHeadViewCell.h"

@implementation CTCollectionViewDataSource

- (id)init{
    
    self = [super init];
    if (self!=nil)
    {
        [self initTestData];
    }
    return self;
}

-(void) initTestData{
    CTCourseInfo *courseInfo = [[CTCourseInfo alloc]init];
    courseInfo.courseId = 0;
    courseInfo.day = 0;
    courseInfo.startCourseNum = 0;
    courseInfo.courseLen = 1;
    courseInfo.courseName = @"English";
    
    CTCourseInfo *courseInfo2 = [[CTCourseInfo alloc]init];
    courseInfo2.courseId = 1,
    courseInfo2.day = 0;
    courseInfo2.startCourseNum = 2;
    courseInfo2.courseLen = 1;
    courseInfo2.courseName = @"Maths";

    
    CTCourseInfo *courseInfo3 = [[CTCourseInfo alloc]init];
    courseInfo3.courseId = 2;
    courseInfo3.day = 0;
    courseInfo3.startCourseNum = 5;
    courseInfo3.courseLen = 1;
    courseInfo3.courseName = @"Music";

    
    CTCourseInfo *courseInfo4 = [[CTCourseInfo alloc]init];
    courseInfo4.courseId = 3;
    courseInfo4.day = 1;
    courseInfo4.startCourseNum = 1;
    courseInfo4.courseLen = 1;
    courseInfo4.courseName = @"History";

    
    CTCourseInfo *courseInfo5 = [[CTCourseInfo alloc]init];
    courseInfo5.courseId = 4;
    courseInfo5.day = 1;
    courseInfo5.startCourseNum = 4;
    courseInfo5.courseLen = 1;
    courseInfo5.courseName = @"Geographic";

    
    CTCourseInfo *courseInfo6 = [[CTCourseInfo alloc]init];
    courseInfo6.courseId = 5;
    courseInfo6.day = 1;
    courseInfo6.startCourseNum =7;
    courseInfo6.courseLen = 1;
    courseInfo6.courseName = @"P.E.";

    
    
    CTCourseInfo *courseInfo7 = [[CTCourseInfo alloc]init];
    courseInfo7.courseId = 6;
    courseInfo7.day = 2;
    courseInfo7.startCourseNum =0;
    courseInfo7.courseLen = 1;
    courseInfo7.courseName = @"Chemistry";

    
    CTCourseInfo *courseInfo8 = [[CTCourseInfo alloc]init];
    courseInfo8.courseId = 7;
    courseInfo8.day = 2;
    courseInfo8.startCourseNum =6;
    courseInfo8.courseLen = 1;
    courseInfo8.courseName = @"English";

    
    CTCourseInfo *courseInfo9 = [[CTCourseInfo alloc]init];
    courseInfo9.courseId = 8;
    courseInfo9.day = 3;
    courseInfo9.startCourseNum =1;
    courseInfo9.courseLen = 1;
    courseInfo9.courseName = @"Maths";

    
    CTCourseInfo *courseInfo10 = [[CTCourseInfo alloc]init];
    courseInfo10.courseId = 9;
    courseInfo10.day = 3;
    courseInfo10.startCourseNum =6;
    courseInfo10.courseLen = 1;
    courseInfo10.courseName = @"History";

    
    CTCourseInfo *courseInfo11 = [[CTCourseInfo alloc]init];
    courseInfo11.courseId = 10;
    courseInfo11.day = 4;
    courseInfo11.startCourseNum =2;
    courseInfo11.courseLen = 1;
    courseInfo11.courseName = @"Polotical";

    
    CTCourseInfo *courseInfo12 = [[CTCourseInfo alloc]init];
    courseInfo12.courseId = 11;
    courseInfo12.day = 4;
    courseInfo12.startCourseNum =4;
    courseInfo12.courseLen = 1;
    courseInfo12.courseName = @"English";

    
    _courseInfoArray = [NSMutableArray arrayWithObjects:courseInfo,courseInfo2,courseInfo3,courseInfo4,courseInfo5,courseInfo6,courseInfo7,courseInfo8,courseInfo9,courseInfo10,courseInfo11,courseInfo12,nil];
}

- (NSArray *)indexPathsOfEventsBetweenMinDay:(int)minDay andMaxDay:(int)maxDay betweenCourseNum:(int)startCourseNum andCourseNum:(int)endCourseNum
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for(int i = 0; i < _courseInfoArray.count ; ++i){
        CTCourseInfo *course = [_courseInfoArray objectAtIndex:i];
        if(course.day >= minDay && course.day <= maxDay && course.startCourseNum >= startCourseNum && course.startCourseNum + course.courseLen -1 <= endCourseNum){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [indexPaths addObject:indexPath];
        }
    }
    return indexPaths;
}


- (NSComparisonResult) myCompare:(CTCourseInfo *)courseinfo {
    CTCourseInfo *now = (CTCourseInfo *)self;
    if(now.day > courseinfo.day)
        return NSOrderedAscending;
    else if(now.day < courseinfo.day)
        return NSOrderedDescending;
    else{
        if(now.startCourseNum >courseinfo.startCourseNum)
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }
}

- (NSArray *)sortByDayAndCourseNumber{
    [_courseInfoArray sortUsingComparator:^NSComparisonResult(id obj1,id obj2){
        CTCourseInfo *first = (CTCourseInfo *)obj1;
        CTCourseInfo *second = (CTCourseInfo *)obj2;
        if(first.day < second.day)
            return NSOrderedAscending;
        else if(first.day > second.day)
            return NSOrderedDescending;
        else{
            if(first.startCourseNum < second.startCourseNum)
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
        }
    }];
    return _courseInfoArray;
}
@end
