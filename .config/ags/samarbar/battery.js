// @ts-nocheck
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
                        Widget.Box({
                            children: [
                                Widget.Label({
                                    className: "bar-bat-rev",
                                    label: time_remaining,
                                }),
                                Widget.Label({
                                    label: BATTERY.bind('percent').as(percent => `${percent}%`)
                                }),
                            ]
                        })
                }),

                Widget.Box({
                    class_name: class_state,
                    child: 
                        Widget.Icon({
                            class_name: "bar-bat-icn",
                            size: 25,
                            icon: Utils.merge([BATTERY.bind('charging'), BATTERY.bind('percent')], (ischarging, percent) => {
                                if(!ischarging && percent < 16) 
                                    Utils.notify('Batteria quasi scarica!', 'Collegare il caricabatterie');
                                let icon ="/home/inkeaton/.config/ags/icons/bat/batteria-";
                                if(!ischarging) switch(Math.floor(percent / 20)) {
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
                                }
                                else    icon += "charge.svg";
                                
                                return icon;
                            })
                        }),
                }),
            ]
        })
    })
};