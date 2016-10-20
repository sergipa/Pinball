// Action script...

// [onClipEvent of sprite 265 in frame 1]
on (release)
{
    if (!_parent._parent.blnPause)
    {
        _parent._parent.showDlg();
    } // end if
}
