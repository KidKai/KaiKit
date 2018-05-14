//
//  NSObject+KKDevice.m
//
//  Copyright (c) 2018 KidKai
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#include <sys/sysctl.h>

static NSString *sysinfobyname(char *name)
{
    size_t size;
    sysctlbyname(name, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(name, answer, &size, NULL, 0);
    
    NSString *info = [NSString stringWithUTF8String:answer];
    
    free(answer);
    return info;
}

#import "NSObject+KKDevice.h"

#pragma mark device generation

KKDeviceGeneration const KKDeviceGenerationAirPods = @"AirPods";
KKDeviceGeneration const KKDeviceGenerationAppleTV_2nd_generation = @"Apple TV (2nd generation)";
KKDeviceGeneration const KKDeviceGenerationAppleTV_3rd_generation = @"Apple TV (3rd generation)";
KKDeviceGeneration const KKDeviceGenerationAppleTV_4th_generation = @"Apple TV (4th generation)";
KKDeviceGeneration const KKDeviceGenerationAppleTV4K = @"Apple TV 4K";
KKDeviceGeneration const KKDeviceGenerationAppleWatch_1st_generation = @"Apple Watch (1st generation)";
KKDeviceGeneration const KKDeviceGenerationAppleWatchSeries1 = @"Apple Watch Series 1";
KKDeviceGeneration const KKDeviceGenerationAppleWatchSeries2 = @"Apple Watch Series 2";
KKDeviceGeneration const KKDeviceGenerationAppleWatchSeries3 = @"Apple Watch Series 3";
KKDeviceGeneration const KKDeviceGenerationHomePod = @"HomePod";
KKDeviceGeneration const KKDeviceGenerationIPad = @"iPad";
KKDeviceGeneration const KKDeviceGenerationIPad2 = @"iPad 2";
KKDeviceGeneration const KKDeviceGenerationIPad_3rd_generation = @"iPad (3rd generation)";
KKDeviceGeneration const KKDeviceGenerationIPad_4th_generation = @"iPad (4th generation)";
KKDeviceGeneration const KKDeviceGenerationIPadAir = @"iPad Air";
KKDeviceGeneration const KKDeviceGenerationIPadAir2 = @"iPad Air 2";
KKDeviceGeneration const KKDeviceGenerationIPadPro_12_9_inch = @"iPad Pro (12.9-inch)";
KKDeviceGeneration const KKDeviceGenerationIPadPro_9_7_inch = @"iPad Pro (9.7-inch)";
KKDeviceGeneration const KKDeviceGenerationIPad_5th_generation = @"iPad (5th generation)";
KKDeviceGeneration const KKDeviceGenerationIPadPro_12_9_inch_2nd_generation = @"iPad Pro (12.9-inch, 2nd generation)";
KKDeviceGeneration const KKDeviceGenerationIPadPro_10_5_inch = @"iPad Pro (10.5-inch)";
KKDeviceGeneration const KKDeviceGenerationIPad_6th_generation = @"iPad (6th generation)";
KKDeviceGeneration const KKDeviceGenerationIPadmini = @"iPad mini";
KKDeviceGeneration const KKDeviceGenerationIPadmini2 = @"iPad mini 2";
KKDeviceGeneration const KKDeviceGenerationIPadmini3 = @"iPad mini 3";
KKDeviceGeneration const KKDeviceGenerationIPadmini4 = @"iPad mini 4";
KKDeviceGeneration const KKDeviceGenerationIPhone = @"iPhone";
KKDeviceGeneration const KKDeviceGenerationIPhone3G = @"iPhone 3G";
KKDeviceGeneration const KKDeviceGenerationIPhone3GS = @"iPhone 3GS";
KKDeviceGeneration const KKDeviceGenerationIPhone4 = @"iPhone 4";
KKDeviceGeneration const KKDeviceGenerationIPhone4S = @"iPhone 4S";
KKDeviceGeneration const KKDeviceGenerationIPhone5 = @"iPhone 5";
KKDeviceGeneration const KKDeviceGenerationIPhone5c = @"iPhone 5c";
KKDeviceGeneration const KKDeviceGenerationIPhone5s = @"iPhone 5s";
KKDeviceGeneration const KKDeviceGenerationIPhone6 = @"iPhone 6";
KKDeviceGeneration const KKDeviceGenerationIPhone6Plus = @"iPhone 6 Plus";
KKDeviceGeneration const KKDeviceGenerationIPhone6s = @"iPhone 6s";
KKDeviceGeneration const KKDeviceGenerationIPhone6sPlus = @"iPhone 6s Plus";
KKDeviceGeneration const KKDeviceGenerationIPhoneSE = @"iPhone SE";
KKDeviceGeneration const KKDeviceGenerationIPhone7 = @"iPhone 7";
KKDeviceGeneration const KKDeviceGenerationIPhone7Plus = @"iPhone 7 Plus";
KKDeviceGeneration const KKDeviceGenerationIPhone8 = @"iPhone 8";
KKDeviceGeneration const KKDeviceGenerationIPhone8Plus = @"iPhone 8 Plus";
KKDeviceGeneration const KKDeviceGenerationIPhoneX = @"iPhone X";
KKDeviceGeneration const KKDeviceGenerationIPodtouch = @"iPod touch";
KKDeviceGeneration const KKDeviceGenerationIPodtouch_2nd_generation = @"iPod touch (2nd generation)";
KKDeviceGeneration const KKDeviceGenerationIPodtouch_3rd_generation = @"iPod touch (3rd generation)";
KKDeviceGeneration const KKDeviceGenerationIPodtouch_4th_generation = @"iPod touch (4th generation)";
KKDeviceGeneration const KKDeviceGenerationIPodtouch_5th_generation = @"iPod touch (5th generation)";
KKDeviceGeneration const KKDeviceGenerationIPodtouch_6th_generation = @"iPod touch (6th generation)";

KKDeviceGeneration const KKDeviceGenerationMac = @"Mac";

KKDeviceGeneration const KKDeviceGenerationSimulator = @"Simulator";

KKDeviceGeneration const KKDeviceGenerationUnknown = @"Unknown";

#pragma mark device identifier

KKDeviceIdentifier const KKDeviceIdentifierAirPods = @"AirPods1,1";
KKDeviceIdentifier const KKDeviceIdentifierAppleTV_2nd_generation = @"AppleTV2,1";
KKDeviceIdentifier const KKDeviceIdentifierAppleTV_3rd_generation = @"AppleTV3,1";
KKDeviceIdentifier const KKDeviceIdentifierAppleTV_3rd_generation_I = @"AppleTV3,2";
KKDeviceIdentifier const KKDeviceIdentifierAppleTV_4th_generation = @"AppleTV5,3";
KKDeviceIdentifier const KKDeviceIdentifierAppleTV4K = @"AppleTV6,2";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatch_1st_generation_27 = @"Watch1,1";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatch_1st_generation_28 = @"Watch1,2";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries1_27 = @"Watch2,6";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries1_28 = @"Watch2,7";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries2_74 = @"Watch2,3";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries2_75 = @"Watch2,4";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries3_11s = @"Watch3,1";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries3_11b = @"Watch3,2";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries3_21s = @"Watch3,3";
KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries3_21b = @"Watch3,4";
KKDeviceIdentifier const KKDeviceIdentifierHomePod = @"AudioAccessory1,1";
KKDeviceIdentifier const KKDeviceIdentifierIPad = @"iPad1,1";
KKDeviceIdentifier const KKDeviceIdentifierIPad2_93 = @"iPad2,1";
KKDeviceIdentifier const KKDeviceIdentifierIPad2_94 = @"iPad2,2";
KKDeviceIdentifier const KKDeviceIdentifierIPad2_95 = @"iPad2,3";
KKDeviceIdentifier const KKDeviceIdentifierIPad2_93A = @"iPad2,4";
KKDeviceIdentifier const KKDeviceIdentifierIPad_3rd_generation_1 = @"iPad3,1";
KKDeviceIdentifier const KKDeviceIdentifierIPad_3rd_generation_2 = @"iPad3,2";
KKDeviceIdentifier const KKDeviceIdentifierIPad_3rd_generation_2A = @"iPad3,3";
KKDeviceIdentifier const KKDeviceIdentifierIPad_4th_generation_1 = @"iPad3,4";
KKDeviceIdentifier const KKDeviceIdentifierIPad_4th_generation_2 = @"iPad3,5";
KKDeviceIdentifier const KKDeviceIdentifierIPad_4th_generation_3 = @"iPad3,6";
KKDeviceIdentifier const KKDeviceIdentifierIPadAir_1 = @"iPad4,1";
KKDeviceIdentifier const KKDeviceIdentifierIPadAir_2 = @"iPad4,2";
KKDeviceIdentifier const KKDeviceIdentifierIPadAir_3 = @"iPad4,3";
KKDeviceIdentifier const KKDeviceIdentifierIPadAir2_1 = @"iPad5,3";
KKDeviceIdentifier const KKDeviceIdentifierIPadAir2_2 = @"iPad5,4";
KKDeviceIdentifier const KKDeviceIdentifierIPadPro_12_9_inch_8 = @"iPad6,7";
KKDeviceIdentifier const KKDeviceIdentifierIPadPro_12_9_inch_9 = @"iPad6,8";
KKDeviceIdentifier const KKDeviceIdentifierIPadPro_9_7_inch_7 = @"iPad6,3";
KKDeviceIdentifier const KKDeviceIdentifierIPadPro_9_7_inch_8 = @"iPad6,4";
KKDeviceIdentifier const KKDeviceIdentifierIPad_5th_generation_1 = @"iPad6,11";
KKDeviceIdentifier const KKDeviceIdentifierIPad_5th_generation_2 = @"iPad6,12";
KKDeviceIdentifier const KKDeviceIdentifierIPadPro_12_9_inch_2nd_generation_0 = @"iPad7,1";
KKDeviceIdentifier const KKDeviceIdentifierIPadPro_12_9_inch_2nd_generation_1 = @"iPad7,2";
KKDeviceIdentifier const KKDeviceIdentifierIPadPro_10_5_inch_7 = @"iPad7,3";
KKDeviceIdentifier const KKDeviceIdentifierIPadPro_10_5_inch_8 = @"iPad7,4";
KKDeviceIdentifier const KKDeviceIdentifierIPad_6th_generation_1 = @"iPad7,5";
KKDeviceIdentifier const KKDeviceIdentifierIPad_6th_generation_2 = @"iPad7,6";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini_5 = @"iPad2,5";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini_6 = @"iPad2,6";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini_7 = @"iPad2,7";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini2_5 = @"iPad4,4";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini2_6 = @"iPad4,5";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini2_7 = @"iPad4,6";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini3_5 = @"iPad4,7";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini3_6 = @"iPad4,8";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini3_7 = @"iPad4,9";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini4_6 = @"iPad5,1";
KKDeviceIdentifier const KKDeviceIdentifierIPadmini4_7 = @"iPad5,2";
KKDeviceIdentifier const KKDeviceIdentifierIPhone = @"iPhone1,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone3G = @"iPhone1,2";
KKDeviceIdentifier const KKDeviceIdentifierIPhone3GS = @"iPhone2,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone4_0 = @"iPhone3,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone4_0B = @"iPhone3,2";
KKDeviceIdentifier const KKDeviceIdentifierIPhone4_2 = @"iPhone3,3";
KKDeviceIdentifier const KKDeviceIdentifierIPhone4S = @"iPhone4,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone5_1 = @"iPhone5,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone5_2 = @"iPhone5,2";
KKDeviceIdentifier const KKDeviceIdentifierIPhone5c_8 = @"iPhone5,3";
KKDeviceIdentifier const KKDeviceIdentifierIPhone5c_9 = @"iPhone5,4";
KKDeviceIdentifier const KKDeviceIdentifierIPhone5s_1 = @"iPhone6,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone5s_3 = @"iPhone6,2";
KKDeviceIdentifier const KKDeviceIdentifierIPhone6 = @"iPhone7,2";
KKDeviceIdentifier const KKDeviceIdentifierIPhone6Plus = @"iPhone7,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone6s = @"iPhone8,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone6sPlus = @"iPhone8,2";
KKDeviceIdentifier const KKDeviceIdentifierIPhoneSE = @"iPhone8,4";
KKDeviceIdentifier const KKDeviceIdentifierIPhone7 = @"iPhone9,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone7_1 = @"iPhone9,3";
KKDeviceIdentifier const KKDeviceIdentifierIPhone7Plus = @"iPhone9,2";
KKDeviceIdentifier const KKDeviceIdentifierIPhone7Plus_1 = @"iPhone9,4";
KKDeviceIdentifier const KKDeviceIdentifierIPhone8 = @"iPhone10,1";
KKDeviceIdentifier const KKDeviceIdentifierIPhone8_1 = @"iPhone10,4";
KKDeviceIdentifier const KKDeviceIdentifierIPhone8Plus = @"iPhone10,2";
KKDeviceIdentifier const KKDeviceIdentifierIPhone8Plus_1 = @"iPhone10,5";
KKDeviceIdentifier const KKDeviceIdentifierIPhoneX = @"iPhone10,3";
KKDeviceIdentifier const KKDeviceIdentifierIPhoneX_1 = @"iPhone10,6";
KKDeviceIdentifier const KKDeviceIdentifierIPodtouch = @"iPod1,1";
KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_2nd_generation = @"iPod2,1";
KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_3rd_generation = @"iPod3,1";
KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_4th_generation = @"iPod4,1";
KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_5th_generation = @"iPod5,1";
KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_6th_generation = @"iPod7,1";

#pragma mark device internal name

KKDeviceInternalName const KKDeviceInternalNameAirPods = @"B188AP";
KKDeviceInternalName const KKDeviceInternalNameAppleTV_2nd_generation = @"K66AP";
KKDeviceInternalName const KKDeviceInternalNameAppleTV_3rd_generation = @"J33AP";
KKDeviceInternalName const KKDeviceInternalNameAppleTV_3rd_generation_I = @"J33IAP";
KKDeviceInternalName const KKDeviceInternalNameAppleTV_4th_generation = @"J42dAP";
KKDeviceInternalName const KKDeviceInternalNameAppleTV4K = @"J105aAP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatch_1st_generation_27 = @"N27aAP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatch_1st_generation_28 = @"N28aAP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries1_27 = @"N27dAP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries1_28 = @"N28dAP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries2_74 = @"N74AP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries2_75 = @"N75AP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries3_11s = @"N111sAP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries3_11b = @"N111bAP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries3_21s = @"N121sAP";
KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries3_21b = @"N121bAP";
KKDeviceInternalName const KKDeviceInternalNameHomePod = @"B238aAP";
KKDeviceInternalName const KKDeviceInternalNameIPad = @"K48AP";
KKDeviceInternalName const KKDeviceInternalNameIPad2_93 = @"K93AP";
KKDeviceInternalName const KKDeviceInternalNameIPad2_94 = @"K94AP";
KKDeviceInternalName const KKDeviceInternalNameIPad2_95 = @"K95AP";
KKDeviceInternalName const KKDeviceInternalNameIPad2_93A = @"K93AAP";
KKDeviceInternalName const KKDeviceInternalNameIPad_3rd_generation_1 = @"J1AP";
KKDeviceInternalName const KKDeviceInternalNameIPad_3rd_generation_2 = @"J2AP";
KKDeviceInternalName const KKDeviceInternalNameIPad_3rd_generation_2A = @"J2AAP";
KKDeviceInternalName const KKDeviceInternalNameIPad_4th_generation_1 = @"P101AP";
KKDeviceInternalName const KKDeviceInternalNameIPad_4th_generation_2 = @"P102AP";
KKDeviceInternalName const KKDeviceInternalNameIPad_4th_generation_3 = @"P103AP";
KKDeviceInternalName const KKDeviceInternalNameIPadAir_1 = @"J71AP";
KKDeviceInternalName const KKDeviceInternalNameIPadAir_2 = @"J72AP";
KKDeviceInternalName const KKDeviceInternalNameIPadAir_3 = @"J73AP";
KKDeviceInternalName const KKDeviceInternalNameIPadAir2_1 = @"J81AP";
KKDeviceInternalName const KKDeviceInternalNameIPadAir2_2 = @"J82AP";
KKDeviceInternalName const KKDeviceInternalNameIPadPro_12_9_inch_8 = @"J98aAP";
KKDeviceInternalName const KKDeviceInternalNameIPadPro_12_9_inch_9 = @"J99aAP";
KKDeviceInternalName const KKDeviceInternalNameIPadPro_9_7_inch_7 = @"J127AP";
KKDeviceInternalName const KKDeviceInternalNameIPadPro_9_7_inch_8 = @"J128AP";
KKDeviceInternalName const KKDeviceInternalNameIPad_5th_generation_1 = @"J71sAP";
KKDeviceInternalName const KKDeviceInternalNameIPad_5th_generation_2 = @"J72sAP";
KKDeviceInternalName const KKDeviceInternalNameIPadPro_12_9_inch_2nd_generation_0 = @"J120AP";
KKDeviceInternalName const KKDeviceInternalNameIPadPro_12_9_inch_2nd_generation_1 = @"J121AP";
KKDeviceInternalName const KKDeviceInternalNameIPadPro_10_5_inch_7 = @"J207AP";
KKDeviceInternalName const KKDeviceInternalNameIPadPro_10_5_inch_8 = @"J208AP";
KKDeviceInternalName const KKDeviceInternalNameIPad_6th_generation_1 = @"J71bAP";
KKDeviceInternalName const KKDeviceInternalNameIPad_6th_generation_2 = @"J72bAP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini_5 = @"P105AP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini_6 = @"P106AP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini_7 = @"P107AP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini2_5 = @"J85AP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini2_6 = @"J86AP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini2_7 = @"J87AP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini3_5 = @"J85mAP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini3_6 = @"J86mAP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini3_7 = @"J87mAP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini4_6 = @"J96AP";
KKDeviceInternalName const KKDeviceInternalNameIPadmini4_7 = @"J97AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone = @"M68AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone3G = @"N82AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone3GS = @"N88AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone4_0 = @"N90AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone4_0B = @"N90BAP";
KKDeviceInternalName const KKDeviceInternalNameIPhone4_2 = @"N92AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone4S = @"N94AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone5_1 = @"N41AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone5_2 = @"N42AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone5c_8 = @"N48AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone5c_9 = @"N49AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone5s_1 = @"N51AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone5s_3 = @"N53AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone6 = @"N61AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone6Plus = @"N56AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone6s = @"N71AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone6s_m = @"N71mAP";
KKDeviceInternalName const KKDeviceInternalNameIPhone6sPlus = @"N66AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone6sPlus_m = @"N66mAP";
KKDeviceInternalName const KKDeviceInternalNameIPhoneSE = @"N69AP";
KKDeviceInternalName const KKDeviceInternalNameIPhoneSE_u = @"N69uAP";
KKDeviceInternalName const KKDeviceInternalNameIPhone7 = @"D10AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone7_1 = @"D101AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone7Plus = @"D11AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone7Plus_1 = @"D111AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone8 = @"D20AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone8_1 = @"D201AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone8Plus = @"D21AP";
KKDeviceInternalName const KKDeviceInternalNameIPhone8Plus_1 = @"D211AP";
KKDeviceInternalName const KKDeviceInternalNameIPhoneX = @"D22AP";
KKDeviceInternalName const KKDeviceInternalNameIPhoneX_1 = @"D221AP";
KKDeviceInternalName const KKDeviceInternalNameIPodtouch = @"N45AP";
KKDeviceInternalName const KKDeviceInternalNameIPodtouch_2nd_generation = @"N72AP";
KKDeviceInternalName const KKDeviceInternalNameIPodtouch_3rd_generation = @"N18AP";
KKDeviceInternalName const KKDeviceInternalNameIPodtouch_4th_generation = @"N81AP";
KKDeviceInternalName const KKDeviceInternalNameIPodtouch_5th_generation = @"N78AP";
KKDeviceInternalName const KKDeviceInternalNameIPodtouch_5th_generation_a = @"N78aAP";
KKDeviceInternalName const KKDeviceInternalNameIPodtouch_6th_generation = @"N102AP";

@implementation NSObject (KKDevice)

#if TARGET_OS_IOS
- (KKIPadDisplaySize)iPadDisplaySize
{
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPadmini] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPadmini2] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPadmini3] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPadmini4]) {
        return KKIPadDisplaySize_7_9_inch;
    }
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPad] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPad2] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPad_3rd_generation] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPad_4th_generation] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPadAir] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPadAir2] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPadPro_9_7_inch] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPad_5th_generation] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPad_6th_generation]) {
        return KKIPadDisplaySize_9_7_inch;
    }
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPadPro_10_5_inch]) {
        return KKIPadDisplaySize_10_5_inch;
    }
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPadPro_12_9_inch] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPadPro_12_9_inch_2nd_generation]) {
        return KKIPadDisplaySize_12_9_inch;
    }
    return KKIPadDisplaySize_x_x_inch;
}
- (KKIPhoneDisplaySize)iPhoneDisplaySize
{
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone3G] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone3GS] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone4] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone4S]) {
        return KKIPhoneDisplaySize_3_5_inch;
    }
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone5] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone5c] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone5s] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhoneSE]) {
        return KKIPhoneDisplaySize_4_0_inch;
    }
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone6] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone6s] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone7] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone8]) {
        return KKIPhoneDisplaySize_4_7_inch;
    }
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone6Plus] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone6sPlus] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone7Plus] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPhone8Plus]) {
        return KKIPhoneDisplaySize_5_5_inch;
    }
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPhoneX]) {
        return KKIPhoneDisplaySize_5_8_inch;
    }
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationSimulator]) {
        CGSize size = UIScreen.mainScreen.bounds.size;
        CGFloat min = MIN(size.width, size.height);
        CGFloat max = MAX(size.width, size.height);
        if (min == 320.f && max == 480.f) {
            return KKIPhoneDisplaySize_3_5_inch;
        }
        if (min == 320.f && max == 568.f) {
            return KKIPhoneDisplaySize_4_0_inch;
        }
        if (min == 375.f && max == 667.f) {
            return KKIPhoneDisplaySize_4_7_inch;
        }
        if (min == 414.f && max == 736.f) {
            return KKIPhoneDisplaySize_5_5_inch;
        }
        if (min == 375.f && max == 812.f) {
            return KKIPhoneDisplaySize_5_8_inch;
        }
    }
    return KKIPhoneDisplaySize_x_x_inch;
}
- (KKIPodtouchDisplaySize)iPodtouchDisplaySize
{
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPodtouch] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPodtouch_2nd_generation] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPodtouch_3rd_generation] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPodtouch_4th_generation]) {
        return KKIPodtouchDisplaySize_3_5_inch;
    }
    if ([self.deviceGeneration isEqualToString:KKDeviceGenerationIPodtouch_5th_generation] ||
        [self.deviceGeneration isEqualToString:KKDeviceGenerationIPodtouch_6th_generation]) {
        return KKIPodtouchDisplaySize_4_0_inch;
    }
    return KKIPodtouchDisplaySize_x_x_inch;
}
#elif TARGET_OS_WATCH
- (KKAppleWatchCaseSize)appleWatchCaseSize
{
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatch_1st_generation_27] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries1_27] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries2_74] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries3_11s] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries3_21s] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatch_1st_generation_27] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries1_27] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries2_74] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries3_11s] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries3_21s]) {
        return KKAppleWatchCaseSize_38mm;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatch_1st_generation_28] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries1_28] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries2_75] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries3_11b] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries3_21b] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatch_1st_generation_28] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries1_28] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries2_75] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries3_11b] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries3_21b]) {
        return KKAppleWatchCaseSize_42mm;
    }
    return KKAppleWatchCaseSize_xxmm;
}
#endif

