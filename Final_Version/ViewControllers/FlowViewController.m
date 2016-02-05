//
//  FlowViewController.m
//  Final_Version
//
//  Created by MobileApp on 11/10/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "FlowViewController.h"
#define Red 65
#define Blue 215
#define Green 135
#define DegreesToRadians(x) ((x) * M_PI / 180.0)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
@interface FlowViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *toolBarScrollView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property NSMutableArray *shapesArray;
@property NSMutableDictionary *shapesDictionary;
@property int tagCount;
@property int activeShape;
@property NSString *jsonString;
@property iShape *ishape;
@property CGFloat scale;
@property CGFloat scale1;

@end

@implementation FlowViewController
@synthesize projectName;
@synthesize ishape;
@synthesize  credentials;
- (void)viewDidLoad {
    currentShape=0;
    rotate=0;
    self.tagCount=1;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",projectName);
    //[self.scrollView layoutIfNeeded];
    self.scrollView.contentSize=self.contentView.bounds.size;
    //[self.toolBarScrollView layoutIfNeeded];
    self.toolBarScrollView.contentSize=self.toolBar.bounds.size;
    self.shapesDictionary= [NSMutableDictionary new];
    [self load:projectName];
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Draw Shapes
- (IBAction)rectangle:(id)sender {
        [self draw: @"Rectangle"  :220: 180: 80: 80: self.tagCount :0];
}

- (IBAction)rhombus:(id)sender {
        [self draw: @"Rhombus"  :220: 180: 80: 80: self.tagCount :0];
}

- (IBAction)diamond:(id)sender {
        [self draw: @"Diamond"  :220: 180: 80: 80: self.tagCount :0];
}

- (IBAction)terminator:(id)sender {
        [self draw: @"Terminator"  :220: 180: 90: 45: self.tagCount :0];
}

- (IBAction)line:(id)sender {
    [self draw: @"Line" :220: 180: 80: 80: self.tagCount :0];
}

- (IBAction)database:(id)sender {
    if (!currentShape) {
        return;
    }
    ishape = (iShape *)[self.view viewWithTag:currentShape];
    [ishape removeFromSuperview];
    [[[ishape class] description] stringByAppendingString: [NSString stringWithFormat:@"%ld",(long)currentShape ]];
    [self.shapesDictionary removeObjectForKey:[[[ishape class] description] stringByAppendingString: [NSString stringWithFormat:@"%ld",currentShape ]]];
}

- (IBAction)text:(id)sender {
    ishape=[[Label alloc]initWithFrame:CGRectMake (220, 180, 40, 40) :[NSNumber numberWithInt:self.tagCount]: [NSNumber numberWithInt:0] ];
    [self saveDictionary:ishape];
}

-(void)draw:(NSString *) shapeName :(CGFloat) x :(CGFloat) y :(CGFloat) width :(CGFloat) height :(int) tagCount :(CGFloat)angle {
    
    ishape =[[NSClassFromString(shapeName) alloc]initWithFrame:CGRectMake(x, y, width, height) : [NSNumber numberWithInt:tagCount]:[NSNumber numberWithFloat: angle ]];
    [self saveDictionary:ishape];
}

#pragma mark - Scaling

-(void) scaleSize:(iShape *) shape : (CGFloat ) scale {
    shape.layer.anchorPoint= shape.frame.origin;
    [shape setTransform:CGAffineTransformMakeScale(scale, scale)];
    [self updateDictionary:shape :@"scale" :[NSNumber numberWithFloat:scale]];
}

#pragma mark - Rotation
//- (IBAction)rotateClockWise:(id)sender {
//    rotate+=90;
//    ishape = (iShape *)[self.view viewWithTag:currentShape];
//    [ishape setTransform:CGAffineTransformMakeRotation(DegreesToRadians(rotate))];
//    [self changeAngle:ishape :[NSNumber numberWithInteger: rotate] ];
//}

-(void) changeAngle:(iShape *) shape : (NSNumber *) angle{
    [self updateDictionary:shape :@"angle" :angle];
}

-(void) rotateShape:(iShape *) shape : (CGFloat) angle {
    [shape setTransform:CGAffineTransformMakeRotation(DegreesToRadians(angle))];
    
}

#pragma mark - Saving
- (IBAction)save:(id)sender {
    StorageHelper *storageHelper = [StorageHelper new];
    [storageHelper saveToJsonFile:self.projectName :self.shapesDictionary :self.credentials ];
    [storageHelper saveToServer:self.projectName :self.shapesDictionary :self.credentials ];
}


-(void) saveDictionary:(iShape *)shape{
    [self.scrollView addSubview:shape];
    [self.shapesDictionary setObject:[shape getDictionary] forKey: [[[shape class] description] stringByAppendingString:[NSString stringWithFormat:@"%d",self.tagCount ]]];
    shape.tag=self.tagCount;
    self.tagCount++;
    [self addGestureRecognize:shape];

}

#pragma mark - Load
-(void) load:(NSString *) projectFileName{
    
    //getting the path to file
    NSString *path1= [NSTemporaryDirectory() stringByAppendingString:credentials];
    NSString *path=[path1 stringByAppendingPathComponent:projectFileName];
    
    //getting the content of the file
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    //Converting the content to data
    NSData *jsonContent =[content dataUsingEncoding:NSUTF8StringEncoding];
    
    //Converting the data to dictionary
    NSError *error;
    NSMutableDictionary *tempDictionary = [NSJSONSerialization JSONObjectWithData:jsonContent options:kNilOptions error:&error];

    
    NSArray *keys=[NSArray new];
    
    keys=[tempDictionary allKeys];
    //Creating the shapes from the file
    for (int i=0; i<[keys count]; i++) {
        NSDictionary *tempShapeDictionary=[tempDictionary objectForKey:[keys objectAtIndex:i]];
        
        NSString *tempShapeType=[tempShapeDictionary objectForKey:@"type"];
        [self loadShape:tempShapeType :tempShapeDictionary];

    }
}

-(void) loadShape:(NSString *)tempShapeType :(NSDictionary *)tempShapeDictionary {
    CGFloat x=[[tempShapeDictionary objectForKey:@"x"] integerValue];
    CGFloat y=[[tempShapeDictionary objectForKey:@"y"] integerValue];
    CGFloat height=[[tempShapeDictionary objectForKey:@"height"] integerValue];
    CGFloat width=[[tempShapeDictionary objectForKey:@"width"] integerValue];
    CGFloat tempAngle=[[tempShapeDictionary objectForKey:@"angle"] integerValue];
    int tempUniqueId=(int)[[tempShapeDictionary objectForKey:@"uniqueId"] integerValue];
    NSNumber* uniqueId=[NSNumber numberWithInt:tempUniqueId] ;
    NSNumber* angle=[NSNumber numberWithFloat:tempAngle] ;

    
    ishape=[[ NSClassFromString(tempShapeType) alloc]initWithFrame:CGRectMake (x , y, width, height) :uniqueId : angle];
    [ishape setTransform:CGAffineTransformMakeRotation(DegreesToRadians(tempAngle))];
    [self saveDictionary:ishape];
    

}

#pragma mark - Update

-(void) updateDictionary:(iShape *) shape :(NSString *) key :(id) value{
    [[self.shapesDictionary objectForKey:[[shape.class description] stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)shape.tag ]]] setObject:value forKey:key];
    NSLog(@"%@ = %@",key,value);
}


