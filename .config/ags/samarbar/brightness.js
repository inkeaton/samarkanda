import BRIGHTNESS from './../custom_services/brightness.js';

/*////////////////////////////////////////////////////////////////////////////
    BRIGHTNESS
////////////////////////////////////////////////////////////////////////////// 
    TO BE IMPROVED:
        + Use SVG icons instead of glyphs
////////////////////////////////////////////////////////////////////////////*/ 

export function luminosity(){
    const is_lum_bar_shown = Variable(false);

    return Widget.EventBox({
        on_primary_click: () => is_lum_bar_shown.value = !is_lum_bar_shown.getValue(),

        child: Widget.Box({
            class_name: "bar-lum-pll",
            
            children: [ 

                Widget.Revealer({
                    revealChild: is_lum_bar_shown.bind(),
                    transition: 'slide_left',
                    transitionDuration: 600,
                    
                    child: Widget.Label({
                        label: BRIGHTNESS.bind('screen_value').as( percent => `${Math.round(percent*100)}%`),
                    }),
                }),
                
                Widget.Box({
                    class_name: 'bar-lum',
                    child: 
                        Widget.Icon({
                            class_name: "bar-bat-icn",
                            size: 17,
                            icon: BRIGHTNESS.bind('screen_value').as( percent => {
                                percent = Math.round(percent*100);
                                let icon ="/home/inkeaton/.config/ags/icons/lum/luminosità-";
                                switch(Math.floor(percent / 20)) {
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
                                return icon;
                            }),
                        }),
                })
            ]
        })
    })
};