    //
    //  SaleViewController.m
    //  vinacredit
    //
    //  Created by Vinacredit on 8/17/12.
    //  Copyright (c) 2012 Vinacredit. All rights reserved.
    //

#import "SaleViewController.h"
#import "Macros.h"
#import "IdentifyViewController.h"
#import "SumBill.h"
#import "Bill.h"
#import "ConnectDatabase.h"
#import "Account.h"
#import "DoneViewController.h"

#include <unistd.h>
#include <time.h>

#include "SReaderDriver.h"
#include "SReaderUtility.h"

#define kOutputBus 0
#define kInputBus 1
OSStatus status=0;
static int callback_lock = 0;
AudioComponentInstance audioUnit;
SaleViewController* THIS = NULL;
@interface SaleViewController ()
@property (nonatomic) BOOL isNumber;

@end

@implementation SaleViewController

@synthesize imgSreader;
@synthesize labelSum;
@synthesize takeIdentifed;
@synthesize firstView;
@synthesize secondView;
@synthesize isNumber;
@synthesize rowDataArray;
@synthesize lib;
bool flagLableSum = TRUE;
bool flagAddCell = FALSE;
NSString *tmpLableSum;
NSString *tmpLableItem;
NSString *pathOfFile;
NSString *dummyString;
NSString *tmpStrValue = @"0";
NSFileManager *filemanager;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)configureBar {
    //create a right button
    UIImage *imgright = [UIImage imageNamed:@"charge.png"];
    UIButton *btnright = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnright setBackgroundImage:imgright forState:UIControlStateNormal];
    btnright.frame= CGRectMake(0.0, 0.0, 30.0, 26.0);
    [btnright addTarget:self action:@selector(gotoCharge:)    forControlEvents:UIControlEventTouchUpInside];
    UIView *viewright = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 26.0)];
    [viewright addSubview:btnright];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewright];
	self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    //create an add left button
    UIImage *imgleft = [UIImage imageNamed:@"account.png"];
    UIButton *btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnleft setBackgroundImage:imgleft forState:UIControlStateNormal];
    btnleft.frame= CGRectMake(0.0, 0.0, 26.0, 26.0);
    UIView *viewleft = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 26.0, 26.0)];
    [btnleft addTarget:self action:@selector(gotoAccount:)    forControlEvents:UIControlEventTouchUpInside];
    [viewleft addSubview:btnleft];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewleft];    
	self.navigationItem.leftBarButtonItem = leftButtonItem;
	self.navigationController.delegate = self;
}

void checkStatus(OSStatus status)
{
        //NSLog(@"HELLO: Status=%ld", status);
	return;
}

