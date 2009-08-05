//
//  HomeViewController.m
//  Yammer
//
//  Created by aa on 1/27/09.
//  Copyright 2009 Yammer Inc. All rights reserved.
//

#import "FeedsViewController.h"
#import "FeedMessageList.h"
#import "APIGateway.h"
#import "LocalStorage.h"
#import "FeedCache.h"
#import "NSString+SBJSON.h"

@implementation FeedsViewController

@synthesize theTableView;
@synthesize dataSource;
@synthesize spinnerWithText;
@synthesize wrapper;

- (id)init {
  self.spinnerWithText = [[SpinnerWithText alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
  
  UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                           target:self
                                                                           action:@selector(refresh)];  
  self.navigationItem.leftBarButtonItem = refresh;  
  [refresh release];

  self.wrapper = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];  
  theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 320, 337) style:UITableViewStylePlain];
  
	theTableView.autoresizingMask = (UIViewAutoresizingNone);
	theTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	
	theTableView.delegate = self;
  self.dataSource = [FeedsTableDataSource getFeeds:nil];
	theTableView.dataSource = self.dataSource;
  [wrapper addSubview:theTableView];
  [wrapper addSubview:self.spinnerWithText];
    
  [spinnerWithText displayLoading];
  [spinnerWithText showTheSpinner];
  [NSThread detachNewThreadSelector:@selector(loadFeeds:) toTarget:self withObject:@"silent"];  
  
	return self;
}

- (void)loadView {    
  self.view = wrapper;
}

- (void)loadFeeds:(NSString *)style {
  NSAutoreleasePool *autoreleasepool = [[NSAutoreleasePool alloc] init];

  NSMutableDictionary *dict;
  NSString *cached = [LocalStorage getFile:USER_CURRENT];
  if (cached && style != nil)
    dict = (NSMutableDictionary *)[cached JSONValue];
  else {
    dict = [APIGateway usersCurrent:style];
    if (dict == nil && cached)
      dict = (NSMutableDictionary *)[cached JSONValue];  
  }
  self.dataSource = [FeedsTableDataSource getFeeds:dict];
	theTableView.dataSource = self.dataSource;
  
  [theTableView reloadData];
  [self.spinnerWithText hideTheSpinner];
  [self.spinnerWithText setText:[FeedCache niceDate:[LocalStorage getFileDate:USER_CURRENT]]];
  [autoreleasepool release];
}

- (void)refresh {
  [spinnerWithText displayCheckingNew];
  [spinnerWithText showTheSpinner];
  [NSThread detachNewThreadSelector:@selector(loadFeeds:) toTarget:self withObject:nil];  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  
  
  [theTableView deselectRowAtIndexPath:indexPath animated:YES];
  FeedMessageList *localFeedMessageList = [[FeedMessageList alloc] 
                                           initWithDict:[dataSource feedAtIndex:indexPath.row] 
                                           threadIcon:true
                                           refresh:false
                                           compose:true];
  [self.navigationController pushViewController:localFeedMessageList animated:YES];
  [localFeedMessageList release];
}

- (void)dealloc {
  [super dealloc];
  [theTableView release];
  [spinnerWithText release];
  [wrapper release];
  [dataSource release];
}


@end
