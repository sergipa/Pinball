// Action script...

// [Initial MovieClip Action of sprite 764]
#initclip 32
class CFlipper extends CObstacle
{
    var _parent, mcFlipperAnimation, _rotation, _y, _x, _name;
    function CFlipper()
    {
        super();
        _parent.arrComponents.pop();
        _parent.arrComponentTypes.pop();
        _parent.arrObstacles.pop();
        _parent.arrComponents.push(this);
        _parent.arrComponentTypes.push("Flipper");
        _parent.arrFlippers.push(this);
        amplitudeRad = amplitude / 180 * 3.141593;
        dx = (_parent.ballR + pivotRadius) / Math.sin(amplitudeRad);
    } // End of the function
    function flip()
    {
        mcFlipperAnimation.gotoAndStop(2);
        for (var _loc3 = 0; _loc3 < _parent.arrBalls.length; ++_loc3)
        {
            var _loc2 = _parent.arrBalls[_loc3];
            if (mcFlipperAnimation.hitTest(_loc2.x, _loc2.y, true))
            {
                _loc2._visible = false;
            } // end if
        } // end of for
        function onEnterFrame()
        {
            if (blnFlipped)
            {
                this.calcFlip();
                if (blnLeft)
                {
                    _rotation = -2 * amplitude;
                    mcFlipperAnimation._rotation = 2 * amplitude;
                }
                else
                {
                    _rotation = 2 * amplitude;
                    mcFlipperAnimation._rotation = 180 - 2 * amplitude;
                } // end else if
                mcFlipperAnimation.gotoAndStop(3);
                delete this.onEnterFrame;
            }
            else
            {
                blnFlipped = true;
            } // end else if
        } // End of the function
    } // End of the function
    function calcFlip()
    {
        lf = blnLeft ? (-1) : (1);
        for (var _loc6 = 0; _loc6 < _parent.arrBalls.length; ++_loc6)
        {
            var _loc2 = _parent.arrBalls[_loc6];
            _loc2._visible = true;
            if (this.flipAreaCheck(_loc2, true))
            {
                var _loc3 = _parent.horAzim(_loc2.x, _loc2.y, _x, _y);
                var _loc5 = 1.570796;
                if (r - dx < 3 * _parent.ballR)
                {
                    _loc5 = _loc5 * Math.sqrt((r - dx) / (3 * _parent.ballR));
                } // end if
                trace ("dirInc  " + _loc5);
                if (blnLeft)
                {
                    _loc3 = _loc3 + _loc5;
                    _loc3 = _loc3 + deviation * (1 - (r - dx) / flipperLength) - outwardCorrection;
                    if (_loc3 >= 6.283185)
                    {
                        _loc3 = _loc3 - 6.283185;
                    } // end if
                }
                else
                {
                    _loc3 = _loc3 - _loc5;
                    _loc3 = _loc3 - deviation * (1 - (r - dx) / flipperLength) + outwardCorrection;
                } // end else if
                _loc2.vX = Math.cos(_loc3) * flipSpeed * r / flipperLength;
                _loc2.vY = -Math.sin(_loc3) * flipSpeed * r / flipperLength;
                var _loc4 = Math.abs(0.700000 * (r - _parent.ballR - pivotRadius) / flipperLength);
                var _loc8 = Math.cos(_loc3);
                var _loc7 = Math.sin(_loc3);
                while (this.flipAreaCheck(_loc2, true))
                {
                    _loc2.x = _loc2.x + _loc4 * _loc8;
                    _loc2.y = _loc2.y - _loc4 * _loc7;
                } // end while
                _loc2.oldX = _loc2.x;
                _loc2.oldY = _loc2.y;
                _parent[_name + "FlipHit"](_loc2);
            } // end if
        } // end of for
        blnFlipCalculated = true;
        _parent[_name + "Flip"]();
    } // End of the function
    function release()
    {
        mcFlipperAnimation.gotoAndStop(2);
        for (var _loc3 = 0; _loc3 < _parent.arrBalls.length; ++_loc3)
        {
            var _loc2 = _parent.arrBalls[_loc3];
            if (mcFlipperAnimation.hitTest(_loc2.x, _loc2.y, true) && blnFlipCalculated)
            {
                _loc2._visible = false;
                continue;
            } // end if
            _loc2._visible = true;
        } // end of for
        function onEnterFrame()
        {
            if (!blnFlipped)
            {
                this.calcRelease();
                _rotation = 0;
                mcFlipperAnimation._rotation = 180 * (1 - Number(blnLeft));
                mcFlipperAnimation.gotoAndStop(1);
                delete this.onEnterFrame;
            }
            else
            {
                blnFlipped = false;
            } // end else if
        } // End of the function
    } // End of the function
    function calcRelease()
    {
        if (this.blnFlipCalculated)
        {
            this.blnFlipCalculated = false;
        }
        else
        {
            return;
        } // end else if
        this.lf = this.blnLeft ? (-1) : (1);
        var i = 1;
        while (i <= this._parent.ballCnt)
        {
            var thisBall = eval("mcBall" + i);
            thisBall._visible = true;
            if (this.flipAreaCheck(thisBall, false))
            {
                var newDir = this._parent.horAzim(thisBall.x, thisBall.y, this._x, this._y);
                if (this.blnLeft)
                {
                    newDir = newDir - 1.570796;
                    newDir = newDir - this.deviation * (1 - (this.r - this.dx) / this.flipperLength) + this.outwardCorrection;
                    if (newDir >= 6.283185)
                    {
                        newDir = newDir - 6.283185;
                    } // end if
                }
                else
                {
                    newDir = newDir + 1.570796;
                    newDir = newDir + this.deviation * (1 - (this.r - this.dx) / this.flipperLength) - this.outwardCorrection;
                } // end else if
                thisBall.vX = Math.cos(newDir) * this.flipSpeed * this.r / this.flipperLength;
                thisBall.vY = -Math.sin(newDir) * this.flipSpeed * this.r / this.flipperLength;
                var dk = Math.abs(0.700000 * (this.r - this._parent.ballR - this.pivotRadius) / this.flipperLength);
                var vNX = Math.cos(newDir);
                var vNY = Math.sin(newDir);
                while (this.flipAreaCheck(thisBall, false))
                {
                    thisBall.x = thisBall.x + dk * vNX;
                    thisBall.y = thisBall.y - dk * vNY;
                } // end while
                thisBall.oldX = thisBall.x;
                thisBall.oldY = thisBall.y;
                this._parent[this._name + "ReleaseHit"](thisBall);
            } // end if
            ++i;
        } // end while
        this._parent[this._name + "Release"]();
    } // End of the function
    function flipAreaCheck(thisBall, blnUp)
    {
        var _loc3 = thisBall.x;
        var _loc2 = thisBall.y;
        r = Math.sqrt(_parent.sqr(_x + lf * dx - _loc3) + _parent.sqr(_y - _loc2));
        if (r <= flipperLength + _parent.ballR * 0.800000 + dx)
        {
            var _loc5;
            var _loc4;
            _loc5 = _x + lf * dx;
            if (blnUp)
            {
                _loc4 = _y - pivotRadius * Math.sin(amplitudeRad);
            }
            else
            {
                _loc4 = _y + 3 * pivotRadius * Math.sin(amplitudeRad);
            } // end else if
            alpha = _parent.horAzim(_loc3, _loc2, _loc5, _loc4);
            beta = _parent.horAzim(_loc3, _loc2, _x, _y);
            if (blnUp)
            {
                beta = beta + amplitudeRad;
            }
            else
            {
                beta = beta - amplitudeRad;
            } // end else if
            if (blnLeft && (beta < 1.570796 + amplitudeRad / 2 || beta > 4.712389) || !blnLeft && (beta > 1.570796 - amplitudeRad / 2 && beta < 4.712389))
            {
                if (blnLeft && (alpha < amplitudeRad || alpha > 6.283185 - amplitudeRad) || !blnLeft && alpha > 3.141593 - amplitudeRad && alpha < 3.141593 + amplitudeRad)
                {
                    return (true);
                } // end if
            } // end if
            return (false);
        } // end if
    } // End of the function
    var deviation = 0.157080;
    var amplitude = 27;
    var flipperLength = 47;
    var blnLeft = false;
    var flipSpeed = 9;
    var pivotRadius = 7;
    var outwardCorrection = 0.261799;
    var blnFlipped = false;
    var blnFlipCalculated = false;
    var toFlip = false;
    var toRelease = false;
    var dx = null;
    var lf = null;
    var r = null;
    var alpha = null;
    var beta = null;
    var amplitudeRad = null;
} // End of Class
#endinitclip