- (void)viewDidLoad
{
    lib = [[Library alloc]init];
    valueEmail = EMAIL_LOGIN_VALUE;
    [self sreaderViewDidLoad];
    Account *acc = [[Account alloc] init];
    acc = [[ConnectDatabase database] selectAcc:valueEmail];
    if(acc.imageAcc != NULL)
        imageItem.image = acc.imageAcc;
    self.title = [NSString stringWithFormat:@"%@ %@",acc.lastName,acc.firstName];
    ima = [UIImage imageNamed:@"logo.png"];
    value = @"0";
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.rowDataArray = [[NSMutableArray alloc] init];
    
    [self configureBar];
    self.title = SALE_LBL;
}
#pragma mark textfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    text = textField.text;
    if(DEBUG_SCR)
        NSLog(@"test: %@",text);
    return YES;
}
- (void)viewDidUnload
{
    
    imageItem = nil;
    firstView = nil;
    secondView = nil;
    [self setFirstView:nil];
    [self setSecondView:nil];
    [self setTakeIdentifed:nil];
    takeIdentifed = nil;
    [self setLabelSum:nil];
    imgSreader = nil;
    [self setImgSreader:nil];
    [super viewDidUnload];
}

    //Custom cell

    //
    // numberOfSectionsInTableView:
    //
    // Return the number of sections for the table.
    //
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

    //
    // tableView:numberOfRowsInSection:
    //
    // Returns the number of rows in a given section.
    //
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
	return ([rowDataArray count] + 1);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier ;
    if(BUILD_IPHONE_OR_IPAD)
    {
    if(indexPath.row == [rowDataArray count]){
        CellIdentifier = @"AddCell";
        AddCell *ad = (AddCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(ad == nil){
            ad = (AddCell*)[[[NSBundle mainBundle] loadNibNamed:@"AddCell" owner:self options:nil] lastObject];
            ad.delegate = self;
        }
        ad.adx = indexPath.row;
        if(DEBUG_SCR){
            NSLog(@"row indexpath %d",indexPath.row);
            NSLog(@"row data array %d",[rowDataArray count]);
        }
        
        ad.textItem.text = text;
        ad.labelItem.text = [lib addDotNumber:value];
        ad.imageItem.image = ima;

        return ad;
    }
    else{
        CellIdentifier = @"ItemCell";
        ItemCell *cus = (ItemCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cus == nil){
            cus = (ItemCell*)[[[NSBundle mainBundle] loadNibNamed:@"ItemCell" owner:self options:nil] lastObject];
            cus.delegate = self;
        }
        CellData *celldata = (CellData*)[rowDataArray objectAtIndex:indexPath.row];
        cus.idx = indexPath.row;
        if(celldata.textItem !=nil)
            cus.itemField.text = celldata.textItem;
        cus.itemLabel.text = celldata.labelItem;
        cus.itemImage.image = celldata.imageItem;
        cus.itemNum.text = celldata.numItem;
        if(flagAddCell){
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[rowDataArray count]inSection:0]atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            flagAddCell = FALSE;
        }
        return cus;
    }
    } else {
        if(indexPath.row == [rowDataArray count]){
            CellIdentifier = @"AddCellIpad";
            AddCell *ad = (AddCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(ad == nil){
                ad = (AddCell*)[[[NSBundle mainBundle] loadNibNamed:@"AddCellIpad" owner:self options:nil] lastObject];
                ad.delegate = self;
            }
            ad.adx = indexPath.row;
            if(DEBUG_SCR)
                NSLog(@"%d",ad.adx);
            ad.textItem.text = text;
            ad.labelItem.text = [lib addDotNumber:value];
            ad.imageItem.image = ima;
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            return ad;
        }
        else{
            CellIdentifier = @"ItemCellIpad";
            ItemCell *cus = (ItemCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cus == nil){
                cus = (ItemCell*)[[[NSBundle mainBundle] loadNibNamed:@"ItemCellIpad" owner:self options:nil] lastObject];
                cus.delegate = self;
            }
            CellData *celldata = [[CellData alloc] init];
            celldata = (CellData*)[rowDataArray objectAtIndex:indexPath.row];
            cus.idx = indexPath.row;
            if(celldata.textItem !=nil)
                cus.itemField.text = celldata.textItem;
            cus.itemLabel.text = celldata.labelItem;
            cus.itemImage.image = celldata.imageItem;
            cus.itemNum.text = celldata.numItem;
            if(flagAddCell){
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[rowDataArray count]inSection:0]atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                flagAddCell = FALSE;
            }
            return cus;
        }
    }
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    if(self.isNumber) {
        if(![@"0" isEqualToString:tmpStrValue]) {
            tmpStrValue = [tmpStrValue stringByAppendingString:[sender currentTitle]];
            
        } else {
            if([[sender currentTitle] isEqualToString:@"000"])
                return;
            tmpStrValue = [sender currentTitle];
        }
    } else {
        if([[sender currentTitle] isEqualToString:@"000"])
            return;
        self.isNumber = YES;
        tmpStrValue = [sender currentTitle];
    }
    if(DEBUG_SCR)
        NSLog(@" %u",tmpStrValue.length);
    if(tmpStrValue.length > 8)
        tmpStrValue = @"99999000";
    value = tmpStrValue;
    [self.tableView reloadData];
    
}

