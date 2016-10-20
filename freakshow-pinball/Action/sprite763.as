// Action script...

// [Initial MovieClip Action of sprite 763]
#initclip 31
class CRollOver extends CComponent
{
    var _parent, mcCheckArea, _name;
    function CRollOver()
    {
        super();
        _parent.arrComponents.push(this);
        _parent.arrComponentTypes.push("RollOver");
        _parent.arrRollOvers.push(this);
        mcCheckArea._visible = false;
    } // End of the function
    function activate(obj)
    {
        if (blnOnLeaving)
        {
            obj._name = true;
        }
        else
        {
            _parent[_name + "Over"](obj);
        } // end else if
    } // End of the function
    function reset(obj)
    {
        if (blnOnLeaving)
        {
            if (this[obj._name])
            {
                obj._name = false;
                _parent[_name + "Over"](obj);
            } // end if
        } // end if
    } // End of the function
    var blnOnLeaving = true;
    var blnCheck = true;
    var blnHitCheck = true;
} // End of Class
#endinitclip
