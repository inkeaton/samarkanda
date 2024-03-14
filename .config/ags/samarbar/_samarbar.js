import { clock }       from './clock.js';
import { mediaplayer } from './mediaplayer.js';

import { workspaces }  from './workspaces.js';

import { systray }     from './systray.js';
import { luminosity }  from './brightness.js';
import { volume }      from './volume.js';
import { battery }     from './battery.js';
import { network }     from './network.js';

import { power_profiles }     from './power_profiles.js';


/*////////////////////////////////////////////////////////////////////////////
    SAMARBAR
////////////////////////////////////////////////////////////////////////////*/ 

function left() {
    return Widget.Box({
        className: "tst-bar-lft",
        children: [
            clock(),
            mediaplayer
        ],
    })
};

function center() {
    return Widget.Box({
        className: "tst-bar-ctr",
        children: [
            workspaces(),
        ],
    })
};

function right() {
    return Widget.Box({
        className: "tst-bar-rgt",
        hpack: 'end',
        children: [
            systray(),
            power_profiles,
            luminosity(),
            volume(),
            battery(),
            network(),
        ],
    })
};

export function samarbar(monitor = 0) {
    return Widget.Window({
        name: `samarbar-${monitor}`,
        className: 'samarbar',
        anchor: ['top', 'left', 'right'],
        exclusivity: 'exclusive',
        child: Widget.CenterBox({
            startWidget:  left(),
            centerWidget: center(),
            endWidget:    right(),
        }),
    })
}