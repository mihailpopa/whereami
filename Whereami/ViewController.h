//
//  ViewController.h
//  Whereami
//
//  Created by Mihai Popa on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface ViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
    IBOutlet UISegmentedControl *segmentedControl;
}

-(void)findLocation;
-(void)foundLocation:(CLLocation*) loc;
-(void)segmentedControlChanged:(UISegmentedControl*)sender;
@end
