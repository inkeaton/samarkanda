// importing 
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
//import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Network from 'resource:///com/github/Aylur/ags/service/network.js';
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import { notificationPopup } from './samarbar/notifications.js';
import Brightness from './custom_services/brightness.js';

/*////////////////////////////////////////////////////////////////////////////
    
    + TO DO
        2 - [ ] Refactor to reuse code AND new features
                [ ] Clock
                [ ] Media Player
                [x] Workspaces 
                [ ] System Tray
                [ ] Brightness
                [ ] Battery
                [ ] Network
        3 - [ ] implement notifications manager (swap with mako)
        4 - [ ] implement runner (swap with rofi)
                [ ] implement app launcher
                [ ] implement radio launcher
                [ ] implement power menu
            
//////////////////////////////////////////////////////////////////////////////
    CLOCK
////////////////////////////////////////////////////////////////////////////*/ 

const isDateShown = Variable(Boolean(false));

const TimeAndDate = () => Widget.EventBox({
    onPrimaryClick: () => isDateShown.setValue(!isDateShown.getValue()),
    child: Widget.Box({
        className: "bar-clk-pll",
        children: [ 
            Widget.Label({className: 'bar-clk',}) 
                .poll(20000, label => label.label = Utils.exec('date \'+%H : %M\'')),
            
            Widget.Revealer({
                transitionDuration: 600,
                transition: 'slide_right',
                revealChild: isDateShown.bind(),

                child: Widget.Label()
                    .poll(3600000, label => label.label = Utils.exec('date \'+%A %d %B\''))
            }) 
        ]
    })
});

/*////////////////////////////////////////////////////////////////////////////
    NOTIFICATIONS
////////////////////////////////////////////////////////////////////////////*/ 

        // T O  B E  D O N E . . .


/*////////////////////////////////////////////////////////////////////////////
    MEDIA PLAYER
////////////////////////////////////////////////////////////////////////////*/ 

// TO IMPROVE: Makes it so if new player gets added, gets privileged

const MediaPlayer = () => Widget.EventBox({
    connections: [[Mpris, self => {
        // Makes it invisible if nothing is being played
        if (Mpris.players[0])
            self.visible = true;
        else
            self.visible = false;
    }]],
    onPrimaryClick: () => Mpris.players[0]?.playPause(),
    onScrollUp: () => Mpris.players[0]?.next(),
    onScrollDown: () => Mpris.players[0]?.previous(),
    child: Widget.Box({
    className: 'bar-ply-pll',
    child: Widget.Label({
        className: 'bar-ply',
        truncate: 'end',
        maxWidthChars: 40,
        connections: [[Mpris, self => {
            const mpris = Mpris.players[0];
            
            if (mpris) {
                let icon = ' ';
                if (mpris.playBackStatus == "Paused")
                    icon = ' ';
                self.label = `${icon} ${mpris.trackTitle} - ${mpris.trackArtists}`;
            }
            else
                self.label = 'N/A';
        }]],
    }),
})
});

/*////////////////////////////////////////////////////////////////////////////
    WORKSPACES
////////////////////////////////////////////////////////////////////////////*/ 

// design by kotontrion, on github 
const WorkspaceButton = (name) => Widget.Button({
    class_name: "bar-wsp",
    attribute: {name: name},
    on_primary_click_release: () => Hyprland.sendMessage(`dispatch workspace name:${name}`)
  })
    .hook(Hyprland.active.workspace, (button) => {
      button.toggleClassName("bar-wsp-foc", Hyprland.active.workspace.name === name);
    });
  
const Workspaces = () => Widget.Box({
    class_name: "bar-wsp-pll",
    attribute: {
      ws: new Map(),
      onAdded: (box, ws) => {
        if(!ws) return;
        const wsButton = WorkspaceButton(ws);
        box.attribute.ws.set(ws, wsButton);
        const pos = box.children.filter(button => button.attribute.name <= ws ).length;
        box.add(wsButton);
        box.reorder_child(wsButton, pos);
        box.show_all()
      },
      onRemoved: (box, ws) => {
        if(!ws) return;
        const wsButton = box.attribute.ws.get(ws);
        box.remove(wsButton);
        wsButton.destroy();
        box.attribute.ws.delete(ws);
      }
    },
    setup: (box) => {
      const connID = Hyprland.connect("notify::workspaces", () => {
        Hyprland.workspaces.forEach(ws => box.attribute.onAdded(box, ws.name));
        Hyprland.disconnect(connID)
      })
    }
})
    .hook(Hyprland, (box, ws) => box.attribute.onAdded(box, ws),"workspace-added")
    .hook(Hyprland, (box, ws) => box.attribute.onRemoved(box, ws),"workspace-removed")