- (IBAction)operationPressed:(id)sender {
    if (self.isNumber) {
        if (tmpStrValue.length > 1) {
            tmpStrValue = [tmpStrValue substringToIndex:tmpStrValue.length -1];
        } else if (tmpStrValue.length == 1) {
            tmpStrValue = @"0";
        }
    }
    value = tmpStrValue;
    [self.tableView reloadData];
}
-(void)clearSale{
    [rowDataArray removeAllObjects];
    labelSum.text = @"0";
    ima = [UIImage imageNamed:@"logo.png"];
    value = @"0";
    tmpStrValue = @"0";
    tmpLableSum = @"0";
    text = nil;
}
#pragma Clear Bill
-(IBAction)clear {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [secondView setAlpha:0.0];
    [firstView setAlpha:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:secondView cache:YES];
    [UIView commitAnimations];
    [self clearSale];
    [self.tableView reloadData];
}
- (IBAction)image {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:SALE_TAKEPHOTO_LBL
                                                             delegate:self
                                                    cancelButtonTitle:SALE_CANCEL_LBL
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:SALE_TAKEPHOTO_LBL,SALE_CHOOSEPHOTO_LBL,SALE_DELETEPHOTO_LBL, nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 2) {
        ima = [UIImage imageNamed:@"logo.png"];
        [self.tableView reloadData];
    }
    else
        {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        
        if(buttonIndex == 0)
            {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:imagePicker animated:YES];
            }
        if(buttonIndex ==1)
            {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO)
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentModalViewController:imagePicker animated:YES];
            }
        
        }
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    CellData *celldata = [[CellData alloc] init];
    ima = [info objectForKey:UIImagePickerControllerEditedImage];
    celldata.imageItem = ima;
    [picker dismissModalViewControllerAnimated:YES];
    if(DEBUG_SCR)
        NSLog(@"test image picker");
    [self.tableView reloadData];
    
}

#pragma mark Add Cell Delegate
-(void)addCellDidAdd:(AddCell *)addCell{
        // test valueItem % 100
    flagAddCell = TRUE;
    if([value intValue] % 100 !=0)return;
    CellData *celldata = [[CellData alloc] init];
    [rowDataArray addObject:celldata];
    celldata.textItem = text ;
    text = nil;
        //=====enter price item======
    celldata.labelItem = [lib addDotNumber:value];
    tmpLableItem = value;
    value = @"0";
    tmpStrValue = @"0";
        //=====sum price item========
    
    if (flagLableSum){
        tmpLableSum = labelSum.text;
        flagLableSum = FALSE;
    }
    if(DEBUG_SCR){
        NSLog(@"test add : %@",celldata.textItem);
        NSLog(@"test add cell");
    }
    tmpLableSum = [NSString stringWithFormat:@"%d",[tmpLableSum intValue] + [tmpLableItem intValue]];
    labelSum.text = tmpLableSum;
    labelSum.text = [lib addDotNumber:labelSum.text];
    SALE_SUM_VALUE = labelSum.text;
        //=====add image item========
    celldata.imageItem = ima;
    ima = [UIImage imageNamed:@"logo.png"];

    [self.tableView reloadData];
}
#pragma mark Minus Cell Delegate
-(void)customized1CellDidMinus:(ItemCell *)customized1Cell{
    if(DEBUG_SCR)
        NSLog(@"test minus item");
    CellData *celldata = [[CellData alloc] init];
    celldata = (CellData*)[rowDataArray objectAtIndex:customized1Cell.idx];
    celldata.labelItem = [lib deleteDotNumber:customized1Cell.itemLabel.text];
    int a = [celldata.numItem intValue];
    a--;
    if(a < 1){
        [rowDataArray removeObject:celldata];
    }
    else
        {
        celldata.numItem = [NSString stringWithFormat:@"%ix",a];
        }
    if (flagLableSum){
        tmpLableSum = labelSum.text;
        flagLableSum = FALSE;
    }
    tmpLableSum = [NSString stringWithFormat:@"%d",[tmpLableSum intValue] - [celldata.labelItem intValue]];
    labelSum.text = [lib addDotNumber:tmpLableSum];
    SALE_SUM_VALUE = labelSum.text;
    celldata.labelItem = [lib addDotNumber:celldata.labelItem];
    [self.tableView reloadData];
}
#pragma mark Plus Cell Delegate
-(void)customized1CellDidPlus:(ItemCell *)customized1Cell{
    
    if(DEBUG_SCR)
        NSLog(@"test plus item");
    CellData *celldata = [[CellData alloc] init];
    celldata = (CellData*)[rowDataArray objectAtIndex:customized1Cell.idx];
    celldata.labelItem = [lib deleteDotNumber:customized1Cell.itemLabel.text];
    int a = [celldata.numItem intValue];
    a++;
    celldata.numItem = [NSString stringWithFormat:@"%ix",a];
    
    if (flagLableSum){
        tmpLableSum = labelSum.text;
        flagLableSum = FALSE;
    }
    tmpLableSum = [NSString stringWithFormat:@"%d",[tmpLableSum intValue] + [celldata.labelItem intValue]];
    labelSum.text = [lib addDotNumber:tmpLableSum];
    SALE_SUM_VALUE = labelSum.text;
    celldata.labelItem = [lib addDotNumber:celldata.labelItem];
    [self.tableView reloadData];
}

