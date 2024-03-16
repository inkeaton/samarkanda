
const WINDOW_NAME = 'samaroff';

const OPTIONS = [{command: "shutdown    now", icon: "accensione"}, 
                 {command: "shutdown -r now",   icon: "riavvio"   }];

/*////////////////////////////////////////////////////////////////////////////
    POWER MENU
////////////////////////////////////////////////////////////////////////////// 
    TO BE IMPROVED:
        + 
////////////////////////////////////////////////////////////////////////////*/ 

const option = (option) => Widget.Button({
    class_name: 'pow-btn',
    on_clicked: () => {
        App.closeWindow(WINDOW_NAME);
        Utils.execAsync(option.command);
    },
    child: Widget.Icon({
        class_name: "pow-icn",
        icon: "/home/inkeaton/.config/ags/icons/pow/" + option.icon + ".svg",
    }),
});

const powermenu  = Widget.Box({
    class_name: 'pow-ctr',
    spacing: 15,
    vertical: true,
    children: [
        Widget.Label({
            class_name: 'pow-lbl',
            label: "Vai già via?",
        }),
        Widget.CenterBox({
            center_widget: 
                Widget.Box({
                class_name: 'pow-opt',
                spacing: 8,
                vertical: false,
                children: OPTIONS.map(option),
            })
        })
    ],
});

// there needs to be only one instance
export const samaroff = Widget.Window({
    name: WINDOW_NAME,
    setup: self => self.keybind("Escape", () => { App.closeWindow(WINDOW_NAME) }),
    visible: false,
    class_name: "pow-win",
    keymode: "exclusive",
    child: powermenu,
});