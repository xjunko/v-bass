module bass

const global = &GlobalMixer{}

pub struct GlobalMixer {
pub mut:
	master C.HSTREAM
}

@[params]
pub struct BufferConfig {
pub:
	playback          int = 100
	device            int = 10
	update_period     int = 5
	dev_update_period int = 10
}

@[params]
pub struct AudioConfig {
pub:
	channels  int = 2
	bitrate   int = 48000
	flags     int = C.BASS_MIXER_NONSTOP
	device_id int = -1 // -1 is system's default
}

@[params]
pub struct BassConfiguration {
	buffers BufferConfig
	audio   AudioConfig
}

pub fn start(config BassConfiguration) {
	C.BASS_SetConfig(C.BASS_CONFIG_DEV_NONSTOP, 1)
	C.BASS_SetConfig(C.BASS_CONFIG_VISTA_TRUEPOS, 0)
	C.BASS_SetConfig(C.BASS_CONFIG_BUFFER, config.buffers.playback)
	C.BASS_SetConfig(C.BASS_CONFIG_UPDATEPERIOD, config.buffers.update_period)
	C.BASS_SetConfig(C.BASS_CONFIG_DEV_BUFFER, config.buffers.device)
	C.BASS_SetConfig(C.BASS_CONFIG_DEV_PERIOD, config.buffers.dev_update_period)
	C.BASS_SetConfig(68, 1)

	if C.BASS_Init(config.audio.device_id, config.audio.bitrate, 0, 0, 0) != 0 {
		println('[Bass] Started!')

		// Mixer
		master_mixer := C.BASS_Mixer_StreamCreate(config.audio.bitrate, config.audio.channels,
			config.audio.flags)
		C.BASS_ChannelSetAttribute(master_mixer, C.BASS_ATTRIB_BUFFER, 0)
		C.BASS_ChannelSetDevice(master_mixer, C.BASS_GetDevice())

		C.BASS_ChannelPlay(master_mixer, 0)

		// Point global to that mixer
		// Remnants of Project Kurarin, fix this.
		// https://github.com/xjunko/kurarin
		unsafe {
			mut g_mixer := global
			g_mixer.master = master_mixer
		}
	} else {
		println('[Bass] Failed to start BASS!')
	}
}
