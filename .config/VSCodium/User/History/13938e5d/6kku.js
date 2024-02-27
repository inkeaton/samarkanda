import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { interval, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
App.resetCss()
// apply css style
App.applyCss(App.configDir + '/style.css')

function Bar(monitor = 0) {

    // date label, with default text
    const myLabel = Widget.Label({
        label: 'some example content',
    })

    // every 1000 ms, myLabel text is updated with the date
    interval(1000, () => {
        myLabel.label = execAsync('date')
    })

    // Window widget
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