/*////////////////////////////////////////////////////////////////////////////
    BRIGHTNESS
////////////////////////////////////////////////////////////////////////////*/ 

const isLumBarShown = Variable(Boolean(false));

const Luminosity = () => Widget.EventBox({
    onPrimaryClick: () => isLumBarShown.setValue(!isLumBarShown.getValue()),
    child: Widget.Box({
        className: "bar-lum-pll",
        children: [ 
            Widget.Revealer({
                transitionDuration: 600,
                transition: 'slide_left',
                connections: [[isLumBarShown, self => {
                    self.revealChild = isLumBarShown.getValue();
                }]],
                child: Widget.Slider({
                    className: 'bar-lum-sld',
                    binds: [
                        ['value', Brightness, 'screen-value', v => v],
                    ],
                    drawValue: false,
                    onChange: ({ value }) => brightness.screen_value = value,
                })
            }),
            Widget.Label({
                className: 'bar-lum',
                connections: [[Brightness, self => {
                    let value = Math.round(Brightness.screenValue*100);
                    const icon = [
                        [88,  ''],
                        [77,  ''],
                        [66,  ''],
                        [55,  ''],
                        [44,  ''],
                        [33,  ''],
                        [22,  ''],
                        [11,  ''],
                        [0,   ''],
                    ].find(([threshold]) => threshold <= value)[1];
    
                    self.label = `${icon}  ${value}%`;
                }, 'notify::screen-value']],
            }),
        ]
    })
});

/*////////////////////////////////////////////////////////////////////////////
    AUDIO
////////////////////////////////////////////////////////////////////////////*/ 

const isAudioBarShown = Variable(Boolean(false));

const AudioPll = () => Widget.EventBox({
    onPrimaryClick: () => isAudioBarShown.setValue(!isAudioBarShown.getValue()),
    onSecondaryClick: () => execAsync('pavucontrol &'),
    child: Widget.Box({
        className: "bar-aud-pll",
        children: [ 
            Widget.Revealer({
                transitionDuration: 600,
                transition: 'slide_left',
                connections: [[isAudioBarShown, self => {
                    self.revealChild = isAudioBarShown.getValue();
                }]],
                child: Widget.Slider({
                    className: 'bar-aud-sld',
                    connections: [[Audio, self => {
                        self.value = Audio.speaker?.volume || 0;
                    }, 'speaker-changed']],
                    drawValue: false,
                    onChange: ({ value }) => Audio.speaker.volume = value,
                })
            }),
            Widget.Box({
                // TO IMPROVE: use the following instead of the connection
                // className: `${(Audio.speaker.stream.isMuted || Audio.speaker.isMuted)? 'bar-aud-mut' : 'bar-aud'}`,
                connections: [[Audio, self => {
                    self.className = `${(Audio.speaker.stream.isMuted || Audio.speaker.isMuted)? 'bar-aud-mut' : 'bar-aud'}`
                }, 'speaker-changed']],
                child: 
                    Widget.Label({
                        connections: [[Audio, self => {
                            if (!Audio.speaker)
                                return;
                            const vol = Audio.speaker.volume * 100;
                            let icon = [
                                [67,  ' '],
                                [34,  ' '],
                                [0,   '  '],
                            ].find(([threshold]) => threshold <= vol)[1];
                        
                            if (Audio.speaker.stream.isMuted)
                                icon = '  ';

                            self.tooltipText = `Volume ${Math.floor(vol)}%`;

                            self.label = `${icon} ${Math.round(Audio.speaker.volume*100)}%`;
            
                        }, 'speaker-changed']],
                    })
            }),
            
        ]
    })
});

/*////////////////////////////////////////////////////////////////////////////
    BATTERY
////////////////////////////////////////////////////////////////////////////*/ 

const isBatteryBarShown = Variable(Boolean(false));

