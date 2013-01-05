//
//  GHNAppDelegate.h
//  Github Status
//
//  Created by David Underwood on 12-12-11.
//  Copyright (c) 2012 David Underwood. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class GHNTrack;

@interface GHNAppDelegate : NSObject <NSApplicationDelegate>

@property (strong) NSStatusItem *statusItem;
@property (weak) IBOutlet NSMenu *statusMenu;

@property (strong) NSTimer *updateTimer;
@property (strong) NSMutableData *receivedData;

- (void)onTimerFire:(NSTimer*)theTimer;
- (void)scheduleTimer;

- (IBAction)refresh:(id)sender;

@end
