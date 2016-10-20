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
