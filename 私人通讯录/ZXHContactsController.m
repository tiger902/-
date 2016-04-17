//
//  ZXHContactsController.m
//  私人通讯录
//
//  Created by zengxiaohu on 16/4/11.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import "ZXHContactsController.h"
#import "ZXHContact.h"
#import "ZXHContactTableViewCell.h"
#import "ZXHAddContactsController.h"
#import "ZXHEditContactViewController.h"

@interface ZXHContactsController ()<ZXHAddContactsControllerDelegate,ZXHEditContactViewControllerDelegate>

@property (nonatomic,strong) NSMutableArray *arrContacts;

@end

@implementation ZXHContactsController

-(NSString*)nameOfContactsplistFile{
    
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *plistContact=[documentPath stringByAppendingPathComponent:@"Contacts.plist"];
    
//    NSLog(@"%@",plistContact);
    
    return plistContact;
}

-(void)archiveContactsToPlist:(NSMutableArray *)dataContact{
    
    NSString *plist=[self nameOfContactsplistFile];
    
    [NSKeyedArchiver archiveRootObject:dataContact toFile:plist];
}

-(NSMutableArray *)arrContacts{
    
    
    if (_arrContacts==nil) {
        
        NSString *plistContact=[self nameOfContactsplistFile];
        
        _arrContacts=[NSKeyedUnarchiver unarchiveObjectWithFile:plistContact];
        
        if (_arrContacts==nil) {
            
            _arrContacts=[NSMutableArray array];
            
        }
    }
    
    return _arrContacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.allowsSelection=YES;
    self.tableView.allowsSelectionDuringEditing=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)deleteContactsBarButtonItem:(id)sender {
    
    //self.tableView.editing=!self.tableView.editing;
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (IBAction)logoutBarButtonItem:(id)sender {
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"你确定注销吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController  addAction:cancelAction];
    
    [alertController addAction:sureAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.arrContacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier=@"contactCell";
    
    ZXHContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.contact=self.arrContacts[indexPath.row];
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
    
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.arrContacts removeObjectAtIndex:indexPath.row];
        
        [self archiveContactsToPlist:self.arrContacts];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UIViewController *viewController=segue.destinationViewController;
    
    if ([viewController isKindOfClass:[ZXHAddContactsController class]]) {
        
        ZXHAddContactsController *addContactsController=(ZXHAddContactsController*)viewController;
        
        addContactsController.delegate=self;
    } else if ([viewController isKindOfClass:[ZXHEditContactViewController class]]){
        
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        
        ZXHContact *editContact=self.arrContacts[indexPath.row];
        
        ZXHEditContactViewController *editContactViewController=(ZXHEditContactViewController*)viewController;
        editContactViewController.contact=editContact;
        
        editContactViewController.delegate=self;
    }
}

#pragma mark--ZXHAddContactsControllerDelegate
-(void)ZXHAddContactsController:(ZXHAddContactsController *)addContactsController ZXHContact:(ZXHContact *)contact{
    
    [self.arrContacts addObject:contact];
    
    [self archiveContactsToPlist:self.arrContacts];
    
    [self.tableView reloadData];
}

#pragma mark--ZXHEditContactViewControllerDelegate
-(void)ZXHEditContactViewController:(ZXHEditContactViewController *)editContactViewController resultOfEditContact:(ZXHContact *)contact{
    
    NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
    
    [self.arrContacts replaceObjectAtIndex:indexPath.row withObject:contact];
    
    [self archiveContactsToPlist:self.arrContacts];
    
    //[self.tableView reloadData];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
