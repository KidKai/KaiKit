//
//  NSObject+KKDevice.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * KKDeviceGeneration NS_TYPED_EXTENSIBLE_ENUM;

FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationAirPods;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationAppleTV_2nd_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationAppleTV_3rd_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationAppleTV_4th_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationAppleTV4K;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationAppleWatch_1st_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationAppleWatchSeries1;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationAppleWatchSeries2;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationAppleWatchSeries3;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationHomePod;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPad;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPad2;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPad_3rd_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPad_4th_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadAir;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadAir2;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadPro_12_9_inch;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadPro_9_7_inch;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPad_5th_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadPro_12_9_inch_2nd_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadPro_10_5_inch;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPad_6th_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadmini;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadmini2;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadmini3;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPadmini4;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone3G;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone3GS;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone4;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone4S;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone5;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone5c;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone5s;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone6;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone6Plus;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone6s;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone6sPlus;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhoneSE;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone7;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone7Plus;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone8;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhone8Plus;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPhoneX;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPodtouch;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPodtouch_2nd_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPodtouch_3rd_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPodtouch_4th_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPodtouch_5th_generation;
FOUNDATION_EXPORT KKDeviceGeneration const KKDeviceGenerationIPodtouch_6th_generation;

typedef NSString * KKDeviceIdentifier NS_TYPED_EXTENSIBLE_ENUM;

FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAirPods;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleTV_2nd_generation;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleTV_3rd_generation;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleTV_3rd_generation_I;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleTV_4th_generation;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleTV4K;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatch_1st_generation_27;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatch_1st_generation_28;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries1_27;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries1_28;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries2_74;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries2_75;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries3_11s;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries3_11b;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries3_21s;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierAppleWatchSeries3_21b;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierHomePod;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad2_93;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad2_94;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad2_95;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad2_93A;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_3rd_generation_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_3rd_generation_2;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_3rd_generation_2A;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_4th_generation_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_4th_generation_2;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_4th_generation_3;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadAir_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadAir_2;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadAir_3;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadAir2_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadAir2_2;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadPro_12_9_inch_8;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadPro_12_9_inch_9;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadPro_9_7_inch_7;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadPro_9_7_inch_8;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_5th_generation_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_5th_generation_2;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadPro_12_9_inch_2nd_generation_0;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadPro_12_9_inch_2nd_generation_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadPro_10_5_inch_7;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadPro_10_5_inch_8;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_6th_generation_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPad_6th_generation_2;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini_5;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini_6;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini_7;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini2_5;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini2_6;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini2_7;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini3_5;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini3_6;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini3_7;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini4_6;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPadmini4_7;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone3G;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone3GS;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone4_0;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone4_0B;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone4_2;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone4S;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone5_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone5_2;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone5c_8;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone5c_9;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone5s_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone5s_3;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone6;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone6Plus;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone6s;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone6sPlus;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhoneSE;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone7;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone7_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone7Plus;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone7Plus_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone8;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone8_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone8Plus;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhone8Plus_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhoneX;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPhoneX_1;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPodtouch;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_2nd_generation;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_3rd_generation;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_4th_generation;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_5th_generation;
FOUNDATION_EXPORT KKDeviceIdentifier const KKDeviceIdentifierIPodtouch_6th_generation;

typedef NSString * KKDeviceInternalName NS_TYPED_EXTENSIBLE_ENUM;

FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAirPods;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleTV_2nd_generation;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleTV_3rd_generation;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleTV_3rd_generation_I;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleTV_4th_generation;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleTV4K;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatch_1st_generation_27;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatch_1st_generation_28;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries1_27;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries1_28;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries2_74;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries2_75;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries3_11s;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries3_11b;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries3_21s;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameAppleWatchSeries3_21b;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameHomePod;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad2_93;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad2_94;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad2_95;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad2_93A;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_3rd_generation_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_3rd_generation_2;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_3rd_generation_2A;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_4th_generation_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_4th_generation_2;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_4th_generation_3;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadAir_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadAir_2;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadAir_3;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadAir2_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadAir2_2;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadPro_12_9_inch_8;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadPro_12_9_inch_9;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadPro_9_7_inch_7;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadPro_9_7_inch_8;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_5th_generation_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_5th_generation_2;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadPro_12_9_inch_2nd_generation_0;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadPro_12_9_inch_2nd_generation_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadPro_10_5_inch_7;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadPro_10_5_inch_8;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_6th_generation_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPad_6th_generation_2;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini_5;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini_6;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini_7;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini2_5;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini2_6;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini2_7;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini3_5;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini3_6;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini3_7;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini4_6;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPadmini4_7;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone3G;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone3GS;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone4_0;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone4_0B;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone4_2;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone4S;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone5_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone5_2;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone5c_8;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone5c_9;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone5s_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone5s_3;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone6;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone6Plus;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone6s;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone6s_m;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone6sPlus;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone6sPlus_m;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhoneSE;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhoneSE_u;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone7;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone7_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone7Plus;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone7Plus_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone8;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone8_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone8Plus;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhone8Plus_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhoneX;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPhoneX_1;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPodtouch;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPodtouch_2nd_generation;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPodtouch_3rd_generation;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPodtouch_4th_generation;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPodtouch_5th_generation;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPodtouch_5th_generation_a;
FOUNDATION_EXPORT KKDeviceInternalName const KKDeviceInternalNameIPodtouch_6th_generation;

@interface NSObject (KKDevice)

@property (nonatomic, readonly, copy) NSString *deviceGeneration;
@property (nonatomic, readonly, copy) NSString *deviceIdentifier;
@property (nonatomic, readonly, copy) NSString *deviceInternalName;

@end

NS_ASSUME_NONNULL_END