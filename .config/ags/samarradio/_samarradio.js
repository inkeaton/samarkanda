const WINDOW_NAME = 'samarradio';

const STATIONS = [{name: "Lofi Girl 📝🎧",           url: "https://www.youtube.com/live/jfKfPfyJRdk?si=iIx1cvpxq5lPi4I9"}, 
                  {name: "Synthwave Boy 🖥️🕹️",       url: "https://www.youtube.com/live/4xDzrJKXOOY?si=FhLofGjuYivk7ier"},
                  {name: "Nippon Smooth 🗻🎺",       url: "https://youtu.be/BIZz4A39rT4"},
                  {name: "Cafè Le Blanc 🔪👺",       url: "https://youtu.be/MF8RFD7tk48"},
                  {name: "Underground Tunes 🐐🌼",   url: "https://youtu.be/A7vMrjsBMTI"},
                  {name: "Zelda & Chill 🗡️🧚",       url: "https://youtu.be/oCaOSz13h_o"},
                  {name: "Game Night 🎮🌃",          url: "https://youtu.be/JJis0sld2cM"},
                  {name: "Zelda & Chill 🗡️🧚",       url: "https://youtu.be/oCaOSz13h_o"},
                  {name: "RTL 102.5 📻🎸",           url: "https://streamingv2.shoutcast.com/rtl-1025"},
                  {name: "Radio Babboleo 📻🎸",      url: "https://bbl.fluidstream.eu/babboleo.aac"},
                  {name: "Radio Freccia 📻🎸",       url: "https://streamingv2.shoutcast.com/radiofreccia"},
                  {name: "Radio Deejay 📻🎸",        url: "https://StreamCdnB3-4c4b867c89244861ac216426883d1ad0.msvdn.net/radiodeejay/radiodeejay/master_ma.m3u8"},
                  {name: "Funky Soul 📻🎸",          url: "https://54-funk-soul-dance.stream.laut.fm/54-funk-soul-dance?t302=2023-08-15_06-27-51&uuid=a5486b5b-c33f-42f0-9dd9-f87f06e056df"},
                  {name: "Boogie Emotions 📻🎸",     url: "https://youtu.be/4PXzJRiCISk?si=obGIMYR8D1CZi2q9"},
                  {name: "Galaxy News Radio 📻🎸",   url: "http://fallout.fm:8000/falloutfm2.ogg"},
                  {name: "Radio New Vegas 📻🎸",     url: "http://fallout.fm:8000/falloutfm3.ogg"},
                  {name: "Diamond City Radio 📻🎸",  url: "http://fallout.fm:8000/falloutfm6.ogg"},
                  {name: "Radio Appalachia 📻🎸",    url: "http://fallout.fm:8000/falloutfm10.ogg"}];

/*////////////////////////////////////////////////////////////////////////////
    RADIO MENU
////////////////////////////////////////////////////////////////////////////// 
    TO BE IMPROVED:
        + Cambiare "spegni la radio" con un pulsante con icona
        + Aggiungere catch all'execAsync
////////////////////////////////////////////////////////////////////////////*/ 

const option = (option) => Widget.Button({
    class_name: 'rad-btn',
    label: option.name,
    on_clicked: () => {
        App.closeWindow(WINDOW_NAME);
        Utils.exec("pkill -f radio-mpv");
        Utils.execAsync(`mpv --volume=60 --video=no --loop --title="radio-mpv" ${option.url}`);
    },
});

function radiomenu() { 

    if(Utils.exec("pgrep -f radio-mpv"))
        Utils.exec("pkill -f radio-mpv");

    const list = Widget.Box({
        vertical: true,
        hexpand_set: false,
        children: STATIONS.map(option),
    })

    return Widget.Box({
        class_name: 'rad-ctr',
        spacing: 15,
        vertical: true,
        children: [
            Widget.Label({
                class_name: 'rad-lbl',
                label: "Radio",
            }),
            Widget.Button({
                class_name: 'rad-btn',
                label: "Spegni la radio",
                on_clicked: () => {
                    App.closeWindow(WINDOW_NAME);
                    Utils.exec("pkill -f radio-mpv");
                },
            }),
            Widget.Scrollable({
                class_name: 'rad-opt',
                hscroll: "never",
                child: list,
            })
        ],
    })
};

// there needs to be only one instance
export const samarradio = Widget.Window({
    name: WINDOW_NAME,
    setup: self => self.keybind("Escape", () => { App.closeWindow(WINDOW_NAME) }),
    visible: false,
    class_name: "rad-win",
    keymode: "exclusive",
    child: radiomenu(),
});