#pragma mark - Gestures

-(void) addGestureRecognize:(UIView *) view{
    UIPanGestureRecognizer * pan = [[ UIPanGestureRecognizer alloc] initWithTarget : self action : @selector (panGesture:)];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    UIPinchGestureRecognizer *pinchGestureRecognizer=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGesture:)];
    UIRotationGestureRecognizer *rotationGestureRecognizer =[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGesture:)];
    
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    [view addGestureRecognizer:pinchGestureRecognizer];
    [view addGestureRecognizer:tapGestureRecognizer];
    [view addGestureRecognizer:pan];
}


- (void) pinchGesture: (UIPinchGestureRecognizer *)recognizer
{
    CGAffineTransform currentTransform= recognizer.view.transform;
    CGAffineTransform scale = CGAffineTransformScale(currentTransform, recognizer.scale, recognizer.scale);
    recognizer.view.transform = scale;
    
    self.scale = self.scale1;
    self.scale1=recognizer.scale;
    
    float fScaleX = recognizer.view.transform.a;
    NSLog(@"scale %f ",fScaleX);
   recognizer.scale=1.0;
    
    [self updateDictionary:ishape :@"x" :[NSNumber numberWithFloat:(recognizer.view.frame.origin.x)]];
   [self updateDictionary:ishape :@"y" :[NSNumber numberWithFloat:(recognizer.view.frame.origin.y)]];
    [self updateDictionary:ishape :@"width" :[NSNumber numberWithFloat:(recognizer.view.frame.size.width)]];
    [self updateDictionary:ishape :@"height" :[NSNumber numberWithFloat:(recognizer.view.frame.size.height)]];
    NSLog(@"scaleX= %lf , scaleY= %lf",recognizer.view.frame.origin.x,recognizer.view.frame.origin.y);
    NSLog(@"width= %lf , height= %lf",recognizer.view.frame.size.width,recognizer.view.frame.size.height);
    
    return;
}

- (void) rotationGesture: (UIRotationGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform
                                                        , recognizer.rotation);
    float fAngle= atan2f(recognizer.view.transform.b, recognizer.view.transform.a);
    fAngle= fAngle *(180/M_PI);
    NSLog(@"%lf",fAngle);
    [self updateDictionary:[self.view viewWithTag:recognizer.view.tag]:@"angle":[NSNumber numberWithFloat:fAngle]];
recognizer.rotation=0.0001;
    return;
}

- (void) tapGesture: (UITapGestureRecognizer *)recognizer
{
    [self.view viewWithTag:currentShape].layer.borderWidth=0.0f ;
    recognizer.view.layer.borderWidth = 1.0f;
    recognizer.view.layer.borderColor= [UIColor blueColor].CGColor;
    currentShape=recognizer.view.tag;
    return;
}

- ( void ) panGesture :( UIPanGestureRecognizer *) gestureRecognizer
{
    CGPoint offset =[gestureRecognizer translationInView:gestureRecognizer.view.superview ];
    CGPoint center=gestureRecognizer.view.center;
    center.x+=offset.x;
    center.y+=offset.y;
    gestureRecognizer.view.center= center;
    [gestureRecognizer setTranslation:CGPointZero inView:gestureRecognizer.view];
    ishape = (iShape *)[self.view viewWithTag:gestureRecognizer.view.tag];
    [self updateDictionary:ishape :@"x" :[NSNumber numberWithFloat:(gestureRecognizer.view.frame.origin.x)]];
    [self updateDictionary:ishape :@"y" :[NSNumber numberWithFloat:(gestureRecognizer.view.frame.origin.y)]];
}


@end
