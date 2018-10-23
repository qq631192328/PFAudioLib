#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "lame.h"
#import "PFAudio.h"
#import "voiceAmrFileCodec.h"
#import "interf_dec.h"
#import "interf_enc.h"
#import "dec_if.h"
#import "if_rom.h"

FOUNDATION_EXPORT double PFAudioLibVersionNumber;
FOUNDATION_EXPORT const unsigned char PFAudioLibVersionString[];