- (IBAction)gotoAccount:(id)sender{
    [lib gotoInterFace:ACCOUNT pushView:TRUE navigationController:self.navigationController];
//    labelSum.text = @"0";
//    [self resetValueVariable];
}

- (IBAction)gotoCharge:(id)sender{
    if(TEST_EMPTY_SALE){
        bool bTestEmpty = FALSE;
        bTestEmpty = [labelSum.text isEqualToString:@"0"];
        if(bTestEmpty)
            return;
    }    
//    if(BUILD_DEVICE)
//        [self getTimeAndPrice];    
    [lib gotoInterFace:CHARGE pushView:TRUE navigationController:self.navigationController];
//    labelSum.text = @"0";
//    [self resetValueVariable];
}
/*
- (void)getTimeAndPrice{
    DoneViewController *done = [[DoneViewController alloc] init];
    ParseDate *d = [[ParseDate alloc] init];
        //NSLog(@"Date:%@",[d getCurrentDate]);
        //NSLog(@"Time:%@",[d getCurrentTime]);
    done.timeSale =[d getCurrentTime];
    done.sumItem =[lib deleteDotNumber:labelSum.text];
    done.sumBill = [NSString stringWithFormat:@"%d",[done.sumBill intValue] + [[lib deleteDotNumber:labelSum.text] intValue]];
    done.dateSale =[d getCurrentDate];
    done.emailSumBill = valueEmail;
    
}
*/
- (IBAction)gotoIdentify:(id)sender{
    if(TEST_EMPTY_SALE){
        bool bTestEmpty = FALSE;
        bTestEmpty = [labelSum.text isEqualToString:@"0"];
        if(bTestEmpty)
            return;
    }
//    tmpLableSum = @"0";
//    if(BUILD_DEVICE)
//        [self getTimeAndPrice];    
    [lib gotoInterFace:IDENTIFY pushView:TRUE navigationController:self.navigationController];
}

-(void)resetValueVariable{
    tmpLableSum = nil;
    tmpLableItem = nil;
    pathOfFile = nil;
    dummyString = nil;
}


