// Action script...

// [Initial MovieClip Action of sprite 765]
#initclip 33
class CHole extends CComponent
{
    var _parent, mcLaunchVector, getNextHighestDepth, createEmptyMovieClip, mcDumb, arrStoredBalls, mcMask, _name, _x, _y, activateScore, scoreMultiplier, dT, decTimes, _alpha, vX, vY, place, x, y, onEnterFrame, blnLockGravity, setMask;
    function CHole()
    {
        super();
        _parent.arrComponents.push(this);
        _parent.arrComponentTypes.push("Hole");
        _parent.arrHoles.push(this);
        mcLaunchVector._visible = false;
        this.createEmptyMovieClip("mcDumb", this.getNextHighestDepth());
        mcDumb.lineStyle(1);
        mcDumb.beginFill(16711680);
        var _loc3 = holeRadius + _parent.ballR;
        mcDumb.moveTo(-_loc3, _loc3);
        mcDumb.lineTo(_loc3, _loc3);
        mcDumb.lineTo(_loc3, -_loc3);
        mcDumb.lineTo(-_loc3, -_loc3);
        mcDumb.lineTo(-_loc3, _loc3);
        mcDumb.endFill;
        mcDumb._alpha = 0;
        arrStoredBalls = new Array();
        mcMask._visible = false;
    } // End of the function
    function check(obj)
    {
        if (blnInlet && obj[_name] != true)
        {
            var _loc5 = Math.sqrt(_parent.sqr(obj.x - _x) + _parent.sqr(obj.y - _y));
            if (_loc5 < holeRadius && Math.sqrt(obj.vX * obj.vX + obj.vY * obj.vY) < maxSpeed)
            {
                obj[_name] = true;
                _parent[departureHole].arrStoredBalls.push(obj);
                var _loc4 = Math.sqrt(_parent.sqr(obj.vX) + _parent.sqr(obj.vY));
                if (_loc4 < minEntranceSpeed)
                {
                    _loc4 = minEntranceSpeed;
                } // end if
                var _loc6 = _parent.horAzim(_x, _y, obj.x, obj.y);
                obj.vX = Math.cos(_loc6) * toHoleVelK * _loc4;
                obj.vY = -Math.sin(_loc6) * toHoleVelK * _loc4;
                obj.blnLockGravity = true;
                var _loc7 = _parent.gameInterval * _loc5 / (toHoleVelK * 0.800000 * _loc4);
                _global.setTimeout(this, "beginDecay", _loc7, obj);
            } // end if
        } // end if
    } // End of the function
    function beginDecay(obj)
    {
        _parent.addScore(this, activateScore * scoreMultiplier);
        if (blnTimeoutRelease)
        {
            _global.setTimeout(_parent[departureHole], "release", departureTimeout);
        } // end if
        obj.vX = obj.vX * 0.080000;
        obj.vY = obj.vY * 0.080000;
        obj.setMask(mcMask);
        var _loc4 = 1000 / _parent.frameRate;
        obj.decTimes = Math.floor(disappearanceDecayTime / _loc4);
        if (obj.decTimes == 0)
        {
            obj.decTimes = 1;
        } // end if
        obj.dT = 0;
        obj.place = arrStoredBalls.length;
        obj.onEnterFrame = function ()
        {
            dT = dT + 1;
            _alpha = 100 - dT / decTimes * 100;
            if (dT >= decTimes)
            {
                _alpha = 0;
                vX = 0;
                vY = 0;
                _x = -50;
                _y = -50;
                x = -100 + place * 20;
                y = -100;
                delete this.onEnterFrame;
            } // end if
        };
        _parent[_name + "Hit"](obj);
    } // End of the function
    function release()
    {
        var thisBall = arrStoredBalls.shift();
        trace (thisBall._name + " released");
        thisBall[_name] = true;
        thisBall.x = _x + random(20) / 100;
        thisBall.y = _y + random(20) / 100;
        thisBall.oldX = _x;
        thisBall.oldY = _y;
        thisBall.vX = 0.000030;
        thisBall.vY = 0.000030;
        var _loc2 = 1000 / _parent.frameRate;
        thisBall.decTimes = Math.floor(appearanceDecayTime / _loc2);
        if (thisBall.decTimes == 0)
        {
            thisBall.decTimes = 1;
        } // end if
        thisBall.dT = 0;
        if (blnUseLaunchVector)
        {
            thisBall.fvX = Math.sin(mcLaunchVector._rotation / 180 * 3.141593) * departureSpeed;
            thisBall.fvY = -Math.cos(mcLaunchVector._rotation / 180 * 3.141593) * departureSpeed;
        }
        else
        {
            thisBall.fvX = 0;
            thisBall.fvX = 0;
        } // end else if
        thisBall.onEnterFrame = function ()
        {
            dT = dT + 1;
            _alpha = dT / decTimes * 100;
            if (dT >= decTimes)
            {
                _alpha = 100;
                blnLockGravity = false;
                vX = thisBall.fvX;
                vY = thisBall.fvY;
                this.setMask(null);
                delete this.onEnterFrame;
            } // end if
        };
        _parent[_name + "Release"](thisBall);
    } // End of the function
    function reset(obj)
    {
        obj[_name] = false;
    } // End of the function
    function clearHole()
    {
        for (var _loc3 = 0; _loc3 < arrStoredBalls.length; ++_loc3)
        {
            for (var _loc2 = 0; _loc2 < _parent.arrBalls.length; ++_loc2)
            {
                if (_parent.arrBalls[_loc2] == arrStoredBalls[_loc3])
                {
                    arrStoredBalls[_loc3] = null;
                    arrStoredBalls.splice(_loc3, 1);
                    _parent.arrBalls[_loc2] = null;
                    _parent.arrBalls.splice(_loc2, 1);
                } // end if
            } // end of for
        } // end of for
    } // End of the function
    var blnInlet = true;
    var blnOutlet = true;
    var departureHole = " ";
    var blnTimeoutRelease = true;
    var departureTimeout = 2000;
    var departureSpeed = 2;
    var holeRadius = 10;
    var blnUseLaunchVector = true;
    var maxSpeed = 8;
    var appearanceDecayTime = 600;
    var disappearanceDecayTime = 400;
    var minEntranceSpeed = 0.200000;
    var blnCheck = true;
    var blnHitCheck = false;
    var toHoleVelK = 0.600000;
} // End of Class
#endinitclip
