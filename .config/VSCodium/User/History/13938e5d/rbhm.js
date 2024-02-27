import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { interval, exec } from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
App.resetCss()
// apply css style
App.applyCss(App.configDir + '/style.css')

// Create widget of type Label
const myLabel = Widget.Label({
    label: 'some example content',
})

// Create widget of type Window
const myBar = Widget.Window({
    name: 'bar',
    anchor: ['top', 'left', 'right'],
    child: myLabel
})

function Bar(monitor = 0) {
    const myLabel = Widget.Label({
        label: 'some example content',
    })

    interval(1000, () => {
        myLabel.label = exec('date')
    })
    
    const win = Widget.Window({
        monitor,
        name: `bar${monitor}`,
        anchor: ['top', 'left', 'right'],
        child: myLabel
    })

    return win
}

// "show" the Window widget myBar
export default { windows: [Bar(0)] }