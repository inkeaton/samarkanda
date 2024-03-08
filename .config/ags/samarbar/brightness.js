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
                    
                    child: Widget.Slider({
                        class_name: 'bar-lum-sld',
                        value: BRIGHTNESS.bind('screen_value'),
                        drawValue: false,
                        on_change: ({ value }) => BRIGHTNESS.screen_value = value,
                    })
                }),

                Widget.Label({
                    class_name: 'bar-lum',
                    label: BRIGHTNESS.bind('screen_value').as( percent => {
                        percent = Math.round(percent*100);
                        let icon = '';
                        switch(Math.floor(percent / 11)) {
                            case 9:
                                icon = '';
                                break;
                            case 8:
                                icon = '';
                                break;
                            case 7:
                                icon = '';
                                break;
                            case 6:
                                icon = '';
                                break;
                            case 5:
                                icon = '';
                                break;
                            case 4:
                                icon = '';
                                break;
                            case 3:
                                icon = '';
                                break;
                            case 2:
                                icon = '';
                                break;
                            case 1:
                                icon = '';
                                break;
                            case 0:
                                icon = '';
                                break;
                        };
                        return `${icon}   ${percent}%`;
                    }),
                }),
            ]
        })
    })
};