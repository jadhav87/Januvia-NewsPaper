//
//  ViewController.m
//  Januvia NewsPaper
//
//  Created by vikas on 14/09/17.
//  Copyright © 2017 vikas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIImage *testImg = [UIImage imageNamed:@"web-user.jpg"];
//    self.mergeImg.image = [self drawText:@"Vikas Jadhav" inImage:[self mergeImages:testImg forImgMode:1] atPoint:CGPointMake(562 + (812/2), 640 + 10)];
}

-(void)CapturePicture{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    self.mergeImg.image = [self mergeImages:chosenImage forImgMode:1];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (UIImage *) mergeImages:(UIImage *)image forImgMode:(NSUInteger)mode {
    
    UIImage *bottomImage = nil;
    
    bottomImage = [UIImage imageNamed:@"Januvia_Newspaper.jpg"];
//    bottomImage = [UIImage imageNamed:@"newspaper.jpg"];
    
    CGSize newSize = CGSizeMake(bottomImage.size.width, bottomImage.size.height);
    UIGraphicsBeginImageContext(newSize);
    
    // Use existing opacity as is
    [bottomImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    NSLog(@"Actual width : %f",image.size.width);
    NSLog(@"Actual height : %f",image.size.height);
//    UIImage *sFinalImg = [self imageWithImage:image scaledToMaxWidth:700 maxHeight:1305];
    UIImage *sFinalImg = [self imageWithImage:image scaledToSize:CGSizeMake(1045, 1045)];
//    UIImage *fBorderImage = [self borderedImageFromImage:sFinalImg andColor:[UIColor greenColor]];
    
//    [image drawInRect:CGRectMake(915,1035,1000,1305) blendMode:kCGBlendModeNormal alpha:1.0];
    [sFinalImg drawInRect:CGRectMake(170,875,sFinalImg.size.width,sFinalImg.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
//    [fBorderImage drawInRect:CGRectMake(562,640,fBorderImage.size.width,fBorderImage.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    
    
    
//    NSLog(@"width : %f",newSize.width);
//    NSLog(@"height : %f",newSize.height);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    //----------------------- Saving img ------------------------------//
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    return newImage;
}

- (void)savedPhotoImage:(UIImage *)image
didFinishSavingWithError:(NSError *)error
            contextInfo:(void *)contextInfo
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"image saved");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)TakePicture:(id)sender {
    
//    UIImage *mergeImg = [UIImage imageNamed:@"logo.png"];
//    self.mergeImg.image = [self mergeImages:mergeImg forImgMode:1];
    
    [self CapturePicture];
}

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)borderedImageFromImage:(UIImage *)source andColor:(UIColor *)borderColor{
    
    CGFloat scale = 3;//this determines how big the border will be, the smaller it is the bigger the border
    UIImage *borderImage = [source imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(source.size, NO, source.scale);
    [borderColor set];
    [borderImage drawInRect:CGRectMake(0, 0, source.size.width, source.size.height)];
    
    [source drawInRect:CGRectMake(source.size.width*(1-scale)/2,
                                  source.size.height*(1-scale)/2,
                                  source.size.width * scale,
                                  source.size.height * scale)];
    
    borderImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return borderImage;
}

-(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:40];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor redColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