const BatteryPll = () => Widget.EventBox({
    onPrimaryClick: () => isBatteryBarShown.setValue(!isBatteryBarShown.getValue()),
    child: Widget.Box({
        className: "bar-bat-pll",
        children: [ 
            Widget.Revealer({
                transitionDuration: 600,
                transition: 'slide_left',
                connections: [[isBatteryBarShown, self => {
                    self.revealChild = isBatteryBarShown.getValue();
                }]],
                child: Widget.Label({
                    className: "bar-bat-rev",
                    connections: [[Battery, self => {
                        if (Battery.percent < 0)
                            return;
        
                        self.label = `${Math.floor(Battery.timeRemaining/3600)} h ${Math.floor((Battery.timeRemaining % 3600)/60)} m`;
                    }]],
                }),
            }),
            Widget.Box({
                connections: [[Battery, self => {
                    self.className = `${Battery.charging ? 'bar-bat-chg' : ((Battery.percent < 16) ? 'bar-bat-low' : 'bar-bat')}`
                }]],
                child: Widget.Label({
                    connections: [[Battery, self => {
                        if (Battery.percent < 0)
                            return;
                        let icon;
                        if (!Battery.charging && (Battery.percent == 15))
                            execAsync('notify-send "Attenzione" "Batteria inferiore al 15%" -u critical');
                        if (Battery.charging) 
                            icon = ' ';
                        else 
                            icon = [
                                [90,  ' '],
                                [67,  ' '],
                                [34,  ' '],
                                [15,  ' '],
                                [0,   ' '],
                            ].find(([threshold]) => threshold <= Battery.percent)[1];
                            
                        self.label = `${icon} ${Battery.percent}%`;
                    }]],
                })
            })
        ]
    })
});

/*////////////////////////////////////////////////////////////////////////////
    NETWORK
////////////////////////////////////////////////////////////////////////////*/ 

// TO IMPROVE: ADD ICONS
// TO DO: Style buttons

const isNetShown = Variable(Boolean(false));

const WifiIndicator = () => Widget.Icon({
    className: 'bar-net',
    binds: [['icon', Network.wifi, 'icon-name']],
});

const WiredIndicator = () => Widget.Icon({
    className: 'bar-net',
    binds: [['icon', Network.wired, 'icon-name']],
});

const NetworkIndicator = () => Widget.Stack({
    items: [
        ['wifi', WifiIndicator()],
        ['wired', WiredIndicator()],
    ],
    binds: [['shown', Network, 'primary', p => p || 'wifi']],
});

const NetPll = () => Widget.EventBox({
    onPrimaryClick: () => isNetShown.setValue(!isNetShown.getValue()),
    onSecondaryClick: () => execAsync('kitty nmtui'),
    child: Widget.Box({
        className: "bar-net-pll",
        children: [ 
            Widget.Revealer({
                transitionDuration: 600,
                transition: 'slide_left',
                connections: [[isNetShown, self => {
                    self.revealChild = isNetShown.getValue();
                }]],
                child: Widget.Label({
                    binds: [['label', Network.wifi, 'ssid']],
                }),
            }),
            NetworkIndicator(),
        ]
    })
});

/*////////////////////////////////////////////////////////////////////////////
    SYSTEM TRAY
////////////////////////////////////////////////////////////////////////////*/ 

const SysTray = () => Widget.Box({
    className: "bar-sys",
    connections: [[SystemTray, self => {
        self.children = SystemTray.items.map(item => Widget.EventBox({
            child: Widget.Icon({className: "tst-sys-icn", binds: [['icon', item, 'icon']] }),
                onPrimaryClick: (_, event) => item.activate(event),
                onSecondaryClick: (_, event) => item.openMenu(event),
                binds: [['tooltip-markup', item, 'tooltip-markup']],
        }));
    }]],
});

/*////////////////////////////////////////////////////////////////////////////
    BAR
////////////////////////////////////////////////////////////////////////////*/ 

const Left = () => Widget.Box({
    className: "tst-bar-lft",
    children: [
        TimeAndDate(),
        MediaPlayer(),
    ],
});

const Center = () => Widget.Box({
    className: "tst-bar-ctr",
    children: [
        Workspaces(),
    ],
});

const Right = () => Widget.Box({
    className: "tst-bar-rgt",
    hpack: 'end',
    children: [
        SysTray(),
        //ArchUpdates(),
        Luminosity(),
        AudioPll(),
        BatteryPll(),
        NetPll(),
    ],
});

const Bar = ({ monitor } = {}) => Widget.Window({
    name: `samarbar-${monitor}`, // name has to be unique for multiple monitors
    className: 'samarbar',
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        startWidget: Left(),
        centerWidget: Center(),
        endWidget: Right(),
    }),
})

/*////////////////////////////////////////////////////////////////////////////
    STYLE AND FINAL
////////////////////////////////////////////////////////////////////////////*/ 

// to use scss
const scss = App.configDir + '/style.scss';
const css = App.configDir + '/style.css';

// make sure sassc is installed on your system
exec(`sassc ${scss} ${css}`);

// exporting the config so ags can manage the windows
export default {
    style: css,
    windows: [
        Bar({ monitor: 0 }),
        notificationPopup,
    ],
};