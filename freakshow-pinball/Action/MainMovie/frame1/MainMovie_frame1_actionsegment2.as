// Action script...

function gameInit()
{
    mainCalls = 0;
    score = 0;
    this.onEnterFrame = function ()
    {
        if (!this.blnPause)
        {
            this.main();
            this.main();
            processRollSounds();
        } // end if
    };
} // End of the function
function moveBall(obj)
{
    if (!obj.blnLockGravity)
    {
        obj.vY = obj.vY + gravity;
    } // end if
    if (!obj.blnLockMovement)
    {
        obj.oldX = obj.x;
        obj.oldY = obj.y;
        obj.x = obj.x + obj.vX;
        obj.y = obj.y + obj.vY;
        var _loc2 = Math.sqrt(sqr(obj.vX) + sqr(obj.vY));
        if (_loc2 > absMaxSpeed)
        {
            var _loc3 = absMaxSpeed / _loc2;
            obj.vX = obj.vX * _loc3;
            obj.vY = obj.vY * _loc3;
        }
        else if (_loc2 > startSlowingAt)
        {
            var _loc4 = slowingAccel * (_loc2 - startSlowingAt) / slowHalfInt;
            _loc3 = (_loc2 - _loc4) / _loc2;
            obj.vX = obj.vX * _loc3;
            obj.vY = obj.vY * _loc3;
        } // end if
    } // end else if
} // End of the function
function startNudging()
{
    trace ("START NUDGE");
    nudgeTurnsA = 1;
    if (blnNudgeStart)
    {
        _root._y = _root._y - YNudgeAmp;
        if (blnLeftNudge)
        {
            _root._x = _root._x - XNudgeAmp;
        }
        else
        {
            _root._x = _root._x + XNudgeAmp;
        } // end else if
    }
    else
    {
        _root._y = _root._y + YNudgeAmp;
        if (blnLeftNudge)
        {
            _root._x = _root._x + XNudgeAmp;
        }
        else
        {
            _root._x = _root._x - XNudgeAmp;
        } // end else if
    } // end else if
    for (var _loc2 = 0; _loc2 < arrBalls.length; ++_loc2)
    {
        if (blnNudgeStart)
        {
            if (blnLeftNudge)
            {
                arrBalls[_loc2].vX = arrBalls[_loc2].vX + XNudgeAmp / nudgeTurns;
            }
            else
            {
                arrBalls[_loc2].vX = arrBalls[_loc2].vX - XNudgeAmp / nudgeTurns;
            } // end else if
            arrBalls[_loc2].vY = arrBalls[_loc2].vY + YNudgeAmp / nudgeTurns;
            continue;
        } // end if
        if (blnLeftNudge)
        {
            arrBalls[_loc2].vX = arrBalls[_loc2].vX - XNudgeAmp / nudgeTurns;
        }
        else
        {
            arrBalls[_loc2].vX = arrBalls[_loc2].vX + XNudgeAmp / nudgeTurns;
        } // end else if
        arrBalls[_loc2].vY = arrBalls[_loc2].vY - YNudgeAmp / nudgeTurns;
    } // end of for
} // End of the function
function stopNudging()
{
    trace ("STOP NUDGE");
    if (nudgeTurnsA > 0)
    {
        for (var _loc1 = 0; _loc1 < arrBalls.length; ++_loc1)
        {
            if (blnNudgeStart)
            {
                arrBalls[_loc1].vY = arrBalls[_loc1].vY - YNudgeAmp / nudgeTurns;
                if (blnLeftNudge)
                {
                    arrBalls[_loc1].vX = arrBalls[_loc1].vX - XNudgeAmp / nudgeTurns;
                }
                else
                {
                    arrBalls[_loc1].vX = arrBalls[_loc1].vX + XNudgeAmp / nudgeTurns;
                } // end else if
                continue;
            } // end if
            arrBalls[_loc1].vY = arrBalls[_loc1].vY + YNudgeAmp / nudgeTurns;
            if (blnLeftNudge)
            {
                arrBalls[_loc1].vX = arrBalls[_loc1].vX + XNudgeAmp / nudgeTurns;
                continue;
            } // end if
            arrBalls[_loc1].vX = arrBalls[_loc1].vX - XNudgeAmp / nudgeTurns;
        } // end of for
    } // end if
} // End of the function
function trc(theString)
{
    trace (theString + ": " + eval(theString));
} // End of the function
function main()
{
    var i;
    var j;
    for (i = 0; i < arrBalls.length; i++)
    {
        var thisBall = arrBalls[i];
        moveBall(thisBall);
        var comp;
        var k = arrComponents.length;
        var j;
        for (j = 0; j < k; j++)
        {
            comp = arrComponents[j];
            if (comp.blnCheck && comp.blnEnabled)
            {
                if (thisBall.location == comp.location || comp.location == "everywhere")
                {
                    if (comp.hitTest(thisBall.x, thisBall.y, false))
                    {
                        if (comp.blnHitCheck)
                        {
                            if (comp.mcCheckArea.hitTest(thisBall.x, thisBall.y, true))
                            {
                                comp.activate(thisBall);
                            } // end if
                        }
                        else if (comp.check(thisBall))
                        {
                            comp.activate(thisBall);
                        } // end else if
                        continue;
                    } // end if
                    comp.reset(thisBall);
                } // end if
            } // end if
        } // end of for
        if (Key.isDown(73) && Key.isDown(78) && Key.isDown(70) && Key.isDown(79))
        {
            processInfoBoard();
        } // end if
        for (j = i + 1; j < arrBalls.length; j++)
        {
            var thatBall = arrBalls[j];
            if (thatBall.location == thisBall.location && Math.abs(thisBall.x - thatBall.x) < 2 * ballR && Math.abs(thisBall.y - thatBall.y) < 2 * ballR)
            {
                var r = Math.sqrt(Math.abs(thisBall.x - thatBall.x) + Math.abs(thisBall.y - thatBall.y));
                if (r < 2 * ballR)
                {
                    var thisVel = Math.sqrt(sqr(thisBall.vX) + sqr(thisBall.vY));
                    var thatVel = Math.sqrt(sqr(thatBall.vX) + sqr(thatBall.vY));
                    var blnSwap = false;
                    if (thatVel > thisVel)
                    {
                        var tmpObj = thatBall;
                        thatBall = thisBall;
                        thisBall = tmpObj;
                        blnSwap = true;
                    } // end if
                    thisBall.vX = thisBall.vX - thatBall.vX;
                    thisBall.vY = thisBall.vY - thatBall.vY;
                    var vX = thatBall.vX;
                    var vY = thatBall.vY;
                    extCollision(thisBall, thatBall);
                    thisBall.vX = thisBall.vX + vX;
                    thisBall.vY = thisBall.vY + vY;
                    if (blnSwap)
                    {
                        var tmpObj = thatBall;
                        thatBall = thisBall;
                        thisBall = tmpObj;
                        blnSwap = false;
                    } // end if
                    if (thisBall.blnAllowCollis)
                    {
                        thisBall.blnLockMovement = false;
                        thisBall.blnLockGravity = false;
                    } // end if
                    if (thatBall.blnAllowCollis)
                    {
                        thatBall.blnLockMovement = false;
                        thatBall.blnLockGravity = false;
                    } // end if
                } // end if
            } // end if
        } // end of for
    } // end of for
    if (nudgeTurnsA > 0)
    {
        ++nudgeTurnsA;
        if (nudgeTurnsA > nudgeTurns + 1)
        {
            stopNudging();
            nudgeTurnsA = 0;
        } // end if
    } // end if
    if (mainCalls % updateTurns == 0)
    {
        var h = 0;
        while (h < arrBalls.length)
        {
            arrBalls[h]._x = arrBalls[h].x;
            arrBalls[h]._y = arrBalls[h].y;
            ++h;
        } // end while
        var minDep;
        var maxDep;
        var b;
        var k;
        var x1;
        var y1;
        for (i = 0; i < arrBalls.length; i++)
        {
            var thisBall = arrBalls[i];
            if (thisBall.location == "table")
            {
                minDep = yObjDepth - 10 + i + 1;
                maxDep = frontObjDepth - 10 + i + 1;
                for (j = 0; j < arrYDepObjs.length; j++)
                {
                    if (thisBall.hitTest(arrYDepObjs[j]))
                    {
                        if (arrYDepObjs[j].blnDS)
                        {
                            y1 = arrYDepObjs[j].DSK * (thisBall.x - arrYDepObjs[j].DSX);
                            if (y1 < -(thisBall.y - arrYDepObjs[j].DSY))
                            {
                                maxDep = 10 * (j - 1) + (i + 1) + yObjDepth;
                            }
                            else
                            {
                                minDep = 10 * j + (i + 1) + yObjDepth;
                            } // end else if
                            continue;
                        } // end if
                        if (thisBall.y < arrYDepObjs[j]._y)
                        {
                            maxDep = 10 * (j - 1) + (i + 1) + yObjDepth;
                            continue;
                        } // end if
                        minDep = 10 * j + (i + 1) + yObjDepth;
                    } // end if
                } // end of for
                thisBall.swapDepths(minDep);
                continue;
            } // end if
            for (j = 0; j < arrRamps.length; j++)
            {
                if (thisBall.location == arrRamps[j])
                {
                    thisBall.swapDepths(eval(arrRamps[j] + "BallDepth") + i);
                } // end if
            } // end of for
        } // end of for
    } // end if
    ++mainCalls;
} // End of the function
function processRollSounds()
{
    var _loc3 = new Array();
    var _loc1;
    var _loc5;
    var _loc6;
    var _loc2;
    for (var _loc4 = 0; _loc4 < arrBalls.length; ++_loc4)
    {
        _loc2 = Math.sqrt(sqr(arrBalls[_loc4].vX) + sqr(arrBalls[_loc4].vY));
        if (arrBalls[_loc4].blnLockMovement)
        {
            _loc2 = 0;
        } // end if
        _loc1 = 0;
        _loc5 = _loc3.length;
        while (_loc1 < _loc5)
        {
            if (_loc2 > _loc3[_loc1])
            {
                _loc3.splice(_loc1, 0, _loc2);
                break;
            } // end if
            ++_loc1;
        } // end while
        if (_loc1 == _loc5)
        {
            _loc3.splice(_loc1, 0, _loc2);
        } // end if
    } // end of for
    if (_loc3.length > 0)
    {
        _loc6 = _loc3[0] * 10;
        _loc6 = _loc6 > 100 ? (100) : (_loc6);
        sndBallRoll.setVolume(_loc6);
        if (_loc3.length > 1)
        {
            _loc6 = _loc3[1] * 13;
            _loc6 = _loc6 > 100 ? (100) : (_loc6);
            sndBallRoll2.setVolume(_loc6);
        }
        else
        {
            sndBallRoll2.setVolume(0);
        } // end else if
    }
    else
    {
        sndBallRoll.setVolume(0);
        sndBallRoll2.setVolume(0);
    } // end else if
} // End of the function
function extCollision(obj1, obj2)
{
    var _loc4;
    var _loc7;
    var _loc3;
    var _loc8 = Math.sqrt(sqr(obj1.x - obj2.x) + sqr(obj1.y - obj2.y));
    var _loc6 = Math.sqrt(sqr(obj1.vX) + sqr(obj1.vY));
    _loc4 = horAzim(obj1.x, obj1.y, obj2.x, obj2.y);
    _loc3 = horAzim(obj1.vX, obj1.vY, 0, 0);
    if (Math.abs(_loc4 - _loc3) > 1.570796 && Math.abs(_loc4 - _loc3) < 4.712389)
    {
        var _loc5 = 0.500000 * _loc6 * Math.abs(Math.cos(_loc4 - _loc3));
        if (_loc5 < gameInterval / 10)
        {
            _loc5 = 0;
        } // end if
        if (obj2.blnAllowCollis)
        {
            obj2.vX = obj2.vX - _loc5 * Math.cos(_loc4);
            obj2.vY = obj2.vY + _loc5 * Math.sin(_loc4);
        } // end if
        if (Math.abs(obj1.x - obj2.x) > 0.100000)
        {
            if (_loc8 > Math.abs(obj2.x - obj1.x))
            {
                if (obj1.y > obj2.y)
                {
                    obj1.y = obj2.y + Math.sqrt(sqr(2 * ballR) - sqr(obj2.x - obj1.x));
                }
                else
                {
                    obj1.y = obj2.y - Math.sqrt(sqr(2 * ballR) - sqr(obj2.x - obj1.x));
                } // end if
            } // end if
        } // end else if
        if (obj1.blnAllowCollis)
        {
            _loc3 = _loc3 - 3.141593;
            if (_loc3 < 0)
            {
                _loc3 = 6.283185 + _loc3;
            } // end if
            _loc7 = 2 * _loc4 - _loc3;
            obj1.vX = 0.500000 * Math.cos(_loc7) * _loc6;
            obj1.vY = -0.500000 * Math.sin(_loc7) * _loc6;
        } // end if
    } // end if
} // End of the function
function horAzim(destX, destY, sourceX, sourceY)
{
    var _loc1 = Math.atan(-(destY - sourceY) / (destX - sourceX));
    if (destX < sourceX)
    {
        _loc1 = _loc1 + 3.141593;
    } // end if
    if (_loc1 < 0)
    {
        _loc1 = _loc1 + 6.283185;
    } // end if
    return (_loc1);
} // End of the function
function sqr(x)
{
    return (x * x);
} // End of the function
function destributeComponentDepths()
{
    var comp;
    var k = arrComponents.length;
    var j = 0;
    while (j < k)
    {
        comp = arrComponents[j];
        var depth = comp.getDepth();
        var y = comp._y;
        if (comp.yDepthMode)
        {
            var g = -1;
            do
            {
                ++g;
            } while (g < arrYDepObjs.length && y >= arrYDepObjs[g]._y)
            arrYDepObjs.splice(g, 0, comp);
        }
        else if (comp.alwaysInFront)
        {
            var f = -1;
            do
            {
                ++f;
            } while (f < arrFrontDepObjs.length && depth >= arrFrontDepObjs[f].getDepth())
            arrFrontDepObjs.splice(f, 0, comp);
        }
        else
        {
            var f = -1;
            do
            {
                ++f;
            } while (f < arrBackDepObjs.length && depth >= arrBackDepObjs[f].getDepth())
            arrBackDepObjs.splice(f, 0, comp);
        } // end else if
        ++j;
    } // end while
    var j = 0;
    while (j < arrFrontDepObjs.length)
    {
        arrFrontDepObjs[j].swapDepths(frontObjDepth + j * 10);
        ++j;
    } // end while
    var j = 0;
    while (j < arrYDepObjs.length)
    {
        arrYDepObjs[j].swapDepths(yObjDepth + j * 10);
        if (arrYDepObjs[j].DS._alpha > 0)
        {
            arrYDepObjs[j].blnDS = true;
            arrYDepObjs[j].blnDS._rotation = arrYDepObjs[j].blnDS._rotation % 180;
            arrYDepObjs[j].DSK = Math.tan(-(arrYDepObjs[j].DS._rotation + arrYDepObjs[j]._rotation) / 180 * 3.141593);
            arrYDepObjs[j].DSX = arrYDepObjs[j].DS._x + arrYDepObjs[j]._x;
            arrYDepObjs[j].DSY = arrYDepObjs[j].DS._y + arrYDepObjs[j]._y;
            arrYDepObjs[j].DS.swapDepths(arrYDepObjs[j].getNextHighestDepth());
            arrYDepObjs[j].DS.removeMovieClip();
        } // end if
        ++j;
    } // end while
    var j = 0;
    while (j < arrBackDepObjs.length)
    {
        arrBackDepObjs[j].swapDepths(backObjDepth + j * 10);
        ++j;
    } // end while
    mcHighest.swapDepths(mcHighestDepth);
    mcInfoDisplayer.swapDepths(mcHighestDepth + 1);
    var j = 0;
    while (j < arrRamps.length)
    {
        var f = 0;
        var h = 0;
        while (h < eval(arrRamps[j] + "Bottom").length)
        {
            this[eval(arrRamps[j] + "Bottom")[h]].swapDepths(eval(arrRamps[j] + "Depths")[f]);
            ++f;
            ++h;
        } // end while
        var h = 0;
        while (h < eval(arrRamps[j] + "Top").length)
        {
            this[eval(arrRamps[j] + "Top")[h]].swapDepths(eval(arrRamps[j] + "Depths")[f]);
            var dd = this[eval(arrRamps[j] + "Top")[h]].getDepth();
            ++f;
            ++h;
        } // end while
        ++j;
    } // end while
} // End of the function
function processInfoBoard()
{
    if (getTimer() - this.scoreTimeout < 500)
    {
        return;
    } // end if
    if (mcSB._x > 0)
    {
        mcSB.removeMovieClip();
    }
    else
    {
        this.createEmptyMovieClip("mcSB", 14238);
        mcSB._x = 210;
        with (mcSB)
        {
            lineStyle(l, 0, 90);
            beginFill(2236962, 50);
            moveTo(0, 0);
            lineTo(0, 60);
            lineTo(220, 60);
            lineTo(220, 0);
            endFill();
        } // End of with
        mcSB.createTextField("txt", 4, 3, 10, 210, 55);
        var strScore;
        strScore = String.fromCharCode(arrRandomScoreData[0]);
        var i = 1;
        while (i < arrRandomScoreData.length)
        {
            strScore = strScore + String.fromCharCode(arrRandomScoreData[i]);
            ++i;
        } // end while
        mcSB.txt.text = strScore;
        mcSB.txt.selectable = false;
        var format = new TextFormat();
        format.size = 12;
        format.font = "Arial";
        format.color = 11184810;
        format.align = "center";
        mcSB.txt.setTextFormat(format);
    } // end else if
    this.scoreTimeout = getTimer();
} // End of the function
function componentsInit()
{
    var i;
    var j;
    if (XMLexists)
    {
        var arrCompNodes = paramXML.childNodes[0].childNodes;
        for (i = 0; i < arrCompNodes.length; i++)
        {
            var arrParamNodes = arrCompNodes[i].childNodes;
            for (j = 0; j < arrParamNodes.length; j++)
            {
                switch (arrTypes[arrCompNodes[i].attributes.type][j])
                {
                    case "Number":
                    {
                        set(arrCompNodes[i].nodeName + "." + arrParamNodes[j].nodeName, Number(arrParamNodes[j].firstChild.nodeValue));
                        break;
                    } 
                    case "String":
                    {
                        set(arrCompNodes[i].nodeName + "." + arrParamNodes[j].nodeName, arrParamNodes[j].firstChild.nodeValue);
                        break;
                    } 
                    case "Boolean":
                    {
                        if (arrParamNodes[j].firstChild.nodeValue == "true")
                        {
                            set(arrCompNodes[i].nodeName + "." + arrParamNodes[j].nodeName, true);
                        }
                        else
                        {
                            set(arrCompNodes[i].nodeName + "." + arrParamNodes[j].nodeName, false);
                        } // end else if
                        break;
                    } 
                    default:
                    {
                        switch (arrParamNodes[j].nodeName)
                        {
                            case "activateScore":
                            {
                                set(arrCompNodes[i].nodeName + "." + arrParamNodes[j].nodeName, Number(arrParamNodes[j].firstChild.nodeValue));
                                break;
                            } 
                            case "yDepthMode":
                            case "alwaysInFront":
                            {
                                if (arrParamNodes[j].firstChild.nodeValue == "true")
                                {
                                    set(arrCompNodes[i].nodeName + "." + arrParamNodes[j].nodeName, true);
                                }
                                else
                                {
                                    set(arrCompNodes[i].nodeName + "." + arrParamNodes[j].nodeName, false);
                                } // end else if
                                break;
                            } 
                        } // End of switch
                        break;
                    } 
                } // End of switch
            } // end of for
        } // end of for
    }
    else
    {
        for (i = 0; i < arrComponents.length - 1; i++)
        {
            var s = arrComponents[i]._name;
            var f = i;
            var cmp;
            for (j = i + 1; j < arrComponents.length; j++)
            {
                cmp = arrComponents[j]._name;
                if (s > cmp)
                {
                    s = cmp;
                    f = j;
                } // end if
            } // end of for
            var o;
            o = arrComponents[i];
            arrComponents[i] = arrComponents[f];
            arrComponents[f] = o;
            s = arrComponentTypes[f];
            arrComponentTypes[f] = arrComponentTypes[i];
            arrComponentTypes[i] = s;
        } // end of for
        for (i = 0; i < arrComponents.length - 1; i++)
        {
        } // end of for
        var rootNode = paramXML.createElement("components");
        paramXML.appendChild(rootNode);
        rootNode.attributes.proper = "true";
        var compNode;
        var paramNode;
        var tValue;
        for (i = 0; i < arrComponents.length; i++)
        {
            compNode = paramXML.createElement(arrComponents[i]._name);
            rootNode.appendChild(compNode);
            compNode.attributes.type = arrComponentTypes[i];
            var d = arrProperties[arrComponentTypes[i]].length;
            for (j = 0; j < d; j++)
            {
                paramNode = paramXML.createElement(arrProperties[arrComponentTypes[i]][j]);
                tValue = paramXML.createTextNode(String(eval(arrComponents[i]._name + "." + arrProperties[arrComponentTypes[i]][j])));
                paramNode.appendChild(tValue);
                compNode.appendChild(paramNode);
            } // end of for
            paramNode = paramXML.createElement("activateScore");
            tValue = paramXML.createTextNode(arrComponents[i].activateScore);
            paramNode.appendChild(tValue);
            compNode.appendChild(paramNode);
            paramNode = paramXML.createElement("yDepthMode");
            tValue = paramXML.createTextNode(arrComponents[i].yDepthMode);
            paramNode.appendChild(tValue);
            compNode.appendChild(paramNode);
            paramNode = paramXML.createElement("alwaysInFront");
            tValue = paramXML.createTextNode(arrComponents[i].alwaysInFront);
            paramNode.appendChild(tValue);
            compNode.appendChild(paramNode);
        } // end of for
        mcHighest.mcXMLReport._y = mcHighest.mcXMLReport._y + 550;
        mcHighest.textArea1._y = mcHighest.textArea1._y + 550;
        mcHighest.textArea1.text = paramXML.toString();
    } // end else if
} // End of the function
function addScore(obj, numScore)
{
    var _loc1 = numScore * targetBonusState;
    if (blnBumperBonus)
    {
        if (obj == leftBumper || obj == centerBumper || obj == rightBumper)
        {
            _loc1 = _loc1 * 5;
        } // end if
    } // end if
    score = score + _loc1;
    var _loc2 = String(score);
    txtScore.text = _loc2;
} // End of the function
function gamePause(flag)
{
    blnPause = flag;
    if (flag)
    {
        Key.removeListener(keyUpListener);
        Key.removeListener(keyDownListener);
    }
    else
    {
        Key.addListener(keyUpListener);
        Key.addListener(keyDownListener);
    } // end else if
} // End of the function
function showHelp()
{
    this.mcHelpBgr.swapDepths(this.getNextHighestDepth());
    this.mcHelp.swapDepths(this.getNextHighestDepth());
    this.mcHelpBgr._visible = true;
    this.mcHelp._visible = true;
    gamePause(true);
    this.mcHelp.btnClose.onRollOver = function ()
    {
        this.gotoAndStop("ON");
    };
    this.mcHelp.btnClose.onRollOut = function ()
    {
        this.gotoAndStop("OFF");
    };
    this.mcHelp.btnClose.onDragOut = function ()
    {
        this.gotoAndStop("OFF");
    };
    this.mcHelp.btnClose.onRelease = function ()
    {
        this._parent.gotoAndStop(1);
        this._parent._parent.gamePause(false);
        this._parent._parent.mcHelpBgr._visible = false;
        this._parent._parent.mcHelp._visible = false;
        this._parent._parent.playSound(this._parent._parent.sndClick, 0, 1, 100);
    };
    playSound(sndClick, 0, 1, 100);
} // End of the function
function showDlg()
{
    this.mcHelpBgr.swapDepths(this.getNextHighestDepth());
    this.mcDlg.swapDepths(this.getNextHighestDepth());
    this.mcHelpBgr._visible = true;
    this.mcDlg._visible = true;
    gamePause(true);
    this.mcDlg.btnYes.onRelease = function ()
    {
        this._parent._parent.gamePause(false);
        this._parent._parent.mcHelpBgr._visible = false;
        this._parent._parent.mcDlg._visible = false;
        this._parent._parent.playSound(this._parent._parent.sndClick, 0, 1, 100);
        this._parent._parent.gameOver();
    };
    this.mcDlg.btnNo.onRelease = function ()
    {
        this._parent._parent.gamePause(false);
        this._parent._parent.mcHelpBgr._visible = false;
        this._parent._parent.mcDlg._visible = false;
        this._parent._parent.playSound(this._parent._parent.sndClick, 0, 1, 100);
    };
    playSound(sndClick, 0, 1, 100);
} // End of the function
keyDownListener.onKeyDown = function ()
{
    var _loc2 = Key.getCode();
    for (i = 0; i < arrKeyPlunger.length; i++)
    {
        if (_loc2 == arrKeyPlunger[i])
        {
            arrPlungers[0].charge();
            break;
        } // end if
    } // end of for
    for (i = 0; i < arrKeyLFlipper.length; i++)
    {
        if (_loc2 == arrKeyLFlipper[i] && !blnTilt)
        {
            for (var _loc1 = 0; _loc1 < arrFlippers.length; ++_loc1)
            {
                if (arrFlippers[_loc1].blnLeft == true && arrFlippers[_loc1].blnFlipped == false)
                {
                    arrFlippers[_loc1].flip();
                    shiftSwitchLeft();
                    sndFlipper1.start(0, 1);
                } // end if
            } // end of for
            break;
        } // end if
    } // end of for
    for (i = 0; i < arrKeyRFlipper.length; i++)
    {
        if (_loc2 == arrKeyRFlipper[i] && !blnTilt)
        {
            for (var _loc1 = 0; _loc1 < arrFlippers.length; ++_loc1)
            {
                if (arrFlippers[_loc1].blnLeft == false && arrFlippers[_loc1].blnFlipped == false)
                {
                    arrFlippers[_loc1].flip();
                    if (_loc1 == 1)
                    {
                        shiftSwitchRight();
                    } // end if
                    sndFlipper2.start(0, 1);
                } // end if
            } // end of for
            break;
        } // end if
    } // end of for
    for (i = 0; i < arrKeyNudge.length; i++)
    {
        if (_loc2 == arrKeyNudge[i] && !blnTilt)
        {
            nudge();
        } // end if
    } // end of for
};
keyUpListener.onKeyUp = function ()
{
    var _loc2 = Key.getCode();
    for (i = 0; i < arrKeyPlunger.length; i++)
    {
        if (_loc2 == arrKeyPlunger[i])
        {
            arrPlungers[0].launch();
            break;
        } // end if
    } // end of for
    for (i = 0; i < arrKeyLFlipper.length; i++)
    {
        if (_loc2 == arrKeyLFlipper[i] && !blnTilt)
        {
            for (var _loc1 = 0; _loc1 < arrFlippers.length; ++_loc1)
            {
                if (arrFlippers[_loc1].blnLeft == true && arrFlippers[_loc1].blnFlipped == true)
                {
                    arrFlippers[_loc1].release();
                } // end if
            } // end of for
            break;
        } // end if
    } // end of for
    for (i = 0; i < arrKeyRFlipper.length; i++)
    {
        if (_loc2 == arrKeyRFlipper[i] && !blnTilt)
        {
            for (var _loc1 = 0; _loc1 < arrFlippers.length; ++_loc1)
            {
                if (arrFlippers[_loc1].blnLeft == false && arrFlippers[_loc1].blnFlipped == true)
                {
                    arrFlippers[_loc1].release();
                } // end if
            } // end of for
            break;
        } // end if
    } // end of for
};
this.onMouseMove = function ()
{
    plunger1.mcLaunchVector._rotation = -(horAzim(this._xmouse, this._ymouse, plunger1._x, plunger1._y) * 180 / 3.141593 - 90);
};
