import Widget from 'resource:///com/github/Aylur/ags/widget.js';

// Create widget of type Label
const myLabel = Widget.Label({
    label: 'some example content',
})

// Create widget of type Window
const myBar = Widget.Window({
    name: 'bar',
    anchor: ['top', 'left', 'right'],
    child: myLabel,
})

export default { windows: [myBar] }