//
//  BNRMapPoint.m
//  Whereami
//
//  Created by Mihai Popa on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint
@synthesize coordinate;
@synthesize title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    if (self = [super init])
    {
        coordinate = c;
        title = t;
    }
    return self;
}

//Override init to use the designated initializer
-(id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(46, 25) title:@"Romania"];
}
@end
