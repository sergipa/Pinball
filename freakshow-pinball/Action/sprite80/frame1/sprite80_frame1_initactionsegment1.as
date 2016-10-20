// Action script...

// [Initial MovieClip Action of sprite 80]
#initclip 4
Object.registerClass("FocusManager", mx.managers.FocusManager);
if (_root.focusManager == undefined)
{
    _root.createClassObject(mx.managers.FocusManager, "focusManager", mx.managers.DepthManager.highestDepth--);
} // end if
#endinitclip
