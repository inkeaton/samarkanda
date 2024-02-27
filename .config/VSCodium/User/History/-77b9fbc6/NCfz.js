import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
import Service from 'resource:///com/github/Aylur/ags/service.js';


class Brightness extends Service {
    static {
        Service.register(this, {}, {
            'screen': ['float', 'rw'],
            'kbd': ['int', 'rw'],
        });
    }

    #kbd = 0;
    #kbdMax = 3;
    #screen = 0;

    get kbd() { return this.#kbd; }
    get screen() { return this.#screen; }

    set kbd(value) {
        if (value < 0 || value > this.#kbdMax)
            return;

        Utils.execAsync(`brightnessctl s ${value} -q`)
            .then(() => {
                this.#kbd = value;
                this.changed('kbd');
            })
            .catch(console.error);
    }

    set screen(percent) {
        if (percent < 0)
            percent = 0;

        if (percent > 1)
            percent = 1;

        Utils.execAsync(`brightnessctl s ${percent * 100}% -q`)
            .then(() => {
                this.#screen = percent;
                this.changed('screen');
            })
            .catch(console.error);
    }

    constructor() {
        super();
        try {
            this.#kbd = Number(Utils.exec(`brightnessctl g`));
            this.#kbdMax = Number(Utils.exec(`brightnessctl m`));
            this.#screen = Number(Utils.exec('brightnessctl g')) / Number(Utils.exec('brightnessctl m'));
        } catch (error) {
            console.error('missing dependancy: brightnessctl');
        }
    }
}

export default new Brightness();