/******************************/
#pragma receiver device audio
    // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)sreaderViewDidLoad {
        // Describe audio component
	AudioComponentDescription desc;
	desc.componentType = kAudioUnitType_Output;
	desc.componentSubType = kAudioUnitSubType_RemoteIO;
	desc.componentFlags = 0;
	desc.componentFlagsMask = 0;
	desc.componentManufacturer = kAudioUnitManufacturer_Apple;
	
        // Get component
	AudioComponent inputComponent = AudioComponentFindNext(NULL, &desc);
	
        // Get audio units
	status = AudioComponentInstanceNew(inputComponent, &audioUnit);
	checkStatus(status);
	
        // Enable IO for recording
	UInt32 flag = 1;
	status = AudioUnitSetProperty(audioUnit,
								  kAudioOutputUnitProperty_EnableIO,
								  kAudioUnitScope_Input,
								  kInputBus,
								  &flag,
								  sizeof(flag));
	checkStatus(status);
    
    
        // Enable IO for playback
	flag = 1;
	status = AudioUnitSetProperty(audioUnit,
								  kAudioOutputUnitProperty_EnableIO,
								  kAudioUnitScope_Output,
								  kOutputBus,
								  &flag,
								  sizeof(flag));
	checkStatus(status);
	
    
	AURenderCallbackStruct callbackStruct;
    
        // Set output callback
	callbackStruct.inputProc = playbackCallback;
	callbackStruct.inputProcRefCon = (__bridge void *)(self);
	
	NSLog(@"Set Render callback");
	status = AudioUnitSetProperty(audioUnit,
								  kAudioUnitProperty_SetRenderCallback,
								  kAudioUnitScope_Global, //kAudioUnitScope_Input,//kAudioUnitScope_Global,
								  kOutputBus,
								  &callbackStruct,
								  sizeof(callbackStruct));
	checkStatus(status);
	
	
        // Describe format
	AudioStreamBasicDescription audioFormat;
	audioFormat.mSampleRate			= 44100.00;
	audioFormat.mFormatID			= kAudioFormatLinearPCM;
	audioFormat.mFormatFlags		= kAudioFormatFlagsCanonical | kAudioFormatFlagIsNonInterleaved;
        //kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked
	audioFormat.mFramesPerPacket	= 1;
	audioFormat.mChannelsPerFrame	= 2;
	audioFormat.mBitsPerChannel		= 16;
	audioFormat.mBytesPerPacket		= 2;
	audioFormat.mBytesPerFrame		= 2;
	
        // Apply format
	status = AudioUnitSetProperty(audioUnit,
								  kAudioUnitProperty_StreamFormat,
								  kAudioUnitScope_Input,
								  kOutputBus,
								  &audioFormat,
								  sizeof(audioFormat));
	checkStatus(status);
    
	status = AudioUnitSetProperty(audioUnit,
								  kAudioUnitProperty_StreamFormat,
								  kAudioUnitScope_Output,
								  kInputBus,
								  &audioFormat,
								  sizeof(audioFormat));
	checkStatus(status);
	
	SInt32 hwSampleRate;
	UInt32 size = sizeof(hwSampleRate);
	status = AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &size, &hwSampleRate);
	checkStatus(status);
	NSLog(@"Hardware Sample Rate = %ld", hwSampleRate);
    
	size = sizeof(audioFormat);
	status = AudioUnitGetProperty(audioUnit,
								  kAudioUnitProperty_StreamFormat,
								  kAudioUnitScope_Input,
								  kOutputBus,
								  &audioFormat,
								  &size);
	checkStatus(status);
	NSLog(@"AudioUnit Sample Rate = %lf", audioFormat.mSampleRate);
	
        // set numbers per Frame
	UInt32 numFrames = 4096;
	status = AudioUnitSetProperty(audioUnit,
								  kAudioUnitProperty_MaximumFramesPerSlice,
								  kAudioUnitScope_Global,
								  kOutputBus,
								  &numFrames,
								  sizeof(numFrames));
	checkStatus(status);
	status = AudioUnitSetProperty(audioUnit,
								  kAudioUnitProperty_MaximumFramesPerSlice,
								  kAudioUnitScope_Global,
								  kInputBus,
								  &numFrames,
								  sizeof(numFrames));
	checkStatus(status);
	
        // set what ??????
	Float32 preferredBufferSize = 0.1;
	status = AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareIOBufferDuration, sizeof(preferredBufferSize), &preferredBufferSize);
	checkStatus(status);
	
	UInt32 maxFPS;
	size = sizeof(maxFPS);
	status = AudioUnitGetProperty(audioUnit, kAudioUnitProperty_MaximumFramesPerSlice, kAudioUnitScope_Global, kOutputBus, &maxFPS, &size);
	checkStatus(status);
	NSLog(@"max Maximum Frames PerSlice = %ld", maxFPS);
	
        // Disable buffer allocation for the recorder (optional - do this if we want to pass in our own)
	/*
     flag = 0;
     status = AudioUnitSetProperty(audioUnit,
     kAudioUnitProperty_ShouldAllocateBuffer,
     kAudioUnitScope_Output,
     kInputBus,
     &flag,
     sizeof(flag));
     */
    
	
        // Initialise
	NSLog(@"AudioUnitInitialize");
	status = AudioUnitInitialize(audioUnit);
	checkStatus(status);
    
	/* to Start untile press DETECT button
     // to Start
     NSLog(@"AudioOutputUnitStart");
     status = AudioOutputUnitStart(audioUnit);
     checkStatus(status);
	 */
    
	AudioSessionInitialize(NULL, NULL, rioInterruptionListener, (__bridge void *)(self));
	UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
	AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
	AudioSessionAddPropertyListener (kAudioSessionProperty_AudioRouteChange,
                                     audioRouteChangeListenerCallback,
                                     (__bridge void *)(self));
	AudioSessionSetActive(true);
        //[[AVAudioSession sharedInstance] setActive: YES error:NULL];
    
	return;
}

