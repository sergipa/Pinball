// Action script...

// [Initial MovieClip Action of sprite 767]
#initclip 35
class CPlunger extends CComponent
{
    var _parent, mcLaunchArea, mcSpring, _name, mcLaunchVector;
    function CPlunger()
    {
        super();
        _parent.arrComponents.push(this);
        _parent.arrComponentTypes.push("Plunger");
        _parent.arrPlungers.push(this);
        mcLaunchArea._visible = false;
    } // End of the function
    function charge()
    {
        if (!blnCharging)
        {
            blnCharging = true;
            mcSpring.gotoAndStop("charged");
            lastFrame = mcSpring._currentframe;
            mcSpring.gotoAndStop("released");
            chargeIntID = setInterval(this, "moveSpring", Math.ceil(chargeTime / (lastFrame - 1)));
            for (var _loc3 = 0; _loc3 < _parent.arrBalls.length; ++_loc3)
            {
                var _loc2 = _parent.arrBalls[_loc3];
                if (mcLaunchArea.hitTest(_loc2.x, _loc2.y, true))
                {
                    _parent[_name + "Charge"](_loc2);
                } // end if
            } // end of for
        } // end if
    } // End of the function
    function moveSpring()
    {
        mcSpring.gotoAndStop(mcSpring._currentframe + 1);
        if (mcSpring._currentframe == lastFrame)
        {
            clearInterval(chargeIntID);
        } // end if
        updateAfterEvent();
    } // End of the function
    function launch()
    {
        if (blnCharging)
        {
            blnCharging = false;
            clearInterval(chargeIntID);
            for (var _loc5 = 0; _loc5 < _parent.arrBalls.length; ++_loc5)
            {
                var _loc2 = _parent.arrBalls[_loc5];
                var _loc4 = {x: _loc2.x, y: _loc2.y};
                _parent.localToGlobal(_loc4);
                if (mcLaunchArea.hitTest(_loc4.x, _loc4.y, true))
                {
                    _loc2.power = mcSpring._currentframe / lastFrame;
                    var _loc3 = 0;
                    if (mcLaunchVector._rotation != undefined)
                    {
                        _loc3 = mcLaunchVector._rotation / 180 * 3.141593;
                    } // end if
                    _loc2.vX = Math.sin(_loc3) * maxSpeed * _loc2.power + 0.010000;
                    _loc2.vY = -Math.cos(_loc3) * maxSpeed * _loc2.power;
                    _loc2.blnLockMovement = false;
                    _loc2.blnLockGravity = false;
                    _parent[_name + "Launch"](_loc2);
                } // end if
            } // end of for
            _parent.playSound(_parent.sndLaunch, 0, 1, mcSpring._currentframe / lastFrame * 90 + 10);
            mcSpring.gotoAndStop("released");
        } // end if
    } // End of the function
    var maxSpeed = 15;
    var chargeTime = 2000;
    var blnCharging = false;
    var chargeIntID = null;
    var lastFrame = null;
} // End of Class
#endinitclip
