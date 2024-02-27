import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { interval, exec } from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Brightness from './custom_services/lum.js';

App.resetCss()
// apply css style
App.applyCss(App.configDir + '/style.css')

const Bar = (monitor = 0) => Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ['top', 'left', 'right'],
    child: Widget.Label({
        connections: [
            [1000, self => { self.label = exec('date') }],
        ]
    })
})


const brglabel = Label({
    binds: [
        ['label', Brightness, 'screen-value', v => `${v}`],
    ],

    connections: [
        [Brightness, self => {
            // all three are valid
            self.label = `${Brightness['screen-value']}`;
        }, 'notify::screen-value'],
    ]
});


// "show" the Window widget myBar
export default { windows: [brglabel] }