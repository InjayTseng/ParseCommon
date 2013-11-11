//
//  ViewController.m
//  ParseCommon
//
//  Created by David Tseng on 11/11/13.
//  Copyright (c) 2013 David Tseng. All rights reserved.
//

#import "ViewController.h"
#import "ParseCommon.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)btnShowSubscribes:(id)sender {

    [ParseCommon showSubscribeChannels];
}
- (IBAction)btnSubscribe:(id)sender {
    
    [ParseCommon subscribeChannel:@"Youbike"];
}
- (IBAction)btnUnsubscribe:(id)sender {
    
    [ParseCommon unsubscribeChannel:@"Youbike"];
}

- (IBAction)btnSignIn:(id)sender {
    
    [ParseCommon signUpByName:@"David Tseng" andPassword:@"08220822"];
}

- (IBAction)btnLogin:(id)sender {
    
    [ParseCommon loginByName:@"David Tseng" andPassword:@"08220822"];
}

- (IBAction)btnShowCurrentUser:(id)sender {
    
    [ParseCommon currentUser];
}

- (IBAction)btnFacebookLogin:(id)sender {
    
    [ParseCommon logInWithFacebookByPermissions:@[@"publish_stream"]];
    
}

- (IBAction)btnPermissions:(id)sender {
    

    [ParseCommon reauthorizeUserByPermissions:@[@"publish_stream"]];

}

- (IBAction)btnFacebookLink:(id)sender {
    
    [ParseCommon linkToFacebook:[PFUser currentUser]];
}

- (IBAction)btnFacbookUnlink:(id)sender {
    
    
    [ParseCommon unlinkToFacebook:[PFUser currentUser]];
}

#pragma mark - In-App Purchase

-(IBAction)btnCheckBuyItems:(id)sender{


    [ParseCommon addObserverForProduct:@"com.inoinoletitbe.ParseCommon.adfree"];
}


-(IBAction)btnBuyItem:(id)sender{
    

    [ParseCommon buyProduct:@"com.inoinoletitbe.ParseCommon.adfree"];
}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
