//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Mihai Popa on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BNRMapPoint : NSObject <MKAnnotation>
{
}

//A new designated initializer for instances of BNRMapPoint
-(id)initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString*)t;

//This is requierd property from MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//This is an optional property from MKAnnotation
@property (nonatomic, copy) NSString *title;

@end
