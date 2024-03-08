const AUDIO = await Service.import('audio')

/*////////////////////////////////////////////////////////////////////////////
    AUDIO
////////////////////////////////////////////////////////////////////////////// 
    TO BE IMPROVED:
        + Use SVG icons instead of glyphs
        + Avoid using AUDIO.speaker.stream.isMuted
        + value where to use hooks instead of binds
////////////////////////////////////////////////////////////////////////////*/ 

const is_audio_bar_shown = Variable(Boolean(false));

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
                    child: 
                        Widget.Label({
                            label: AUDIO['speaker'].bind('volume').as( volume => {
                                volume = Math.round(volume*100);
                                let icon = '';
                                // @ts-ignore
                                if(!AUDIO.speaker.stream.isMuted) switch(Math.floor(volume / 33)) {
                                    case 3:
                                        icon = ' ';
                                        break;
                                    case 2:
                                        icon = ' ';
                                        break;
                                    case 1:
                                        icon = ' ';
                                        break;
                                    case 0:
                                        icon = '  ';
                                        break;
                                };
                                return `${icon}  ${volume}%`;
                            }),
                        })
                }),
                
            ]
        })
    })
};