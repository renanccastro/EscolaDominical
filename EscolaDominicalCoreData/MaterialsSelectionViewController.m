//
//  MaterialsSelectionViewController.m
//  EscolaDominicalCoreData
//
//  Created by Renan Camargo de Castro on 10/03/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "MaterialsSelectionViewController.h"
#import "Store.h"
#import "SelectionCell.h"
#import "Material.h"

@interface MaterialsSelectionViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;


@end

@implementation MaterialsSelectionViewController

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
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
}
- (IBAction)didChangeSwitch:(UISwitch*)sender {
	CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
	[self didChangeStatusSwitch:indexPath toStatus:sender.isOn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
							  initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	
    [fetchRequest setFetchBatchSize:20];
	
    NSFetchedResultsController *theFetchedResultsController =
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
										managedObjectContext:self.context sectionNameKeyPath:@"name"
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
            [self configureCell:(SelectionCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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


-(void)didChangeStatusSwitch:(NSIndexPath*) indexPath toStatus:(BOOL)status{
	Material* selectedMaterial = [_fetchedResultsController objectAtIndexPath:indexPath];
	NSLog(@"%@",selectedMaterial.name);
	if (status) {
		[self.selectedMaterials addObject:selectedMaterial];
	}
	else{
		[self.selectedMaterials removeObject:selectedMaterial];
	}
}

#pragma mark	UITableView Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo =
	[[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [[self.fetchedResultsController sections] count];
}

- (void)configureCell:(SelectionCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Material *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.name.text = info.name;
	cell.photo.image = info.photo ? [UIImage imageWithData:info.photo] : [UIImage imageNamed:@"noPhoto"];
	cell.selectedStatus.on = [self.selectedMaterials containsObject:info];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
    SelectionCell *cell =
	[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

- (NSArray *) sectionIndexTitlesForTableView: (UITableView *) tableView
{
    return [self.fetchedResultsController sectionIndexTitles];
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

@end