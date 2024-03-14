const AUDIO = await Service.import('audio')

/*////////////////////////////////////////////////////////////////////////////
    AUDIO
////////////////////////////////////////////////////////////////////////////// 
    TO BE IMPROVED:
        + Use SVG icons instead of glyphs
        + Avoid using AUDIO.speaker.stream.isMuted
        + value where to use hooks instead of binds
////////////////////////////////////////////////////////////////////////////*/ 

export function volume() { 
    const is_audio_bar_shown = Variable(false);

    return Widget.EventBox({
        on_primary_click: () =>is_audio_bar_shown.value = !is_audio_bar_shown.getValue(),
        on_secondary_click: () => Utils.execAsync('pavucontrol &'),
        
        child: Widget.Box({
            className: "bar-aud-pll",

            children: [ 

                Widget.Revealer({
                    transitionDuration: 600,
                    transition: 'slide_left',
                    revealChild: is_audio_bar_shown.bind(),

                    child: 
                        Widget.Slider({
                            className: 'bar-aud-sld',
                            value: AUDIO['speaker'].bind('volume'),
                            drawValue: false,
                            on_change: ({ value }) => AUDIO['speaker'].volume = value,
                        })
                }),

                Widget.Box({
                    // @ts-ignore
                    class_name: AUDIO['speaker'].bind('is_muted').as(is_muted => AUDIO.speaker.stream.isMuted ? 'bar-aud-mut' : 'bar-aud'),
                    children: [
                        Widget.Icon({
                            class_name: "bar-bat-icn",
                            size: 20,
                            icon: AUDIO['speaker'].bind('volume').as( volume => {
                                volume = Math.round(volume*100);
                                let icon ="/home/inkeaton/.config/ags/icons/vol/volume-";
                                // @ts-ignore
                                if(!AUDIO.speaker.stream.isMuted) switch(Math.floor(volume / 20)) {
                                    case 5:
                                        icon += "100.svg";
                                        break;
                                    case 4:
                                        icon += "100.svg";
                                        break;
                                    case 3:
                                        icon += "75.svg";
                                        break;
                                    case 2:
                                        icon += "50.svg";
                                        break;
                                    case 1:
                                        icon += "25.svg";
                                        break;
                                    case 0:
                                        icon += "0.svg";
                                        break;
                                } else  icon += "mute.svg";
                                
                                return icon;
                            }),
                        }),
                        Widget.Label({
                            label: AUDIO['speaker'].bind('volume').as( volume => `${Math.round(volume*100)}%`),
                        })
                    ]
                }),
                
            ]
        })
    })
};