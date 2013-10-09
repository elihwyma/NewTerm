// MobileTerminalAppDelegate.m
// MobileTerminal

#import "MobileTerminalAppDelegate.h"
#import "MobileTerminalViewController.h"

#import "Preferences/Settings.h"
#import "Preferences/MenuSettings.h"

@implementation MobileTerminalAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize terminalViewController;
@synthesize preferencesViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	
	NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
	[viewControllers addObject:terminalViewController];	 
	[navigationController setViewControllers:viewControllers animated:NO];
	[viewControllers release];
		
	[window addSubview:navigationController.view];
	[window makeKeyAndVisible];
	inPreferences = FALSE;
}

static const NSTimeInterval kAnimationDuration = 1.00f;

- (void)preferencesButtonPressed {
	inPreferences = TRUE;
	[navigationController setNavigationBarHidden:NO];
	[navigationController pushViewController:preferencesViewController animated:YES];
}

- (void)rootViewDidAppear
{
	if (inPreferences) {
		[[Settings sharedInstance] persist];
	}
	inPreferences = TRUE;

	// This must be invoked after the animation to show the root view completes
	[navigationController setNavigationBarHidden:YES];	
}

@end
