﻿// Action script...

// [onClipEvent of sprite 89 in frame 1]
onClipEvent (load)
{
    function __f_click(eventObj)
    {
        _parent._y = -1000;
        _parent._parent.textArea1._y = -1000;
    } // End of the function
    this.addEventListener("click", __f_click);
}
