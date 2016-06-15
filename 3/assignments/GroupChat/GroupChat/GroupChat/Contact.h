
#ifndef Contact_h
#define Contact_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic,assign) NSString *name;
@property (nonatomic,assign) NSString *imageUrl;

- (id)initWithMessageName:(NSString *)con image:(NSString *)image;

@end

#endif /* Contact_h */
