import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { interval, exec } from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Brightness from './custom_services/brightness.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';


App.resetCss()
// apply css style
App.applyCss(App.configDir + '/style.css')

const batteryProgress = Widget.CircularProgress({
    className: 'progress',
    child: Widget.Icon({
        binds: [['icon', Battery, 'icon-name']],
    }),
    connections: [[Battery, self => {
        self.value = Battery.percent / 100;
    }]]
})


const Bar = (monitor = 0) => Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ['top', 'left', 'right'],
    child: batteryProgress
})

// "show" the Window widget myBar
export default { windows: [Bar(0)] }