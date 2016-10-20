// Action script...

// [Initial MovieClip Action of sprite 766]
#initclip 34
class CSpinner extends CComponent
{
    var _parent, mcCheckArea, mcSpinAnimation, activateScore, scoreMultiplier, _name;
    function CSpinner()
    {
        super();
        _parent.arrComponents.push(this);
        _parent.arrComponentTypes.push("Spinner");
        _parent.arrSaucers.push(this);
        mcCheckArea._alpha = 0;
    } // End of the function
    function activate(thisBall)
    {
        if (!blnSpinning)
        {
            var _loc4 = _parent.horAzim(thisBall.vX, thisBall.vY, 0, 0);
            var _loc5 = Math.sqrt(_parent.sqr(thisBall.vX) + _parent.sqr(thisBall.vY));
            spinSpeed = 100 / Math.abs(agility * _loc5 * Math.sin(_loc4 + mcSpinAnimation._rotation));
            decay = 1;
            blnSpinning = true;
            blnDoSpin = true;
            _parent.addScore(this, activateScore * scoreMultiplier);
            if (_loc4 + mcSpinAnimation._rotation > 0 && _loc4 + mcSpinAnimation._rotation < 3.141593)
            {
                blnSpinDown = false;
                _global.setTimeout(this, "spinUp", Math.floor(spinSpeed / decay));
            }
            else
            {
                blnSpinDown = true;
                _global.setTimeout(this, "spinDown", Math.floor(spinSpeed / decay));
            } // end else if
            _parent[_name + "Hit"](thisBall);
        } // end if
    } // End of the function
    function reset()
    {
        blnSpinning = false;
    } // End of the function
    function spinUp()
    {
        if (blnSpinDown)
        {
            return;
        } // end if
        var _loc3 = Math.floor(spinSpeed / decay);
        var _loc4;
        if (_loc3 < 100)
        {
            _loc4 = true;
        }
        else
        {
            _loc4 = false;
        } // end else if
        if (!_loc4 && mcSpinAnimation._currentframe > 1 || _loc4 && mcSpinAnimation._currentframe > slowAnimFrames)
        {
            mcSpinAnimation.gotoAndStop(mcSpinAnimation._currentframe - 1);
        }
        else
        {
            _parent.addScore(this, rotationScore * scoreMultiplier);
            if (_loc3 > 300)
            {
                _parent[_name + "Stop"]();
                blnSpinning = false;
                blnDoSpin = false;
                return;
            } // end if
            if (_loc4)
            {
                mcSpinAnimation.gotoAndStop(mcSpinAnimation._totalframes);
            }
            else
            {
                mcSpinAnimation.gotoAndStop(slowAnimFrames);
            } // end else if
        } // end else if
        decay = decay - 0.030000 * decaySpeed;
        if (decay < 0.020000)
        {
            decay = 0.020000;
        } // end if
        if (_loc3 > 400)
        {
            _loc3 = 400;
        } // end if
        if (blnDoSpin)
        {
            _global.setTimeout(this, "spinUp", _loc3);
        } // end if
        updateAfterEvent();
    } // End of the function
    function spinDown()
    {
        if (!blnSpinDown)
        {
            return;
        } // end if
        var _loc3 = Math.floor(spinSpeed / decay);
        var _loc4;
        if (_loc3 < 100)
        {
            _loc4 = true;
        }
        else
        {
            _loc4 = false;
        } // end else if
        if (!_loc4 && mcSpinAnimation._currentframe < slowAnimFrames || _loc4 && mcSpinAnimation._currentframe < mcSpinAnimation._totalframes)
        {
            mcSpinAnimation.gotoAndStop(mcSpinAnimation._currentframe + 1);
        }
        else
        {
            _parent.addScore(this, rotationScore * scoreMultiplier);
            if (_loc4)
            {
                mcSpinAnimation.gotoAndStop(slowAnimFrames + 1);
            }
            else
            {
                mcSpinAnimation.gotoAndStop(1);
            } // end else if
            if (_loc3 > 300)
            {
                _parent[_name + "Stop"]();
                blnSpinning = false;
                blnDoSpin = false;
                return;
            } // end if
        } // end else if
        decay = decay - 0.030000 * decaySpeed;
        if (decay < 0.020000)
        {
            decay = 0.020000;
        } // end if
        if (_loc3 > 400)
        {
            _loc3 = 400;
        } // end if
        if (blnDoSpin)
        {
            _global.setTimeout(this, "spinDown", _loc3);
        } // end if
        updateAfterEvent();
    } // End of the function
    var agility = 0.400000;
    var slowAnimFrames = 9;
    var decaySpeed = 1;
    var rotationScore = 1;
    var spinSpeed = null;
    var decay = 1;
    var blnSpinning = false;
    var blnSpinDown = false;
    var blnDoSpin = false;
    var blnEnabled = true;
    var blnCheck = true;
    var blnHitCheck = true;
} // End of Class
#endinitclip
