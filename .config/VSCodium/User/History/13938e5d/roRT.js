import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
App.resetCss() // reset if need
App.applyCss('/home/inkeaton/.config/ags/style.css')

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

// "show" the Window widget myBar
export default { windows: [myBar] }