- (KKDeviceGeneration)deviceGeneration
{
#if TARGET_OS_OSX
    if ([self.deviceInternalName containsString:@"Mac"]) {
        return KKDeviceGenerationMac;
    }
#elif TARGET_OS_SIMULATOR
    return KKDeviceGenerationSimulator;
#elif TARGET_OS_IPHONE
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAirPods] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAirPods]) {
        return KKDeviceGenerationAirPods;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleTV_2nd_generation] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleTV_2nd_generation]) {
        return KKDeviceGenerationAppleTV_2nd_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleTV_3rd_generation] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleTV_3rd_generation_I] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleTV_3rd_generation] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleTV_3rd_generation_I]) {
        return KKDeviceGenerationAppleTV_3rd_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleTV_4th_generation] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleTV_4th_generation]) {
        return KKDeviceGenerationAppleTV_4th_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleTV4K] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleTV4K]) {
        return KKDeviceGenerationAppleTV4K;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatch_1st_generation_27] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatch_1st_generation_28] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatch_1st_generation_27] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatch_1st_generation_28]) {
        return KKDeviceGenerationAppleWatch_1st_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries1_27] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries1_28] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries1_27] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries1_28]) {
        return KKDeviceGenerationAppleWatchSeries1;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries2_74] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries2_75] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries2_74] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries2_75]) {
        return KKDeviceGenerationAppleWatchSeries2;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries3_11s] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries3_11b] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries3_21s] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierAppleWatchSeries3_21b] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries3_11s] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries3_11b] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries3_21s] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameAppleWatchSeries3_21b]) {
        return KKDeviceGenerationAppleWatchSeries3;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierHomePod] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameHomePod]) {
        return KKDeviceGenerationHomePod;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad]) {
        return KKDeviceGenerationIPad;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad2_93] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad2_94] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad2_95] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad2_93A] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad2_93] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad2_94] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad2_95] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad2_93A]) {
        return KKDeviceGenerationIPad2;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_3rd_generation_1] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_3rd_generation_2] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_3rd_generation_2A] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_3rd_generation_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_3rd_generation_2] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_3rd_generation_2A]) {
        return KKDeviceGenerationIPad_3rd_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_4th_generation_1] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_4th_generation_2] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_4th_generation_3] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_4th_generation_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_4th_generation_2] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_4th_generation_3]) {
        return KKDeviceGenerationIPad_4th_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadAir_1] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadAir_2] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadAir_3] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadAir_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadAir_2] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadAir_3]) {
        return KKDeviceGenerationIPadAir;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadAir2_1] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadAir2_2] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadAir2_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadAir2_2]) {
        return KKDeviceGenerationIPadAir2;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadPro_12_9_inch_8] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadPro_12_9_inch_9] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadPro_12_9_inch_8] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadPro_12_9_inch_9]) {
        return KKDeviceGenerationIPadPro_12_9_inch;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadPro_9_7_inch_7] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadPro_9_7_inch_8] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadPro_9_7_inch_7] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadPro_9_7_inch_8]) {
        return KKDeviceGenerationIPadPro_9_7_inch;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_5th_generation_1] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_5th_generation_2] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_5th_generation_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_5th_generation_2]) {
        return KKDeviceGenerationIPad_5th_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadPro_12_9_inch_2nd_generation_0] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadPro_12_9_inch_2nd_generation_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadPro_12_9_inch_2nd_generation_0] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadPro_12_9_inch_2nd_generation_1]) {
        return KKDeviceGenerationIPadPro_12_9_inch_2nd_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadPro_10_5_inch_7] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadPro_10_5_inch_8] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadPro_10_5_inch_7] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadPro_10_5_inch_8]) {
        return KKDeviceGenerationIPadPro_10_5_inch;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_6th_generation_1] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPad_6th_generation_2] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_6th_generation_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPad_6th_generation_2]) {
        return KKDeviceGenerationIPad_6th_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini_5] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini_6] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini_7] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini_5] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini_6] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini_7]) {
        return KKDeviceGenerationIPadmini;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini2_5] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini2_6] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini2_7] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini2_5] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini2_6] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini2_7]) {
        return KKDeviceGenerationIPadmini2;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini3_5] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini3_6] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini3_7] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini3_5] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini3_6] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini3_7]) {
        return KKDeviceGenerationIPadmini3;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini4_6] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPadmini4_7] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini4_6] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPadmini4_7]) {
        return KKDeviceGenerationIPadmini4;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone]) {
        return KKDeviceGenerationIPhone;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone3G] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone3G]) {
        return KKDeviceGenerationIPhone3G;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone3GS] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone3GS]) {
        return KKDeviceGenerationIPhone3GS;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone4_0] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone4_0B] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone4_2] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone4_0] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone4_0B] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone4_2]) {
        return KKDeviceGenerationIPhone4;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone4S] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone4S]) {
        return KKDeviceGenerationIPhone4S;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone5_1] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone5_2] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone5_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone5_2]) {
        return KKDeviceGenerationIPhone5;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone5c_8] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone5c_9] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone5c_8] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone5c_9]) {
        return KKDeviceGenerationIPhone5c;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone5s_1] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone5s_3] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone5s_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone5s_3]) {
        return KKDeviceGenerationIPhone5s;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone6] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone6]) {
        return KKDeviceGenerationIPhone6;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone6Plus] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone6Plus]) {
        return KKDeviceGenerationIPhone6Plus;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone6s] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone6s] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone6s_m]) {
        return KKDeviceGenerationIPhone6s;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone6sPlus] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone6sPlus] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone6sPlus_m]) {
        return KKDeviceGenerationIPhone6sPlus;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhoneSE] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhoneSE] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhoneSE_u]) {
        return KKDeviceGenerationIPhoneSE;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone7] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone7_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone7] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone7_1]) {
        return KKDeviceGenerationIPhone7;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone7Plus] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone7Plus_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone7Plus] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone7Plus_1]) {
        return KKDeviceGenerationIPhone7Plus;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone8] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone8_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone8] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone8_1]) {
        return KKDeviceGenerationIPhone8;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone8Plus] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhone8Plus_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone8Plus] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhone8Plus_1]) {
        return KKDeviceGenerationIPhone8Plus;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhoneX] ||
        [self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPhoneX_1] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhoneX] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPhoneX_1]) {
        return KKDeviceGenerationIPhoneX;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPodtouch] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPodtouch]) {
        return KKDeviceGenerationIPodtouch;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPodtouch_2nd_generation] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPodtouch_2nd_generation]) {
        return KKDeviceGenerationIPodtouch_2nd_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPodtouch_3rd_generation] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPodtouch_3rd_generation]) {
        return KKDeviceGenerationIPodtouch_3rd_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPodtouch_4th_generation] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPodtouch_4th_generation]) {
        return KKDeviceGenerationIPodtouch_4th_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPodtouch_5th_generation] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPodtouch_5th_generation] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPodtouch_5th_generation_a]) {
        return KKDeviceGenerationIPodtouch_5th_generation;
    }
    if ([self.deviceIdentifier isEqualToString:KKDeviceIdentifierIPodtouch_6th_generation] ||
        [self.deviceInternalName isEqualToString:KKDeviceInternalNameIPodtouch_6th_generation]) {
        return KKDeviceGenerationIPodtouch_6th_generation;
    }
#endif
    return KKDeviceGenerationUnknown;
}

- (KKDeviceIdentifier)deviceIdentifier
{
    return sysinfobyname("hw.machine");
}

- (KKDeviceInternalName)deviceInternalName
{
    return sysinfobyname("hw.model");
}

@end
