GoldenFind
==========

This code demonstrates builiding a UITableview from scratch , allowing more flexibility when modfying any of the components 

In this alpha version , only one section is supported and two type of cells , you can make your very special one through modifying MWCollectionViewCell

Simply create a TableView through 



 self.tableView = [[MWTableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];

  Then assign delegates and data sources (Typically as In UITableview)
	self.tableView.collectionViewDelegate = self;
	self.tableView.dataSource = self;
  
    place your cellForRowAtIndexPathCode here :
    
    - (MWTableViewCell *)tableView:(MWTableView *)tableView cellAtPosition:(NSInteger)rowPosition
    
    don't forget to mention the height for each row
    
    - (NSInteger)heightForRowAtPosition:(NSInteger)rowPosition
    
    Dynamic height is supported , you can check the the demo app
    
    If you swipe right you can delete the cell , do the action through this delegate method
    
    - (void)didDeleteCellWithPosition:(NSInteger)rowPosition

   Also upon selecting a cell a navigation to a full screen view will appear , currently it is for vieweing only , soon editing features will be supported and for custom types.
   
   
Very Soon more features will be added such as reordering in addition to Horizontal table view and sectioning.
    
    Feel free to fork and feedback at anytime
