//
//  GHNAppDelegate.m
//  Github Status
//
//  Created by David Underwood on 12-12-11.
//  Copyright (c) 2012 David Underwood. All rights reserved.
//

#import "GHNAppDelegate.h"

@implementation GHNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self scheduleTimer];
}

- (void) awakeFromNib {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    self.statusItem.title = @"G";
    
    self.statusItem.menu = self.statusMenu;
    self.statusItem.highlightMode = YES;
}

- (void)scheduleTimer {
    if(self.updateTimer) {
        [self.updateTimer invalidate];
    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTimerFire:) userInfo:nil repeats:YES];
    self.updateTimer = timer;
}

- (void)onTimerFire:(NSTimer*)theTimer {
    [self doNetworkThing];
}

- (void)doNetworkThing {
    
    NSURL *URL = [NSURL URLWithString: @"https://status.github.com/api/status.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: URL];
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request delegate:self];
    
    self.receivedData = [[NSMutableData alloc] init];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error {
    // do something with error here
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: self.receivedData options: NSJSONReadingMutableContainers error: nil];
    
    self.statusItem.title = [JSON valueForKey:@"status"];
    

}

@end
