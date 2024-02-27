import AgsWidget from 'resource:///com/github/Aylur/ags/widgets/widget.js';

class CounterButton extends AgsWidget(Gtk.Button, 'CounterButton') {
    static {
        GObject.registerClass({
            GTypeName: 'CounterButton',
            Properties: {
                'count': GObject.ParamSpec.int64(
                    'count', 'Count', 'The counting number',
                    GObject.ParamFlags.READWRITE,
                    Number.MIN_SAFE_INTEGER,
                    Number.MAX_SAFE_INTEGER,
                    0,
                ),
            },
        }, this);
    }

    // if you define the ParamSpec
    // the super constructor will take care of setting the count prop
    // so you don't have to explicitly set count in the constructor
    constructor(props) {
        super(props);

        const label = new Gtk.Label({
            label: `${this.count}`,
        });

        this.add(label);

        this.connect('clicked', () => {
            this.count++;
            label.label = `${this.count}`;
        });
    }

    get count() {
        return this._count || 0;
    }

    set count(num) {
        this._count = num;
        this.notify('count');
    }
}