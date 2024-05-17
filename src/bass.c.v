module bass

#flag -I @VMODROOT/src/header
#include "bass.h"
#include "bass_fx.h"
#include "bassmix.h"
#flag -Wl,-rpath=.,-L@VMODROOT/dlls -lbass -lbass_fx -lbassmix

type C.HSAMPLE = u32
type C.HSTREAM = u32
type C.QWORD = u64

// Important bits
fn C.BASS_Init(int, int, int, int, int) int
fn C.BASS_SetConfig(int, int)
fn C.BASS_GetDevice() int
fn C.BASS_ChannelSetDevice(C.HSTREAM, int) bool
fn C.BASS_ChannelSeconds2Bytes(C.HSTREAM, f64) u64
fn C.BASS_ChannelFree(C.HSTREAM)

// Track
fn C.BASS_StreamCreateFile(int, &char, int, int, int) C.HSTREAM
fn C.BASS_ChannelPlay(C.HSTREAM, int)
fn C.BASS_ChannelSetAttribute(C.HSTREAM, int, f32)
fn C.BASS_ChannelSetPosition(C.HSTREAM, C.QWORD, int)

// Utils
fn C.BASS_SampleGetChannel(C.HSAMPLE, int) C.HSTREAM
fn C.BASS_SampleLoad(int, &char, int, int, int, int) C.HSTREAM
fn C.BASS_ChannelSeconds2Bytes(C.HSTREAM, f64) C.QWORD
fn C.BASS_ChannelBytes2Seconds(C.HSTREAM, f64) C.QWORD

// FFT
fn C.BASS_ChannelGetData(C.HSTREAM, &voidptr, int)

// FX
fn C.BASS_FX_TempoCreate(C.HSTREAM, int) C.HSTREAM

// MIX
fn C.BASS_Mixer_StreamCreate(int, int, int) C.HSTREAM
fn C.BASS_Mixer_StreamAddChannel(C.HSTREAM, C.HSTREAM, int) bool
fn C.BASS_Mixer_ChannelGetData(C.HSTREAM, &voidptr, int)
fn C.BASS_Mixer_ChannelSetPosition(C.HSTREAM, C.QWORD)
fn C.BASS_Mixer_ChannelGetPosition(C.HSTREAM, int) f64
fn C.BASS_Mixer_ChannelFlags(C.HSTREAM, int, int)
fn C.BASS_Mixer_ChannelRemove(C.HSTREAM)
