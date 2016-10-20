// Action script...

// [Initial MovieClip Action of sprite 762]
#initclip 30
class CObstacle extends CComponent
{
    var arrObsX, arrObsY, arrObsPhant, arrObs2X, arrObs2Y, arrObsDist, arrSX, arrSY, arrSNX, arrSNY, arrReflectance, _parent, mcAnchor, localToGlobal, hitTest, globalToLocal, _name, getNextHighestDepth, createEmptyMovieClip, mcDumb, _xscale, _yscale, location, blnEnabled, _rotation, _x, _y, oldX, oldY, newX, newY, activateScore, scoreMultiplier, sound, constantSound, mcDoor, mcHitAnimation;
    function CObstacle()
    {
        super();
        arrObsX = new Array();
        arrObsY = new Array();
        arrObsPhant = new Array();
        arrObs2X = new Array();
        arrObs2Y = new Array();
        arrObsDist = new Array();
        arrSX = new Array();
        arrSY = new Array();
        arrSNX = new Array();
        arrSNY = new Array();
        arrReflectance = new Array();
        var _loc11;
        var _loc14;
        var _loc4;
        var _loc17;
        var _loc18;
        var _loc3;
        var _loc10 = null;
        var _loc24;
        var _loc23 = true;
        var _loc20 = false;
        _parent.arrComponents.push(this);
        _parent.arrComponentTypes.push("Obstacle");
        _parent.arrObstacles.push(this);
        anchorX = mcAnchor._x;
        anchorY = mcAnchor._y;
        var _loc21 = {x: anchorX, y: anchorY};
        var _loc31 = {x: 0, y: 0};
        var _loc32 = {x: 0, y: 0};
        this.localToGlobal(_loc21);
        for (var _loc4 = _loc21.x; this.hitTest(_loc4, _loc21.y, false); ++_loc4)
        {
        } // end of for
        _loc32.x = _loc4 + _parent.ballR + 1;
        for (var _loc4 = _loc21.x; this.hitTest(_loc4, _loc21.y, false); --_loc4)
        {
        } // end of for
        _loc31.x = _loc4 - _parent.ballR - 1;
        for (var _loc4 = _loc21.y; this.hitTest(_loc21.x, _loc4, false); ++_loc4)
        {
        } // end of for
        _loc32.y = _loc4 + _parent.ballR + 1;
        for (var _loc4 = _loc21.y; this.hitTest(_loc21.x, _loc4, false); --_loc4)
        {
        } // end of for
        _loc31.y = _loc4 - _parent.ballR - 1;
        this.globalToLocal(_loc31);
        this.globalToLocal(_loc32);
        var _loc33 = _name;
        mcAnchor.swapDepths(1000);
        mcAnchor.removeMovieClip();
        useTerminalNodes = false;
        for (var _loc3 in this)
        {
            if (typeof(this[_loc3]) == "movieclip" && (this[_loc3].mcTAnchor._alpha > 0 || this[_loc3].mcAnchor._alpha > 0))
            {
                if (this[_loc3].mcTAnchor._alpha > 0 && !useTerminalNodes)
                {
                    useTerminalNodes = true;
                    arrObsX[0] = this[_loc3]._x;
                    arrObsY[0] = this[_loc3]._y;
                    if (this[_loc3].mcNode._alpha > 0)
                    {
                        arrObsPhant[0] = true;
                    }
                    else
                    {
                        arrObsPhant[0] = false;
                    } // end else if
                    _loc17 = this[_loc3]._x;
                    _loc18 = this[_loc3]._y;
                    _loc14 = this[_loc3];
                } // end if
                ++nodeCnt;
            } // end if
            if (typeof(this[_loc3]) == "movieclip" && (Number(this[_loc3]._name.substr(0, 1)) < 10 || Number(this[_loc3]._name.substr(1, 2)) < 10))
            {
                useNumeration = true;
                break;
            } // end if
        } // end of for...in
        if (useNumeration)
        {
            _loc4 = 0;
            _loc20 = true;
            while (_loc20)
            {
                _loc20 = false;
                var _loc22;
                var _loc8;
                var _loc9;
                for (var _loc3 in this)
                {
                    if (typeof(this[_loc3]) == "movieclip" && (this[_loc3].mcAnchor._alpha > 0 || this[_loc3].mcTAnchor._alpha > 0 || this[_loc3].mcNode._alpha > 0))
                    {
                        if (Number(this[_loc3]._name.substr(0, 1)) < 10)
                        {
                            _loc9 = this[_loc3]._name;
                        }
                        else
                        {
                            _loc9 = this[_loc3]._name.substr(1, this[_loc3]._name.length - 1);
                        } // end else if
                        for (var _loc8 = 0; _loc8 < _loc9.length; ++_loc8)
                        {
                            if (_loc9.substr(_loc8, 1) == "_")
                            {
                                break;
                            } // end if
                        } // end of for
                        _loc22 = Number(_loc9.substr(0, _loc8));
                        if (_loc22 == _loc4)
                        {
                            arrObsX[_loc4] = this[_loc3]._x;
                            arrObsY[_loc4] = this[_loc3]._y;
                            if (this[_loc3].mcNode._alpha > 0)
                            {
                                arrObsPhant[_loc4] = true;
                            }
                            else
                            {
                                arrObsPhant[_loc4] = false;
                            } // end else if
                            this[_loc3].swapDepths(this.getNextHighestDepth());
                            this[_loc3].removeMovieClip();
                            if (_loc8 < _loc9.length)
                            {
                                var _loc7 = _loc9.substr(_loc8 + 1, _loc9.length - (_loc8 + 1));
                                for (var _loc6 = 0; _loc6 < _loc7.length; ++_loc6)
                                {
                                    if (_loc7.charAt(_loc6) == "_")
                                    {
                                        _loc7 = _loc7.substr(0, _loc6) + "." + _loc7.substr(_loc6 + 1, _loc7.length - (_loc6 + 1));
                                    } // end if
                                } // end of for
                                arrReflectance[_loc4] = Number(_loc7);
                            }
                            else
                            {
                                arrReflectance[_loc4] = 1;
                            } // end else if
                            _loc20 = true;
                        } // end if
                    } // end if
                } // end of for...in
                ++_loc4;
            } // end while
            arrObsX[arrObsX.length] = arrObsX[0];
            arrObsY[arrObsY.length] = arrObsY[0];
        }
        else
        {
            while (!_loc20)
            {
                _loc4 = 0;
                for (var _loc3 in this)
                {
                    if (typeof(this[_loc3]) == "movieclip" && (this[_loc3].mcAnchor._alpha > 0 || this[_loc3].mcTAnchor._alpha > 0 || this[_loc3].mcNode._alpha > 0))
                    {
                        if (_loc23 && !useTerminalNodes)
                        {
                            _loc23 = false;
                            arrObsX[0] = this[_loc3]._x;
                            arrObsY[0] = this[_loc3]._y;
                            if (this[_loc3].mcNode._alpha > 0)
                            {
                                arrObsPhant[0] = true;
                            }
                            else
                            {
                                arrObsPhant[0] = false;
                            } // end else if
                            _loc17 = this[_loc3]._x;
                            _loc18 = this[_loc3]._y;
                            _loc14 = this[_loc3];
                        }
                        else
                        {
                            if (arrObsX.length == 1 && useTerminalNodes && this[_loc3] == _loc14)
                            {
                                continue;
                            } // end if
                            if (_loc10 == null)
                            {
                                if (!(arrObsX.length < nodeCnt && this[_loc3] == _loc14) && !(arrObsX.length < nodeCnt - 1 && useTerminalNodes && this[_loc3].mcTAnchor._alpha > 0))
                                {
                                    _loc10 = _parent.sqr(this[_loc3]._x - _loc17) + _parent.sqr(this[_loc3]._y - _loc18);
                                    if (_loc10 == 0)
                                    {
                                        _loc10 = null;
                                    }
                                    else
                                    {
                                        _loc11 = this[_loc3];
                                    } // end else if
                                }
                                else
                                {
                                    var _loc26 = _loc4;
                                    var _loc27 = this[_loc3];
                                } // end else if
                            }
                            else
                            {
                                _loc24 = _parent.sqr(this[_loc3]._x - _loc17) + _parent.sqr(this[_loc3]._y - _loc18);
                                if (_loc24 < _loc10)
                                {
                                    if (!(arrObsX.length < nodeCnt && this[_loc3] == _loc14) && !(arrObsX.length < nodeCnt - 1 && useTerminalNodes && this[_loc3].mcTAnchor._alpha > 0))
                                    {
                                        _loc11 = this[_loc3];
                                        _loc10 = _loc24;
                                    } // end if
                                } // end if
                            } // end else if
                        } // end else if
                        ++_loc4;
                    } // end if
                } // end of for...in
                if (_loc4 == 0)
                {
                    trace ("Coincidence failed in obstacle " + _name);
                    break;
                } // end if
                if (_loc11 == _loc14 || useTerminalNodes && _loc11.mcTAnchor._alpha > 0)
                {
                    _loc20 = true;
                } // end if
                arrObsX[arrObsX.length] = _loc11._x;
                arrObsY[arrObsY.length] = _loc11._y;
                if (_loc11.mcNode._alpha > 0)
                {
                    arrObsPhant[arrObsPhant.length] = true;
                }
                else
                {
                    arrObsPhant[arrObsPhant.length] = false;
                } // end else if
                _loc17 = _loc11._x;
                _loc18 = _loc11._y;
                _loc11.swapDepths(2000);
                _loc11.removeMovieClip();
                arrObsDist[arrObsDist.length] = Math.sqrt(_loc10);
                _loc10 = null;
            } // end while
        } // end else if
        if (useTerminalNodes)
        {
            _loc14.swapDepths(2000);
            _loc14.removeMovieClip();
            arrObsX.push(arrObsX[0]);
            arrObsY.push(arrObsY[0]);
        } // end if
        this.createEmptyMovieClip("mcDumb", this.getNextHighestDepth());
        mcDumb._x = _loc31.x;
        mcDumb._y = _loc31.y;
        mcDumb._visible = false;
        mcDumb.lineStyle(1);
        mcDumb.beginFill(16711680, 100);
        mcDumb.moveTo(0, 0);
        mcDumb.lineTo(_loc32.x - _loc31.x, 0);
        mcDumb.lineTo(_loc32.x - _loc31.x, _loc32.y - _loc31.y);
        mcDumb.lineTo(0, _loc32.y - _loc31.y);
        mcDumb.lineTo(0, 0);
        mcDumb.endFill();
        var _loc25;
        var _loc15;
        var _loc29;
        var _loc30;
        arrObsX[arrObsX.length] = arrObsX[1];
        arrObsY[arrObsY.length] = arrObsY[1];
        for (var _loc4 = 1; _loc4 < arrObsX.length - 1; ++_loc4)
        {
            _loc29 = _parent.horAzim(arrObsX[_loc4 - 1], arrObsY[_loc4 - 1], arrObsX[_loc4], arrObsY[_loc4]);
            _loc25 = _parent.horAzim(arrObsX[_loc4 + 1], arrObsY[_loc4 + 1], arrObsX[_loc4], arrObsY[_loc4]);
            if (useTerminalNodes && (_loc4 == arrObsX.length - 2 || _loc4 == arrObsX.length - 3))
            {
                if (_loc4 == arrObsX.length - 2)
                {
                    _loc15 = _loc25 + 1.570796;
                } // end if
                if (_loc4 == arrObsX.length - 3)
                {
                    _loc15 = _loc29 + 1.570796;
                } // end if
                _loc24 = _parent.ballR;
            }
            else
            {
                _loc15 = (_loc25 + _loc29) / 2;
                _loc24 = Math.abs(_parent.ballR / Math.sin(Math.abs(_loc15 - _loc25)));
            } // end else if
            _loc30 = _parent.horAzim(anchorX, anchorY, arrObsX[_loc4], arrObsY[_loc4]);
            var _loc28 = Math.abs(_loc30 - _loc15);
            if (_loc28 < 1.570796 || _loc28 > 4.712389)
            {
                _loc15 = _loc15 + 3.141593;
                _loc15 = _loc15 % 6.283185;
            } // end if
            arrObs2X[_loc4] = arrObsX[_loc4] + _loc24 * Math.cos(_loc15) / _xscale * 100 + random(10000) / 200000 - 0.025000;
            arrObs2Y[_loc4] = arrObsY[_loc4] - _loc24 * Math.sin(_loc15) / _yscale * 100 + random(10000) / 200000 - 0.025000;
        } // end of for
        arrObs2X[0] = arrObs2X[arrObs2X.length - 1];
        arrObs2X.pop();
        arrObs2Y[0] = arrObs2Y[arrObs2Y.length - 1];
        arrObs2Y.pop();
        var _loc5;
        var _loc19;
        var _loc13;
        var _loc12;
        var _loc16;
        _loc19 = arrObs2X.length;
        for (var _loc4 = 0; _loc4 < _loc19; ++_loc4)
        {
            arrSX[_loc4] = arrObs2X[_loc4];
            arrSY[_loc4] = arrObs2Y[_loc4];
            arrSNX[_loc4] = _loc4;
            arrSNY[_loc4] = _loc4;
        } // end of for
        for (var _loc4 = 0; _loc4 < _loc19 - 1; ++_loc4)
        {
            _loc13 = arrSX[_loc4];
            _loc12 = _loc4;
            for (var _loc5 = _loc4 + 1; _loc5 < _loc19; ++_loc5)
            {
                if (arrSX[_loc5] < _loc13)
                {
                    _loc13 = arrSX[_loc5];
                    _loc12 = _loc5;
                } // end if
            } // end of for
            _loc16 = arrSX[_loc4];
            arrSX[_loc4] = _loc13;
            arrSX[_loc12] = _loc16;
            _loc16 = arrSNX[_loc4];
            arrSNX[_loc4] = arrSNX[_loc12];
            arrSNX[_loc12] = _loc16;
        } // end of for
        for (var _loc4 = 0; _loc4 < _loc19 - 1; ++_loc4)
        {
            _loc13 = arrSY[_loc4];
            _loc12 = _loc4;
            for (var _loc5 = _loc4 + 1; _loc5 < _loc19; ++_loc5)
            {
                if (arrSY[_loc5] < _loc13)
                {
                    _loc13 = arrSY[_loc5];
                    _loc12 = _loc5;
                } // end if
            } // end of for
            _loc16 = arrSY[_loc4];
            arrSY[_loc4] = _loc13;
            arrSY[_loc12] = _loc16;
            _loc16 = arrSNY[_loc4];
            arrSNY[_loc4] = arrSNY[_loc12];
            arrSNY[_loc12] = _loc16;
        } // end of for
    } // End of the function
    function check(obj)
    {
        var _loc20;
        var _loc18;
        var _loc21;
        var _loc2;
        var _loc25;
        var _loc23;
        var _loc22;
        var _loc17;
        var _loc24;
        var _loc19;
        var _loc3;
        if (obj.location != location || !blnEnabled)
        {
            return (false);
        } // end if
        rotAng = _rotation * 3.141593 / 180;
        rotAngSin = Math.sin(rotAng);
        rotAngCos = Math.cos(rotAng);
        var _loc12 = {x: obj.oldX, y: obj.oldY};
        if (_parent.blnNudgeStart)
        {
            trace ("nudge correct");
            if (_parent.blnLeftNudge)
            {
                _loc12.x = _loc12.x - _parent.XNudgeAmp;
            }
            else
            {
                _loc12.x = _loc12.x + _parent.XNudgeAmp;
            } // end else if
            _loc12.y = _loc12.y - _parent.YNudgeAmp;
        } // end if
        oldX = (obj.oldX - _x) / scaleFactor * rotAngCos + (obj.oldY - _y) / scaleFactor * rotAngSin;
        oldY = (obj.oldY - _y) / scaleFactor * rotAngCos - (obj.oldX - _x) / scaleFactor * rotAngSin;
        _loc12.x = obj.x;
        _loc12.y = obj.y;
        if (_parent.blnNudgeStart)
        {
            trace ("nudge correct");
            if (_parent.blnLeftNudge)
            {
                _loc12.x = _loc12.x - _parent.XNudgeAmp;
            }
            else
            {
                _loc12.x = _loc12.x + _parent.XNudgeAmp;
            } // end else if
            _loc12.y = _loc12.y - _parent.YNudgeAmp;
        } // end if
        newX = (obj.x - _x) / scaleFactor * rotAngCos + (obj.y - _y) / scaleFactor * rotAngSin;
        newY = (obj.y - _y) / scaleFactor * rotAngCos - (obj.x - _x) / scaleFactor * rotAngSin;
        if (oldX == newX)
        {
            newX = oldX + 0.700000 * obj.vX;
        } // end if
        if (oldY == newY)
        {
            newY = oldY + 0.700000 * obj.vY;
        } // end if
        var _loc6;
        var _loc11;
        var _loc13 = new Array();
        var _loc15 = new Array();
        var _loc4;
        _loc4 = _parent.sqr(arrObs2X[0] - oldX) + _parent.sqr(arrObs2Y[0] - oldY);
        var _loc8 = 0;
        for (var _loc2 = 1; _loc2 < arrObs2X.length; ++_loc2)
        {
            _loc3 = _parent.sqr(arrObs2X[_loc2] - oldX) + _parent.sqr(arrObs2Y[_loc2] - oldY);
            if (_loc3 < _loc4)
            {
                _loc4 = _loc3;
                _loc8 = _loc2;
            } // end if
        } // end of for
        _loc6 = _loc8;
        _loc4 = _parent.sqr(arrObs2X[0] - newX) + _parent.sqr(arrObs2Y[0] - newY);
        _loc8 = 0;
        for (var _loc2 = 1; _loc2 < arrObs2X.length; ++_loc2)
        {
            _loc3 = _parent.sqr(arrObs2X[_loc2] - newX) + _parent.sqr(arrObs2Y[_loc2] - newY);
            if (_loc3 < _loc4)
            {
                _loc4 = _loc3;
                _loc8 = _loc2;
            } // end if
        } // end of for
        _loc11 = _loc8;
        var _loc9 = _loc11 - 1;
        if (_loc9 < 0)
        {
            _loc9 = arrObs2X.length - 1;
        } // end if
        var _loc10 = _loc11 + 1;
        if (_loc10 > arrObs2X.length - 1)
        {
            _loc10 = 0;
        } // end if
        var _loc5 = new Array(_loc9, _loc11, _loc10, _loc11, _loc9);
        if (!(useTerminalNodes && _loc11 == 0))
        {
            if (this.reflect(_loc9, _loc11, obj))
            {
                return (true);
            } // end if
        } // end if
        if (!(useTerminalNodes && _loc11 == arrObs2X.length - 1))
        {
            if (this.reflect(_loc10, _loc11, obj))
            {
                return (true);
            } // end if
        } // end if
        _loc9 = _loc6 - 1;
        if (_loc9 < 0)
        {
            _loc9 = arrObs2X.length - 1;
        } // end if
        _loc10 = _loc6 + 1;
        if (_loc10 > arrObs2X.length - 1)
        {
            _loc10 = 0;
        } // end if
        if (!(useTerminalNodes && _loc6 == 0))
        {
            for (var _loc2 = 0; _loc2 < 4; ++_loc2)
            {
                if (_loc9 == _loc5[_loc2] && _loc6 == _loc5[_loc2 + 1])
                {
                    break;
                } // end if
            } // end of for
            if (_loc2 == 4)
            {
                if (this.reflect(_loc9, _loc6, obj))
                {
                    return (true);
                } // end if
            } // end if
        } // end if
        if (!(useTerminalNodes && _loc6 == arrObs2X.length - 1))
        {
            for (var _loc2 = 0; _loc2 < 4; ++_loc2)
            {
                if (_loc10 == _loc5[_loc2] && _loc6 == _loc5[_loc2 + 1])
                {
                    break;
                } // end if
            } // end of for
            if (_loc2 == 4)
            {
                if (this.reflect(_loc10, _loc6, obj))
                {
                    return (true);
                } // end if
            } // end if
        } // end if
        return (false);
    } // End of the function
    function reflect(v1, v2, obj)
    {
        if (arrObsPhant[v1] || arrObsPhant[v2])
        {
            return (false);
        } // end if
        if (arrObs2X[v1] < arrObs2X[v2])
        {
            var _loc12 = arrObs2X[v1];
            var _loc17 = arrObs2Y[v1];
            var _loc13 = arrObs2X[v2];
            var _loc21 = arrObs2Y[v2];
        }
        else
        {
            _loc12 = arrObs2X[v2];
            _loc17 = arrObs2Y[v2];
            _loc13 = arrObs2X[v1];
            _loc21 = arrObs2Y[v1];
        } // end else if
        if (oldX < newX)
        {
            var _loc22 = oldX;
            var _loc27 = oldY;
            var _loc24 = newX;
            var _loc33 = newY;
        }
        else
        {
            _loc22 = newX;
            _loc27 = newY;
            _loc24 = oldX;
            _loc33 = oldY;
        } // end else if
        var _loc20 = (_loc21 - _loc17) / (_loc13 - _loc12);
        var _loc30 = _loc17 - _loc12 * _loc20;
        var _loc32 = (_loc33 - _loc27) / (_loc24 - _loc22);
        var _loc35 = _loc27 - _loc22 * _loc32;
        var _loc3 = (_loc35 - _loc30) / (_loc20 - _loc32);
        var _loc7 = _loc20 * _loc3 + _loc30;
        var _loc8 = _parent.horAzim(_loc13, _loc21, _loc12, _loc17);
        var _loc11 = _parent.horAzim(obj.vX, obj.vY, 0, 0) - _loc8 + rotAng;
        var _loc41 = Math.sin(_loc11);
        if (_loc12 <= _loc3 && _loc13 >= _loc3 && _loc22 - 0.050000 <= _loc3 && _loc24 + 0.050000 >= _loc3)
        {
            if (arrObs2Y[v1] < arrObs2Y[v2])
            {
                var _loc38 = arrObs2Y[v1];
                var _loc34 = arrObs2Y[v2];
            }
            else
            {
                _loc38 = arrObs2Y[v2];
                _loc34 = arrObs2Y[v1];
            } // end else if
            if (oldY < newY)
            {
                var _loc37 = oldY;
                var _loc39 = newY;
            }
            else
            {
                _loc37 = newY;
                _loc39 = oldY;
            } // end else if
            if (_loc38 <= _loc7 && _loc34 >= _loc7 && _loc37 - 0.050000 <= _loc7 && _loc39 + 0.050000 >= _loc7)
            {
                _loc8 = _parent.horAzim(_loc13, _loc21, _loc12, _loc17);
                var _loc18 = _parent.horAzim(anchorX, anchorY, _loc3, _loc7) - _loc8;
                var _loc2 = Math.sqrt(_parent.sqr(anchorX - _loc3) + _parent.sqr(anchorY - _loc7));
                var _loc40 = _loc2 * Math.cos(_loc18);
                var _loc29 = _loc2 * Math.sin(_loc18);
                _loc18 = _parent.horAzim(oldX, oldY, _loc3, _loc7) - _loc8;
                _loc2 = Math.sqrt(_parent.sqr(oldX - _loc3) + _parent.sqr(oldY - _loc7));
                var _loc36 = _loc2 * Math.sin(_loc18);
                _loc11 = _parent.horAzim(obj.vX, obj.vY, 0, 0) - _loc8 + rotAng;
                _loc41 = Math.sin(_loc11);
                if (_loc29 * _loc36 <= 0)
                {
                    var _loc15 = 1;
                    if (useNumeration)
                    {
                        if (v1 == v2 + 1)
                        {
                            _loc15 = arrReflectance[v2];
                        }
                        else if (v2 == v1 + 1)
                        {
                            _loc15 = arrReflectance[v1];
                        }
                        else
                        {
                            _loc15 = arrReflectance[v2 > v1 ? (v2) : (v1)];
                        } // end else if
                    } // end else if
                    _loc2 = Math.sqrt(_parent.sqr(obj.vX) + _parent.sqr(obj.vY));
                    var _loc23 = _loc2 * Math.cos(_loc11);
                    var _loc14 = _loc2 * Math.sin(_loc11);
                    if (Math.abs(_loc14) > ySpeedThreshold)
                    {
                        _parent.addScore(this, activateScore * scoreMultiplier);
                    } // end if
                    _loc14 = _loc14 * (-YReflectance * _loc15);
                    _loc23 = _loc23 * XReflectance;
                    _loc11 = _parent.horAzim(_loc23, -_loc14, 0, 0) + _loc8 - rotAng;
                    _loc2 = Math.sqrt(_parent.sqr(_loc23) + _parent.sqr(_loc14));
                    obj.vX = _loc2 * Math.cos(_loc11);
                    obj.vY = -_loc2 * Math.sin(_loc11);
                    var _loc19 = _parent.horAzim(newX, newY, _loc3, _loc7) - _loc8;
                    _loc2 = Math.sqrt(_parent.sqr(newX - _loc3) + _parent.sqr(newY - _loc7));
                    var _loc10 = _loc2 * Math.cos(_loc19);
                    var _loc16 = 0.130000;
                    if (_loc16 * _loc29 > 0)
                    {
                        _loc16 = _loc16 * -1;
                    } // end if
                    var _loc28 = (_loc13 - _loc3) / Math.cos(_loc8);
                    var _loc31 = (_loc12 - _loc3) / Math.cos(_loc8);
                    if (_loc10 < _loc31)
                    {
                        _loc10 = _loc31;
                    } // end if
                    if (_loc10 > _loc28)
                    {
                        _loc10 = _loc28;
                    } // end if
                    _loc19 = _parent.horAzim(_loc10, -_loc16, 0, 0) + _loc8;
                    _loc2 = Math.sqrt(_parent.sqr(_loc10) + _parent.sqr(_loc16));
                    var _loc25 = _loc2 * Math.cos(_loc19) + _loc3;
                    var _loc26 = _loc7 - _loc2 * Math.sin(_loc19);
                    obj.x = _x + _loc25 * scaleFactor * rotAngCos - _loc26 * scaleFactor * rotAngSin;
                    obj.y = _y + _loc25 * scaleFactor * rotAngSin + _loc26 * scaleFactor * rotAngCos;
                    var _loc9 = _loc14 / _parent.absMaxSpeed * 250;
                    _loc9 = _loc9 > 100 ? (100) : (_loc9);
                    if (sound == undefined)
                    {
                        if (constantSound)
                        {
                            _parent.deffaultSound.start(0, 1);
                        }
                        else if (_loc9 > 4)
                        {
                            _parent.playSound(_parent.deffaultSound, 0, 1, _loc9);
                        } // end else if
                    }
                    else if (constantSound)
                    {
                        sound.start(0, 1);
                    }
                    else if (_loc9 > 4)
                    {
                        _parent.playSound(sound, 0, 1, _loc9);
                    } // end else if
                    if (_parent.blnNudgeStart)
                    {
                        if (_parent.blnLeftNudge)
                        {
                            obj.x = obj.x + _parent.XNudgeAmp;
                        }
                        else
                        {
                            obj.x = obj.x - _parent.XNudgeAmp;
                        } // end else if
                        obj.y = obj.y + _parent.YNudgeAmp;
                    } // end if
                    return (true);
                }
                else
                {
                    mcDoor.play();
                } // end if
            } // end if
        } // end else if
        return (false);
    } // End of the function
    function activate(obj)
    {
        _parent[_name + "Hit"](obj);
        mcHitAnimation.play();
    } // End of the function
    var YReflectance = 0.700000;
    var XReflectance = 1;
    var ySpeedThreshold = 0.700000;
    var blnCheck = true;
    var blnHitCheck = false;
    var rotAngSin = null;
    var rotAngCos = null;
    var scaleFactor = this._xscale / 100;
    var rotAng = null;
    var anchorX = null;
    var anchorY = null;
    var nodeCnt = 0;
    var useTerminalNodes = false;
    var useNumeration = false;
    var blnAuxNodeCheck = false;
} // End of Class
#endinitclip
