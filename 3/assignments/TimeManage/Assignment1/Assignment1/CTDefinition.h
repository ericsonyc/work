

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DAY_COUNT 5
#define COURSE_COUNT 8
#define HEAD_CELL_WIDTH 42.8
#define HEAD_CELL_HIGHT 25
#define LEFT_EDGE_CELL_WIDTH 19
#define LEFT_EDGE_CELL_HIGHT 50
#define COURSE_CELL_WIDTH 42.8
#define COURSE_CELL_HIGHT 50

#define HEADER_DAY_HEIGHT 30
#define INDICATOR_INDEX 6
#define HEADER_DAY_WIDTH 320/5

#define TABLE_VIEW_TAG_BASE 3000
#define DAY_LABEL_TAG_BASE 1000
#define DAY_BUTTON_TAG_BASE 2000

#define BLUE_COLOR 0x007AFF

@interface CTDefinition : NSObject

+(UIColor*)Rgb2UIColor:(NSInteger)r g:(NSInteger)g b:(NSInteger)b;
+(UIColor*)UIColorFromRGB:(NSInteger)rgbValue;

@end