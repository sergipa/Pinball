// Action script...

// [onClipEvent of sprite 257 in frame 1]
on (release)
{
    if (_parent._parent.soundOnBln)
    {
        _parent._parent.g_fSetSoundOff();
    }
    else
    {
        _parent._parent.g_fSetSoundOn();
        _parent._parent.sndClick.start();
    } // end else if
}

// [onClipEvent of sprite 257 in frame 1]
on (rollOver)
{
    if (!_parent._parent.blnPause)
    {
        this.gotoAndStop("ON");
    } // end if
}

// [onClipEvent of sprite 257 in frame 1]
on (rollOut)
{
    this.gotoAndStop("OFF");
}

// [onClipEvent of sprite 257 in frame 1]
on (dragOut)
{
    this.gotoAndStop("OFF");
}

// [onClipEvent of sprite 263 in frame 1]
on (release)
{
    if (!_parent._parent.blnPause)
    {
        _parent._parent.showHelp();
    } // end if
}

// [onClipEvent of sprite 263 in frame 1]
on (rollOver)
{
    if (!_parent._parent.blnPause)
    {
        this.gotoAndStop("ON");
    } // end if
}

// [onClipEvent of sprite 263 in frame 1]
on (rollOut)
{
    this.gotoAndStop("OFF");
}

// [onClipEvent of sprite 263 in frame 1]
on (dragOut)
{
    this.gotoAndStop("OFF");
}

// [onClipEvent of sprite 265 in frame 1]
on (release)
{
    if (!_parent._parent.blnPause)
    {
        _parent._parent.showDlg();
    } // end if
}

// [onClipEvent of sprite 265 in frame 1]
on (rollOver)
{
    if (!_parent._parent.blnPause)
    {
        this.gotoAndStop("ON");
    } // end if
}

// [onClipEvent of sprite 265 in frame 1]
on (rollOut)
{
    this.gotoAndStop("OFF");
}

// [onClipEvent of sprite 265 in frame 1]
on (dragOut)
{
    this.gotoAndStop("OFF");
}
