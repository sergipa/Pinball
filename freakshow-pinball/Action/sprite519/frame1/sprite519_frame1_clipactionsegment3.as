﻿// Action script...

// [onClipEvent of sprite 265 in frame 1]
on (rollOver)
{
    if (!_parent._parent.blnPause)
    {
        this.gotoAndStop("ON");
    } // end if
}
