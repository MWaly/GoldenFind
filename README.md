GoldenFind
==========

This code demonstrates builiding a UITableview from scratch , allowing more flexibility when modfying any of the components 

In this alpha version , only one section is supported and two type of cells , you can make your very special one through modifying MWCollectionViewCell

Simply create a UITableView through 


   MWCollectionView *collectionView=[[MWCollectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
  
  Then assign delegates and data sources (Typically as In UITableview)
    collectionView.collectionViewDelegate=self;
    collectionView.dataSource=self;
    
    place your cellForRowAtIndexPathCode here :
    
    - (MWCollectionViewCell *)tableView:(MWCollectionView *)tableView cellAtPosition:(NSInteger)rowPosition
    
    don't forget to mention the height for each row
    
    - (NSInteger)heightForRowAtPosition:(NSInteger)rowPosition
    
    Dynamic height is supported , you can check the the demo app
    

Very Soon more features will be added such as Full Screen Cell Navigation , deleting and reordering in addition to Horizontal table view and sectioning.
    
    Feel free to fork and feedback at anytime
