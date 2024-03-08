import { clock }       from './clock.js';
import { mediaplayer } from './mediaplayer.js';

import { workspaces }  from './workspaces.js';

import { systray }     from './systray.js';
import { luminosity }  from './brightness.js';
import { volume }      from './volume.js';
import { battery }     from './battery.js';
import { network }     from './network.js';


/*////////////////////////////////////////////////////////////////////////////
    SAMARBAR
////////////////////////////////////////////////////////////////////////////*/ 

function Left() {
    return Widget.Box({
        className: "tst-bar-lft",
        children: [
            clock(),
            mediaplayer
        ],
    })
};

function Center() {
    return Widget.Box({
        className: "tst-bar-ctr",
        children: [
            workspaces(),
        ],
    })
};

function Right() {
    return Widget.Box({
        className: "tst-bar-rgt",
        hpack: 'end',
        children: [
            systray(),
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
            startWidget:  Left(),
            centerWidget: Center(),
            endWidget:    Right(),
        }),
    })
}