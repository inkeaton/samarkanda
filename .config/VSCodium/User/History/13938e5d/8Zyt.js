import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { interval, exec } from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Brightness from './custom_services/brightness.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';


App.resetCss()
// apply css style
App.applyCss(App.configDir + '/style.css')

const pactl = Variable({ count: 0, msg: '' }, {
    listen: ['pactl subscribe', msg => ({
        count: pactl.value.count + 1,
        msg: msg,
    })]
})

pactl.connect('changed', ({value}) => {
    print(value.msg, value.count)
})

const label = Widget.Label({
    connections: [[pactl, self => {
        const { count, msg } = pactl.value
        self.label = `${msg} ${count}`
    }]]
})

// widgets are GObjects too
label.connect('notify::label', ({ label }) => {
    print('label changed to ', label)
})

const Bar = (monitor = 0) => Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ['top', 'left', 'right'],
    child: label
})

// "show" the Window widget myBar
export default { windows: [Bar(0)] }