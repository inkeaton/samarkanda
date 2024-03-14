const NET = await Service.import('network')

/*////////////////////////////////////////////////////////////////////////////
    NETWORK
////////////////////////////////////////////////////////////////////////////// 
    TO BE IMPROVED:
        + Use custom SVG icons instead of glyphs
////////////////////////////////////////////////////////////////////////////*/ 

const wifiIndicator = () => Widget.Icon({
    className: 'bar-net',
    size: 25,
    icon: NET.wifi.bind("strength").as( strength => {
        let icon ="/home/inkeaton/.config/ags/icons/net/network-";
        switch(Math.floor(strength / 20)) {
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
})

const wiredIndicator = () => Widget.Icon({
    className: 'bar-net',
    icon: NET.wired.bind('icon_name'),
})

const networkIndicator = () => Widget.Stack({
    children: {
        'wifi': wifiIndicator(),
        'wired': wiredIndicator(),
    },
    shown: NET.bind('primary').as(p => p || 'wifi'),
})

export function network() {
    const is_ssid_shown = Variable(false);

    return Widget.EventBox({
        onPrimaryClick: () => is_ssid_shown.value = !is_ssid_shown.getValue(),
        onSecondaryClick: () => Utils.execAsync('kitty nmtui'),
        
        child: Widget.Box({
            className: "bar-net-pll",
            children: [ 
                Widget.Revealer({
                    transitionDuration: 600,
                    transition: 'slide_left',
                    revealChild: is_ssid_shown.bind(),
                    
                    child: Widget.Label().bind('label', NET.wifi, 'ssid')
                }),
                networkIndicator(),
            ]
        })
    })
};