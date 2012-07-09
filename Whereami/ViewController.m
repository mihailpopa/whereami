//
//  ViewController.m
//  Whereami
//
//  Created by Mihai Popa on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "BNRMapPoint.h"

@interface ViewController ()

@end

@implementation ViewController


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        //Createlocation manager object
        locationManager = [[CLLocationManager alloc] init];
        
        
        [locationManager setDelegate:self];
        
        //And we want it to be as accurate as possible
        //regardless of how much time/power it takes
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        //Tell our manager to start looking for its location immediately
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //Update position (like using the cllocation manager
    [worldView setShowsUserLocation:YES];
    [worldView setMapType:MKMapTypeHybrid];
    
    [segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
 

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

-(void) locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
    
    //How many seconds ago was this new location created
    NSTimeInterval t = [[newLocation timestamp]timeIntervalSinceNow];
    
    //CLLocationManagers will return the last found location 
    //of the device first, you don't want that data in this case
    //If the location was made more than 3 minutes ago, ignore it
    if (t < -180)
    {
        //This is cached data, you don't want it. Keep looking
        return;
    }
    
[self foundLocation:newLocation];
}
-(void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}
-(void)dealloc
{
    //Tell the location manager to stop sending us messages
    [locationManager setDelegate:nil];
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //This is the callback for the position... How do we actually zoom?
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
[self findLocation];

[textField resignFirstResponder];

return YES;
}

-(void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}
-(void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    
//Create an instance of BNRMapPoint with the current data

BNRMapPoint *mp = [[BNRMapPoint alloc]initWithCoordinate:coord title:[locationTitleField text]];

//Add it to the map view
[worldView addAnnotation:mp];

//Zoom the region to this location
MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250,250);
[worldView setRegion:region  animated:YES];

//Reset the UI
[locationTitleField setText:@""];
[activityIndicator stopAnimating];
[locationTitleField setHidden:NO];
[locationManager stopUpdatingLocation];

}

-(void)segmentedControlChanged:(UISegmentedControl*)sender
{
    if ([sender selectedSegmentIndex]==0)
        [worldView setMapType:MKMapTypeHybrid];
        else if ([sender selectedSegmentIndex]==1)
            [worldView setMapType:MKMapTypeSatellite];  
    else
        [worldView setMapType:MKMapTypeStandard];  

}

@end