void audioRouteChangeListenerCallback (
									   void                      *inUserData,
									   AudioSessionPropertyID    inPropertyID,
									   UInt32                    inPropertyValueSize,
									   const void                *inPropertyValue)
{
	if (inPropertyID != kAudioSessionProperty_AudioRouteChange)
		return;
	
	SaleViewController *_self = (__bridge SaleViewController *) inUserData;
	
	CFDictionaryRef    routeChangeDictionary = inPropertyValue;
	CFNumberRef routeChangeReasonRef = CFDictionaryGetValue (routeChangeDictionary,
															 CFSTR (kAudioSession_AudioRouteChangeKey_Reason));
	
	@autoreleasepool {
		NSString *str = NULL;
		
		SInt32 routeChangeReason;
		CFNumberGetValue (routeChangeReasonRef, kCFNumberSInt32Type, &routeChangeReason);
		NSLog(@" ======================= RouteChangeReason : %ld", routeChangeReason);
		
		if (routeChangeReason == kAudioSessionRouteChangeReason_OldDeviceUnavailable) {
                //[_self resetSettings];
                NSLog(@"=======================\nkAudioRouteChangeReason:\n OldDeviceUnavailable!\n");
		} else if (routeChangeReason == kAudioSessionRouteChangeReason_NewDeviceAvailable) {
                //[_self resetSettings];
                NSLog(@"=======================\nkAudioRouteChangeReason:\n NewDeviceAvailable!\n");
		} else if (routeChangeReason == kAudioSessionRouteChangeReason_NoSuitableRouteForCategory) {
                //[_self resetSettings];
                NSLog(@"=======================\nkAudioRouteChangeReason:\n lostMicroPhone");
		}
            //else if (routeChangeReason == kAudioSessionRouteChangeReason_CategoryChange  ) {
            //}
		else {
                NSLog(@"=======================\nUnknown Reason:");
		}
        
		if ([_self hasHeadset]){
                //if ([_self hasHeadset] && [_self SReader_Detect]) {
                //has Headset
            _self.imgSreader.image = [UIImage imageNamed:@"card unlock.jpeg"];
			NSLog(@"Has Headset\n");
		} else {
            _self.imgSreader.image = [UIImage imageNamed:@"card lock.jpeg"];
                //not has Headset
			NSLog(@"No Headset\n");
		}
        
		_self->m_strLog = [[NSString alloc] initWithFormat:@"%@\n%@", _self->m_strLog, str];
        
            //	[[_self m_textview] setText:_self->m_strLog];
            //NSLog(@"%@", _self->m_strLog);
            //[[_self m_sndDemoShow] setText:str];
		
		_self->m_strLog = NULL;
        
	}
	
}
#pragma mark Check Headset
- (BOOL)hasHeadset {
#if TARGET_IPHONE_SIMULATOR
        //#warning *** Simulator mode: audio session code works only on a device
    return NO;
#else
    CFStringRef route;
    UInt32 propertySize = sizeof(CFStringRef);
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &propertySize, (void *)&route);
	
    if((route == NULL) || (CFStringGetLength(route) == 0)){
            // Silent Mode
        m_strLog = [[NSString alloc] initWithFormat:@"%@\n%@\n", m_strLog, @"AudioRoute: SILENT, do nothing!"];
    } else {
        NSString* routeStr = (__bridge NSString*)route;
        m_strLog = [[NSString alloc] initWithFormat:@"%@\nAudioRoute:\n%@\n", m_strLog, routeStr];
		
        /* Known values of route:
         * "Headset"
         * "Headphone"
         * "Speaker"
         * "SpeakerAndMicrophone"
         * "HeadphonesAndMicrophone"
         * "HeadsetInOut"
         * "ReceiverAndMicrophone"
         * "Lineout"
         */
		
		NSRange headsetRange = [routeStr rangeOfString : @"Headset"];
		if(headsetRange.location != NSNotFound) {
            return YES;
        }
    }
    return NO;
