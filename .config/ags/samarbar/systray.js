const SYSTEMTRAY = await Service.import('systemtray')

/*////////////////////////////////////////////////////////////////////////////
    SYSTEM TRAY
////////////////////////////////////////////////////////////////////////////*/ 

export function systray() {
    const items = SYSTEMTRAY.bind('items')
        .as(items => items.map(item => Widget.EventBox({
            child: Widget.Icon({ 
                className: "tst-sys-icn",  
                icon: item.bind('icon') 
            }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind('tooltip_markup'),
        })))

    return Widget.Box({
        className: "bar-sys",
        children: items,
    })
}
