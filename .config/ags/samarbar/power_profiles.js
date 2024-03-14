const POWERPROFILES = await Service.import('powerprofiles')

/*////////////////////////////////////////////////////////////////////////////
    POWER PROFILE SWITCHER
////////////////////////////////////////////////////////////////////////////*/ 

export const power_profiles = Widget.Button({
    class_name: 'bar-lum-pll',
    label: POWERPROFILES.bind('active_profile').as(prof => prof == 'balanced'? ':)' : '>:D'),
    on_clicked: () => {
        switch (POWERPROFILES.active_profile) {
            case 'balanced':
                POWERPROFILES.active_profile = 'performance';
                break;
            default:
                POWERPROFILES.active_profile = 'balanced';
                break;
        };

        let profile = POWERPROFILES.active_profile == 'balanced' ? 'Bilanciata' : 'Prestazioni';

        Utils.execAsync(`notify-send  -a 'Samarkanda' 'Profilo Energetico Aggiornato' 'Modalità ${profile}'`);
    },
})