#endif
}
static OSStatus playbackCallback(void *inRefCon,
								 AudioUnitRenderActionFlags *ioActionFlags,
								 const AudioTimeStamp *inTimeStamp,
								 UInt32 inBusNumber,
								 UInt32 inNumberFrames,
								 AudioBufferList *ioData)
{
        // Notes: ioData contains buffers (may be more than one!)
        // Fill them up as much as you can. Remember to set the size value in each buffer to match how
        // much data is in the buffer.
    
	if (callback_lock == 1) {
		NSLog(@"===> playback is overflow!!!");
		return noErr;
	} else {
		callback_lock = 1;
	}
	
	THIS = (__bridge SaleViewController *)inRefCon;
    
        //NSLog(@"playback inBusNumber:%ld, inNumberFrames:%ld, ioData:0x%08x",inBusNumber, inNumberFrames, ioData);
	if (ioData == NULL) {
		NSLog(@"playback AudioBuffer is NULL");
		return noErr;
	}
	
        //NSLog(@"AudioBuffer mData[0] Byte Size%ld", ioData->mBuffers[0].mDataByteSize);
        //NSLog(@"AudioBuffer mData[1] Byte Size%ld", ioData->mBuffers[1].mDataByteSize);
    
    
	OSStatus status = AudioUnitRender(audioUnit,
									  ioActionFlags,
									  inTimeStamp,
									  kInputBus,//1,
									  inNumberFrames,
									  ioData);
	checkStatus(status);
        //NSLog(@" ---------------%d",count++);
	short *readBuffer = (short *)ioData->mBuffers[0].mData;
	UART_Decode(inNumberFrames, readBuffer);
    //NSLog(@" -------end--------");
    //NSLog(@"\n");
        //int range = MIN(abs(readBuffer[0])/100, 1023);
        //NSLog(@"sound demo  value ========= %d =========", range);
	
	/*******************/
	/* for testing...  */
	/* log mic data    *
     //DEBUG_MIC = 0;
     if (DEBUG_MIC) {
     char *str = snd_str;
     NSLog(@"MIC CallBack Log:\n");
     for (int i=0; i<inNumberFrames; i++) {
     sprintf(str, "%d,", readBuffer[i]);
     str += strlen(str);
     if ((i+1)%8 == 0) {
     str = snd_str;
     NSLog(@"%s\n", str);
     }
     }
     DEBUG_MIC = 0;
     }
     */
	
        //writeBufferl = (short *)ioData->mBuffers[0].mData;
        //writeBufferr = (short *)ioData->mBuffers[1].mData;
    
	short *writeBufferl = (short *)ioData->mBuffers[0].mData;
	short *writeBufferr = (short *)ioData->mBuffers[1].mData;
	
	UART_Encode(inNumberFrames, writeBufferl, writeBufferr);
    
	/*******************/
	/* for testing...  *
     snd_str[0] = '@';
     range++;
     for (int i=1; i<range; i++) {
     snd_str[i] = '=';
     }
     snd_str[range] = 0;
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
     snd_demo = [[NSString alloc] initWithFormat:@"%s", snd_str];
     [pool release];
     [THIS->m_sndDemoShow performSelectorOnMainThread:@selector(setText:) withObject:snd_demo waitUntilDone:NO];
     */
    
	callback_lock = 0;
	
    return noErr;
}
void rioInterruptionListener(void *inClientData, UInt32 inInterruption)
{
	NSLog(@"Session interrupted! --- %s ---", inInterruption == kAudioSessionBeginInterruption ? "Begin Interruption" : "End Interruption");
	
        //SReaderV1_0ViewController *_self = (SReaderV1_0ViewController *) inClientData;
	
	if (inInterruption == kAudioSessionEndInterruption) {
            // make sure we are again the active session
		AudioSessionSetActive(true);
		AudioOutputUnitStart(audioUnit);
	}
	
	if (inInterruption == kAudioSessionBeginInterruption) {
		AudioOutputUnitStop(audioUnit);
    }
}

