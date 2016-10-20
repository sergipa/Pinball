// Action script...

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

// [Initial MovieClip Action of sprite 89]
#initclip 13
Object.registerClass("Button", mx.controls.Button);
#endinitclip

// [Action in Frame 1]
stop ();
