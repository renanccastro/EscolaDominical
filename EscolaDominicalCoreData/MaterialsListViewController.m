//
//  MaterialsListViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 12/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "MaterialsListViewController.h"
#import "Store.h"
#import "MaterialsListViewController.h"
#import "Material.h"
#import "StudentCell.h"
#import "MaterialCollectionViewController.h"

@interface MaterialsListViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic) NSManagedObjectContext* context;
@property (nonatomic) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic) Material* selectedMaterial;

@end

@implementation MaterialsListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.context = [[Store sharedManager] mainManagedObjectContext];
	self.context.undoManager = nil;
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
	
}
-(void)viewWillAppear:(BOOL)animated{
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	self.fetchedResultsController = nil;
	
}

#pragma mark Core Data methods

- (NSFetchedResultsController *)fetchedResultsController {
	
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
	
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
								   entityForName:@"Material" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
	
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
							  initWithKey:@"name" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	
    [fetchRequest setFetchBatchSize:20];
	
    NSFetchedResultsController *theFetchedResultsController =
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
										managedObjectContext:self.context sectionNameKeyPath:nil
												   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
	
    return _fetchedResultsController;
	
}
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	
    UITableView *tableView = self.tableView;
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(StudentCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
			
        case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray
											   arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[tableView insertRowsAtIndexPaths:[NSArray
											   arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


#pragma mark	UITableView Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo =
	[[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (void)configureCell:(StudentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Material *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.name.text = info.name;
	//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
	//								 info.city, info.state];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
    StudentCell *cell =
	[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	self.selectedMaterial = [_fetchedResultsController objectAtIndexPath:indexPath];
	[self performSegueWithIdentifier:@"seeMaterial" sender:nil];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if ([[segue identifier] isEqualToString:@"seeMaterial"]) {
		MaterialCollectionViewController* vc = [segue destinationViewController];
		vc.currentMaterial = self.selectedMaterial;
	}
}


@end
