

#import <Foundation/Foundation.h>

@interface CTCourseInfo : NSObject

@property int day;
@property int startCourseNum;
@property int courseLen;
@property int courseId;
@property (strong,nonatomic) NSString *courseAddress;
@property (strong,nonatomic) NSString *coursePeriod;
@property (strong,nonatomic) NSString *courseName;

@end
