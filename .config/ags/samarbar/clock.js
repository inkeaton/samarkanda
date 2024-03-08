
const TIME = Variable('', {
    poll: [20000, 'date \'+%H : %M\''],
})

const DATE = Variable('', {
    poll: [3600000, 'date \'+%A %d %B\''],
})

//////////////////////////////////////////////////////////////////////////////
// CLOCK
////////////////////////////////////////////////////////////////////////////*/ 

export function clock() { 
    const is_date_shown = Variable(false);

    return Widget.EventBox({
        on_primary_click: () => is_date_shown.value = !is_date_shown.getValue(),

        child: Widget.Box({
            className: "bar-clk-pll",

            children: [ 

                Widget.Label({
                    className: 'bar-clk',
                    label: TIME.bind(),
                }), 

                
                Widget.Revealer({
                    transitionDuration: 600,
                    transition: 'slide_right',
                    revealChild: is_date_shown.bind(),

                    child: 
                        Widget.Label({
                            label: DATE.bind(),
                        })
                }) 
            ]
        })
    })
};