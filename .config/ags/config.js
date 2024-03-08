import { samarbar }   from './samarbar/_samarbar.js';
// import { samarrun }   from './samarrun/_samarrun.js';
// import { samarpower } from './samarpower/_samarpower.js';
// import { samarboard } from './samarboard/_samarboard.js';

/*////////////////////////////////////////////////////////////////////////////
    FINAL
////////////////////////////////////////////////////////////////////////////*/ 

// to use scss
const scss = App.configDir + '/style.scss';
const css  = App.configDir + '/style.css';

// make sure sassc is installed on your system
Utils.exec(`sassc ${scss} ${css}`);

// exporting the config so ags can manage the windows
App.config({
    style: css,
    windows: [
        samarbar(),
    ],
});