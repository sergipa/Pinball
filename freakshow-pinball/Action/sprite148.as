// Action script...

// [onClipEvent of sprite 89 in frame 2]
onClipEvent (initialize)
{
    icon = "";
    label = "Button";
    labelPlacement = "right";
    selected = false;
    toggle = false;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 85 in frame 2]
onClipEvent (initialize)
{
    selected = false;
    toggle = false;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [Initial MovieClip Action of sprite 148]
#initclip 17
Object.registerClass("HScrollBar", mx.controls.HScrollBar);
#endinitclip

// [Action in Frame 1]
stop ();
