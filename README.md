# libbass-v
small api library for the awesome [un4seen's BASS](https://www.un4seen.com/) audio library.

# disclaimer
this does not cover the whole spec of the api, it only covers what i need for my [osu! reimplementation](https://github.com/xjunko/kurarin) made in v.

# install
`v install https://github.com/xjunko/v-bass`

# setup
im running this on arch linux but anything linux or unix _should_ work.

- first, get your copy of bass, bass_fx and bassmix dlls (.so files) from [un4seen's website](https://www.un4seen.com/).
- paste it in root project and inside the module's dlls folder 
- run code
- profit?

# examples
```v
import time
import xjunko.bass as bass

fn main() {
    bass.start()

    // track has much more control over the audio
    mut track := bass.new_track("audio.mp3")

    track.set_volume(0.5)
    track.play()
    track.pause()
    track.resume()
    track.set_speed(1.5)
    track.set_pitch(2)
    track.set_position(10000) // in milliseconds

    for {
        if track.get_position() >= 15000 {
            track.pause()
            break
        }
    }

    // while sample is more of a "one-shot" system, but it still shares the same api as track
    mut sample := bass.new_sample("circle-hit.mp3")
    sample.play() // this can be stacked to play over and over again
    time.sleep(500 * time.millisecond)
    sample.play()
}
```
