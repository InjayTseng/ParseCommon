//
//  ViewController.m
//  ParseCommon
//
//  Created by David Tseng on 11/11/13.
//  Copyright (c) 2013 David Tseng. All rights reserved.
//

#import "DemoViewController.h"

#import "DTParse.h"
@interface DemoViewController ()<FBFriendPickerDelegate>
@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
@end

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)btnShowSubscribes:(id)sender {

    [DTParse showSubscribeChannels];
}
- (IBAction)btnSubscribe:(id)sender {
    
    [DTParse subscribeChannel:@"Youbike"];
}
- (IBAction)btnUnsubscribe:(id)sender {
    
    [DTParse unsubscribeChannel:@"Youbike"];
}

- (IBAction)btnSignIn:(id)sender {
    
    [DTParse signUpByName:@"David Tseng" andPassword:@"08220822"];
}

- (IBAction)btnLogin:(id)sender {
    
    [DTParse loginByName:@"David Tseng" andPassword:@"08220822"];
}

- (IBAction)btnShowCurrentUser:(id)sender {
    
    [DTParse currentUser];
}

- (IBAction)btnFacebookLogin:(id)sender {
    
    [DTParse logInWithFacebookByPermissions:@[@"publish_stream",@"read_friendlists"]];
    
}

- (IBAction)btnPermissions:(id)sender {
    
    [DTParse reauthorizeUserByPermissions:@[@"publish_stream",@"read_friendlists"]];

}

- (IBAction)btnFacebookLink:(id)sender {
    
    [DTParse linkToFacebook:[PFUser currentUser]];
}

- (IBAction)btnFacbookUnlink:(id)sender {
    
    
    [DTParse unlinkToFacebook:[PFUser currentUser]];
}


#pragma mark - Facebook Friend Picker

- (IBAction)pickFriendsButtonClick:(id)sender {
    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error) {
                                          if (error) {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:error.localizedDescription
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                              [alertView show];
                                          } else if (session.isOpen) {
                                              [self pickFriendsButtonClick:sender];
                                          }
                                      }];
        return;
    }
    
    if (self.friendPickerController == nil) {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Pick Friends";
        self.friendPickerController.delegate = self;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    [self presentViewController:self.friendPickerController animated:YES completion:nil];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender {
    NSMutableString *text = [[NSMutableString alloc] init];
    
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        if ([text length]) {
            [text appendString:@", "];
        }
        [text appendString:user.name];
        [text appendString:[user id]];
        NSLog(@"Choose %@",text);
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender {
    NSLog(@"Cancel ");
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
