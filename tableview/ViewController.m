

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.fruits = @[@"Apple", @"Pineapple", @"Orange", @"Banana", @"Pear", @"Kiwi", @"Strawberry", @"Mango", @"Walnut", @"Apricot", @"Tomato", @"Almond", @"Date", @"Melon", @"Water Melon", @"Lemon", @"Blackberry", @"Coconut", @"Fig", @"Passionfruit", @"Star Fruit"];
    
    self.alphabetizedFruits = [self alphabetizeFruits:self.fruits];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // number of section is eacj keys of buffer.
    NSArray *keys = [self.alphabetizedFruits allKeys];
    return [keys count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *unsortedKeys = [self.alphabetizedFruits allKeys];
    
    NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSString *key = [sortedKeys objectAtIndex:section];
    NSArray *fruitsForSection = [self.alphabetizedFruits objectForKey:key];
    return [fruitsForSection count];
    // count each element in the nssarray.
   // return [self.fruits count];
}
// creat cell by using uitablecell class.

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *CellIdentifier = @"Cell Identifier";
    // table view just only display table on the screen, and then do nothing.
    // table view will ask which class will implement to creat cell for each row.
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    // initialise the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // write text on the each cell.
    
    //fetch fruit.
    NSArray *unsortedKeys = [self.alphabetizedFruits allKeys];
    NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedKeys objectAtIndex:[indexPath section]];
    NSArray *fruitsForSection = [self.alphabetizedFruits objectForKey:key];
    NSString *fruit  =[fruitsForSection objectAtIndex:[indexPath row]];
                    
    [cell.textLabel setText:fruit];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = [[self.alphabetizedFruits allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [keys objectAtIndex:section];
    return key;
}

// write a method turn nssarray(fruits) to nsdictionary.
// the purpose of this method return a dictionary.

-(NSDictionary *)alphabetizeFruits: (NSArray*)fruits // parameter is fruits has data type NSArray.
{
    //1. initialise buffer has data types is NSmutabelDictionary.
    
    NSMutableDictionary *buffer = [ NSMutableDictionary new ];
    
    //2.  put fruits in the section, fetch each letter.
    //2.1 creat temporary mutable dictionary.
    // fetch first letter in each elements in  nssarray.
    for (int i = 0 ; i < [self.fruits count]; i ++) {
        
        // fetch element locating postion i.
        NSString * elementLocating = [self.fruits objectAtIndex:i];
        
        // substring the first letter and upperCase this one in each word.
        NSString *firstLetter = [[elementLocating substringToIndex:1] uppercaseString];
        
        // nsdictionary buffer will receive result is that search firtslETTER in dictionary existed with method : objectForKey.
        
        if ([buffer objectForKey:firstLetter]) {
          [[buffer objectForKey:firstLetter] addObject:elementLocating];
            
        }else {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithObjects:elementLocating, nil];
            [buffer setObject:mutableArray forKey:firstLetter];
        }
    }
    // sort for fruit.
    // create a nssarry storing all firstLetter in fruits implemented previous step.
    NSArray * keys = [buffer allKeys];
    for (int j= 0; j< [keys count]; j ++) {
        NSString *key = [keys objectAtIndex:j];
        [[buffer objectForKey:key] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    NSDictionary *result = [NSDictionary dictionaryWithDictionary:buffer];
    return result;
}
@end
