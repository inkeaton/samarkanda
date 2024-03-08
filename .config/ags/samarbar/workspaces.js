const HYPRLAND = await Service.import('hyprland')

/*////////////////////////////////////////////////////////////////////////////
    WORKSPACES
////////////////////////////////////////////////////////////////////////////*/ 
    
const dispatch = ws => HYPRLAND.messageAsync(`dispatch workspace ${ws}`);
    
export const workspaces = () => Widget.EventBox({
    child: Widget.Box({
        class_name: "bar-wsp-pll",
        children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
            class_name: "bar-wsp",
            attribute: i,
            onClicked: () => dispatch(i),
        }).hook(HYPRLAND.active.workspace, (button) => {
            button.toggleClassName("bar-wsp-foc", HYPRLAND.active.workspace.id === i);
          })),

        // remove this setup hook if you want fixed number of buttons
        setup: self => self.hook(HYPRLAND, () => self.children.forEach(btn => {
            btn.visible = HYPRLAND.workspaces.some(ws => ws.id === btn.attribute);
        })),
    }),
})