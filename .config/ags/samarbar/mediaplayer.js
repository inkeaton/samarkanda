const MPRIS = await Service.import('mpris')

/** @param {import('types/service/mpris').MprisPlayer} player */

/*////////////////////////////////////////////////////////////////////////////
    MEDIA PLAYER
////////////////////////////////////////////////////////////////////////////*/ 

const Player = player => Widget.EventBox({
    onPrimaryClick: () => player.playPause(),
    child: Widget.Label({
        className: 'bar-ply',
        truncate: 'end',
        maxWidthChars: 40,
    }).hook(player, label => {
        if (!player)
            return // skip startup execution
        const { track_artists, track_title } = player;
        label.label = `  ${track_title} - ${track_artists.join(', ')}`;
    }),
})

export const mediaplayer = Widget.Box({
    className: 'bar-ply-pll',
    children: MPRIS.bind('players').as(p => p.map(Player))
})