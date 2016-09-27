//
//  ViewController.m
//  TableViewSelectedCheckMarks
//
//  Created by Enterpi mini mac on 9/27/16.
//  Copyright © 2016 Enterpi mini mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *languagesTableView;

@property (strong, nonatomic) NSArray *languagesArray;

@property (strong, nonatomic) NSMutableArray *checkMarksArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.languagesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.languagesArray = [NSArray arrayWithObjects:@"English",@"Spanish",@"Russian",@"Arabic",@"Portuguese",@"French",@"German", nil];
    self.checkMarksArray = [[NSMutableArray alloc]init];
    if( [[NSUserDefaults standardUserDefaults]objectForKey:@"selectedRowsArray"])
    {
       self.checkMarksArray = [[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedRowsArray"] mutableCopy];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.languagesArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *languagesCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    languagesCell.textLabel.text = self.languagesArray[indexPath.row];
    if([self.checkMarksArray containsObject:[NSNumber numberWithLong:indexPath.row]])
    {
        languagesCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        languagesCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:self.checkMarksArray forKey:@"selectedRowsArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    return languagesCell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.checkMarksArray containsObject:[NSNumber numberWithLong:indexPath.row]])
    {
        [self.checkMarksArray removeObject:[NSNumber numberWithLong:indexPath.row]];
    }
    else
    {
        [self.checkMarksArray addObject:[NSNumber numberWithLong:indexPath.row]];
    }
    
    [self.languagesTableView reloadData];
}

@end
