import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { interval, exec } from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Brightness from './custom_services/brightness.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

App.resetCss()
// apply css style
App.applyCss(App.configDir + '/style.css')

const myVariable = Variable(0)

myVariable.connect('changed', ({ value }) => {
    print('myVariable changed to ' + `${value}`)
})

const bar = Widget.Window({
    name: 'bar',
    child: Widget.Label({
        connections: [[myVariable, self => {
            self.label = `${myVariable.value}`
        }]]
    })
})

myVariable.value++
myVariable.value++
myVariable.value++

// "show" the Window widget myBar
export default { windows: [bar] }