#pragma receiver device reader card

void SReader_Start(void)
{
	// to Start audiounit
	NSLog(@"AudioOutputUnitStart");
    
	initialize_buffer();
	
	status = AudioOutputUnitStart(audioUnit);
	checkStatus(status);
}

void SReader_Stop(void)
{
	// to Stop audiounit
	NSLog(@"AudioOutputUnitStop");
	
	status = AudioOutputUnitStop(audioUnit);
	checkStatus(status);
    
	usleep(20000);
	
	initialize_buffer();
}

void CloseSinWave(void)
{
	SReader_Stop();
}
#pragma mark Reader Detect
- (BOOL)SReader_Detect {
	NSString* str = NULL;
	
	NSLog(@"Start to detect...");
	
	SReader_Start();
	
	NSLog(@"Hold 5 seconds!");
	sleep(5);
	
    NSLog(@"to get Version...");
	unsigned char *Version = SReader_GetVersion();
	if (Version == NULL) {
		NSLog(@"time out ...");
		NSLog(@"to close sin wave");
		CloseSinWave();
		return NO;
	} else {
		str = [[NSString alloc] initWithFormat:@"Version = %s", Version];
		NSLog(@"%@", str);
	}
	
	usleep(1000000);
	NSLog(@"to get KSN...");
	unsigned char *KSN = SReader_GetKSN();
	if (KSN == NULL) {
		NSLog(@"time out ...");
		NSLog(@"to close sin wave");
		CloseSinWave();
		return NO;
	} else {
		str = [[NSString alloc] initWithFormat:@"KSN = %s", get_CurrentKSN()];
		NSLog(@"%@", str);
	}
	
	usleep(1000000);
	NSLog(@"to get Random...");
	unsigned char *Random = SReader_GetRandom();
	if (Random == NULL) {
		NSLog(@"time out ...");
		NSLog(@"to close sin wave");
		CloseSinWave();
		return NO;
	} else {
		str = [[NSString alloc] initWithFormat:@"Random = %s", get_CurrentRandom()];
		NSLog(@"%@", str);
	}
	
	NSLog(@"to generate WorkingKey...");
	unsigned char *WorkingKey = SReader_GenerateWorkingKey();
	if (WorkingKey == NULL) {
		NSLog(@"Failed to generate WorkingKey");
		return NO;
	} else {
		str = [[NSString alloc] initWithFormat:@"Counter = %s", get_CurrentCounter()];
		NSLog(@"%@", str);
		//[self Prompt:str];
        
		str = [[NSString alloc] initWithFormat:@"WorkingKey = %s", get_CurrentWorkingKey()];
		NSLog(@"%@", str);
		//[self Prompt:str];
	}
    
	return YES;
}


@end
