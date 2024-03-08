const BATTERY = await Service.import('battery')

/*////////////////////////////////////////////////////////////////////////////
    BATTERY
////////////////////////////////////////////////////////////////////////////// 
    TO BE IMPROVED:
        + Use SVG icons instead of glyphs
////////////////////////////////////////////////////////////////////////////*/ 

export function battery() { 
    const is_time_shown  = Variable(false);

    const time_remaining = BATTERY.bind('time_remaining').as(time => `${Math.floor(time/3600)} h ${Math.floor((time % 3600)/60)} m`);

    const class_state    = Utils.merge([BATTERY.bind('charging'), BATTERY.bind('percent')], (ischarging, percent) => {
        return `${ischarging ? 'bar-bat-chg' : ((percent < 16) ? 'bar-bat-low' : 'bar-bat')}`;
    })

    return Widget.EventBox({
        visible: BATTERY.bind('available'),
        on_primary_click: () => is_time_shown.value = !is_time_shown.getValue(),

        child: Widget.Box({
            class_name: "bar-bat-pll",
            visible: BATTERY.bind('available'),

            children: [ 

                Widget.Revealer({
                    transition: 'slide_left',
                    transitionDuration: 600,
                    revealChild: is_time_shown.bind(),
                    
                    child: 
                        Widget.Label({
                            className: "bar-bat-rev",
                            label: time_remaining,
                        }),
                }),

                Widget.Box({
                    class_name: class_state,
                    child:
                        Widget.Label({
                            label: Utils.merge([BATTERY.bind('charging'), BATTERY.bind('percent')], (ischarging, percent) => {
                                let icon = ' ';
                                if(!ischarging) switch(Math.floor(percent / 20)) {
                                    case 5:
                                        icon = ' ';
                                        break;
                                    case 4:
                                        icon = ' ';
                                        break;
                                    case 3:
                                        icon = ' ';
                                        break;
                                    case 2:
                                        icon = ' ';
                                        break;
                                    case 1:
                                        icon = ' ';
                                        break;
                                    case 0:
                                        icon = ' ';
                                        break;                        
                                };
                                return `${icon} ${percent}%`;
                                }
                            )
                        })
                })
            ]
        })
    })
};