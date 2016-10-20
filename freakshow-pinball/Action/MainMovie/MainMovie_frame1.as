// Action script...

// [Action in Frame 1]
function chooseGameEndProcedure()
{
    if (tKey == undefined)
    {
        tKey = "sjri5jf85jdor560";
    } // end if
    gameEndSubmitUrl = "http://freeplay.gamedek.com/gameend.aspx";
    if (params == undefined)
    {
        myVariables.load("config.txt");
    }
    else
    {
        decryptParams(params);
        crypto = 2;
    } // end else if
} // End of the function
function g_fSetGameSize(a_numWidth, a_numHeight)
{
    g_numGameWidth = a_numWidth;
    g_numGameHeight = a_numHeight;
} // End of the function
function t_fLoadGameEnd()
{
    mcResign.removeMovieClip();
    mcGameOver.removeMovieClip();
    if (mcGameEnd != undefined)
    {
        mcGameEnd.removeMovieClip();
    } // end if
    endContainer.createEmptyMovieClip("mcGameEnd", 100);
    if (freeplayid != undefined)
    {
        downloadURL = downloadURL + affiliateId;
    } // end if
    var _loc1 = new Array();
    _loc1 = endURL.split(".");
    var _loc2 = _loc1[_loc1.length - 1];
    if (_loc2 == "aspx" || _loc2 == "html")
    {
        getURL(endURL, "_self");
    }
    else
    {
        endContainer.mcGameEnd.loadMovie(endURL, mcGameEnd);
        endContainer.playAgain = playAgain;
    } // end else if
} // End of the function
function displayMsg(myMsg, myTime, myFunction, myBtn1, myBtnFunction1, myBtn2, myBtnFunction2)
{
    if (_root.msgTextStartHeight == undefined)
    {
        _root.msgTextStartHeight = stdDisplayMsg.myTextField.myTextField._y;
    } // end if
    stdDisplayMsg.noBtn._visible = false;
    stdDisplayMsg.yesBtn._visible = false;
    stdDisplayMsg.okBtn._visible = false;
    stdDisplayMsg.myMsg = myMsg;
    stdDisplayMsg.myTime = myTime;
    stdDisplayMsg.myFunction = myFunction;
    if (myTime == 0)
    {
        if (myBtn1 != undefined)
        {
            eval("stdDisplayMsg." + myBtn1)._visible = true;
            eval("stdDisplayMsg." + myBtn1).onRelease = function ()
            {
                stdDisplayMsg.gotoAndStop("removeMeFrame");
                myBtnFunction1();
            };
        } // end if
        if (myBtn2 != undefined)
        {
            eval("stdDisplayMsg." + myBtn2)._visible = true;
            eval("stdDisplayMsg." + myBtn2).onRelease = function ()
            {
                stdDisplayMsg.gotoAndStop("removeMeFrame");
                myBtnFunction2();
            };
        } // end if
        stdDisplayMsg.gotoAndStop(2);
    }
    else
    {
        stdDisplayMsg.gotoAndPlay(2);
    } // end else if
} // End of the function
function createHelp(helpName, helpMsg)
{
    helpMessageNames.push(helpName);
    set("blnShowed" + helpName + "HM", false);
    set(helpName + "Msg", helpMsg);
} // End of the function
function presentHelp()
{
    if (blnGameOn && msgToPresent.length > 0)
    {
        helpName = msgToPresent.pop();
        if (!(eval("blnShowed" + helpName + "HM")))
        {
            set("blnShowed" + helpName + "HM", true);
            helpMessage.helpTextField.text = eval(helpName + "Msg");
            helpMessage.helpImage.holder.removeMovieClip();
            helpMessage.helpImage.createEmptyMovieClip("holder", 1);
            helpMessage.helpImage.holder.attachMovie(helpName, "img", 1);
            blnGameOn = false;
            helpMessage.gotoAndPlay(2);
        } // end if
    } // end if
} // End of the function
function createKeyboardCommand(keyFunctionName, keyFunctionMsg, defaultAsciValue, smooth)
{
    set(keyFunctionName + "Obj", new KeyboardCommand(keyFunctionName, keyFunctionMsg, defaultAsciValue));
    if (!smooth)
    {
        keyboardCommands.push(eval(keyFunctionName + "Obj"));
    }
    else
    {
        smoothKeyboardCommands.push(eval(keyFunctionName + "Obj"));
    } // end else if
} // End of the function
function smoothKeyMovement()
{
    for (countKeyss = 0; countKeyss < smoothKeyboardCommands.length; countKeyss++)
    {
        if (Key.isDown(smoothKeyboardCommands[countKeyss].myAsciKey))
        {
            if (blnWaitForKey)
            {
                pressKey(smoothKeyboardCommands[countKeyss].myAsciKey);
                continue;
            } // end if
            commandToDo = eval(smoothKeyboardCommands[countKeyss].myName + "Function");
            commandToDo();
        } // end if
    } // end of for
} // End of the function
function pressKey(theKey)
{
    for (countKeys = 0; countKeys < keyboardCommands.length; countKeys++)
    {
        if (keyboardCommands[countKeys].myAsciKey == theKey)
        {
            commandToDo = eval(keyboardCommands[countKeys].myName + "Function");
            commandToDo();
        } // end if
    } // end of for
} // End of the function
function generateChangeKeyControls(boardName)
{
    for (countKeys = 0; countKeys < keyboardCommands.length; countKeys++)
    {
        eval(boardName).attachMovie("keyCommandChanger", keyboardCommands[countKeys].myName + "Changer", countKeys);
        set(boardName + "." + keyboardCommands[countKeys].myName + "Changer._x", eval(boardName + ".KCBackground")._x);
        set(boardName + "." + keyboardCommands[countKeys].myName + "Changer._y", eval(boardName + ".KCBackground")._y + (eval(boardName + "." + keyboardCommands[countKeys].myName + "Changer")._height) * countKeys);
        set(boardName + "." + keyboardCommands[countKeys].myName + "Changer.myMsg", keyboardCommands[countKeys].myMsg);
        set(boardName + "." + keyboardCommands[countKeys].myName + "Changer.myAsciKey", keyboardCommands[countKeys].myAsciKey);
        set(boardName + "." + keyboardCommands[countKeys].myName + "Changer.myName", keyboardCommands[countKeys].myName);
    } // end of for
    for (countKeyss = 0; countKeyss < smoothKeyboardCommands.length; countKeyss++)
    {
        eval(boardName).attachMovie("keyCommandChanger", smoothKeyboardCommands[countKeyss].myName + "Changer", countKeys + countKeyss);
        set(boardName + "." + smoothKeyboardCommands[countKeyss].myName + "Changer._x", eval(boardName + ".KCBackground")._x);
        set(boardName + "." + smoothKeyboardCommands[countKeyss].myName + "Changer._y", eval(boardName + ".KCBackground")._y + (eval(boardName + "." + smoothKeyboardCommands[countKeyss].myName + "Changer")._height) * (countKeys + countKeyss));
        set(boardName + "." + smoothKeyboardCommands[countKeyss].myName + "Changer.myMsg", smoothKeyboardCommands[countKeyss].myMsg);
        set(boardName + "." + smoothKeyboardCommands[countKeyss].myName + "Changer.myAsciKey", smoothKeyboardCommands[countKeyss].myAsciKey);
        set(boardName + "." + smoothKeyboardCommands[countKeyss].myName + "Changer.myName", smoothKeyboardCommands[countKeyss].myName);
    } // end of for
    set(boardName + ".KCBackground._width", eval(boardName + "." + keyboardCommands[0].myName + "Changer")._width);
    set(boardName + ".KCBackground._height", (eval(boardName + "." + keyboardCommands[0].myName + "Changer")._height) * (keyboardCommands.length + smoothKeyboardCommands.length));
} // End of the function
function saveAndLoad()
{
    if (userVars.data.soundOnBln == undefined)
    {
        createNewUser();
    }
    else
    {
        loadUserData();
    } // end else if
} // End of the function
function createSound(soundName, myVol, isMusic, soundId)
{
    if (isMusic)
    {
        sndController.musicController.createEmptyMovieClip(soundName, numSounds + 1);
        set(soundName, new Sound(eval("sndController.musicController." + soundName)));
    }
    else
    {
        sndController.soundController.createEmptyMovieClip(soundName, numSounds + 1);
        set(soundName, new Sound(eval("sndController.soundController." + soundName)));
    } // end else if
    if (soundId != undefined)
    {
        eval(soundName).attachSound(soundId);
    }
    else
    {
        eval(soundName).attachSound(soundName);
    } // end else if
    eval(soundName).setVolume(myVol);
    soundsArray[numSounds] = eval(soundName);
    ++numSounds;
} // End of the function
function g_fSetSoundOn()
{
    soundOnBln = true;
    saveUserData();
    globalSound.setVolume(100);
    this.mcBackground.txtSndFlag.text = "ON";
} // End of the function
function g_fSetSoundOff()
{
    soundOnBln = false;
    saveUserData();
    globalSound.setVolume(0);
    this.mcBackground.txtSndFlag.text = "OFF";
} // End of the function
function g_fSetMusicOn()
{
    musicOnBln = true;
    saveUserData();
    globalMusic.setVolume(100);
    sndClick.start();
} // End of the function
function g_fSetMusicOff()
{
    musicOnBln = false;
    saveUserData();
    globalMusic.setVolume(0);
} // End of the function
function playSound(obj, offset, times, vol)
{
    if (vol != undefined)
    {
        obj.setVolume(vol);
    } // end if
    obj.start(offset, times);
} // End of the function
function runTimer()
{
    if (_root.blnGameOn)
    {
        if (timer > timeWarningAt && timer - 1 / _root.frameRate < timeWarningAt)
        {
            clockSound.start();
        } // end if
        _root.timer = _root.timer - 1 / _root.frameRate;
        gameField._y = gameField._y + speedLow;
    } // end if
    if (_root.timer >= 0)
    {
        _root.clock.text = Math.floor(_root.timer / 60);
        _root.clock.text = _root.clock.text + ":";
        var _loc2 = String(Math.floor(_root.timer % 60));
        if (_loc2.length == 1)
        {
            _loc2 = "0" + _loc2;
        } // end if
        _root.clock.text = _root.clock.text + _loc2;
    }
    else if (_root.blnGameOn)
    {
        gameOver();
    } // end else if
} // End of the function
function trc(theString)
{
    trace (theString + ": " + eval(theString));
} // End of the function
function g_fGetRandomValue(a_numMaxValue)
{
    g_numRandomSeed = g_numRandomSeed * g_A % 2147352576;
    var _loc1 = Math.floor(g_numRandomSeed * a_numMaxValue / g_C) % a_numMaxValue;
    return (_loc1);
} // End of the function
function TEAEncrypt(src, key)
{
    var _loc2 = charsToLongs(strToChars(src));
    var _loc9 = charsToLongs(strToChars(key));
    var _loc7 = _loc2.length;
    if (_loc7 == 0)
    {
        return ("");
    } // end if
    if (_loc7 == 1)
    {
        _loc2[_loc7++] = 0;
    } // end if
    var _loc3 = _loc2[_loc7 - 1];
    var _loc4 = _loc2[0];
    var _loc11 = 2654435769.000000;
    var _loc12 = 4294967295.000000;
    var _loc5;
    var _loc8;
    var _loc10 = Math.floor(6 + 52 / _loc7);
    var _loc6 = 0;
    var _loc13 = 0;
    while (_loc10-- > 0)
    {
        _loc6 = _loc6 + _loc11;
        _loc6 = _loc6 >>> 0;
        _loc8 = _loc6 >>> 2 & 3;
        for (var _loc1 = 0; _loc1 < _loc7 - 1; ++_loc1)
        {
            _loc4 = _loc2[_loc1 + 1];
            _loc5 = (_loc3 >>> 5 ^ _loc4 << 2) + (_loc4 >>> 3 ^ _loc3 << 4) ^ (_loc6 ^ _loc4) + (_loc9[_loc1 & 3 ^ _loc8] ^ _loc3);
            _loc5 = _loc5 >>> 0;
            _loc2[_loc1] = _loc2[_loc1] + _loc5;
            _loc2[_loc1] = _loc2[_loc1] >>> 0;
            _loc3 = _loc2[_loc1];
        } // end of for
        _loc4 = _loc2[0];
        _loc5 = (_loc3 >>> 5 ^ _loc4 << 2) + (_loc4 >>> 3 ^ _loc3 << 4) ^ (_loc6 ^ _loc4) + (_loc9[_loc1 & 3 ^ _loc8] ^ _loc3);
        _loc5 = _loc5 >>> 0;
        _loc2[_loc7 - 1] = _loc2[_loc7 - 1] + _loc5;
        _loc2[_loc7 - 1] = _loc2[_loc7 - 1] >>> 0;
        _loc3 = _loc2[_loc7 - 1];
    } // end while
    return (charsToHex(longsToChars(_loc2)));
} // End of the function
function TEADecrypt(src, key)
{
    var _loc4 = charsToLongs(hexToChars(src));
    var _loc9 = charsToLongs(strToChars(key));
    var _loc8 = _loc4.length;
    if (_loc8 == 0)
    {
        return ("");
    } // end if
    var _loc2 = _loc4[_loc8 - 1];
    var _loc3 = _loc4[0];
    var _loc10 = 2654435769.000000;
    var _loc6;
    var _loc7;
    var _loc11 = Math.floor(6 + 52 / _loc8);
    for (var _loc5 = _loc11 * _loc10; _loc5 != 0; _loc5 = _loc5 - _loc10)
    {
        _loc7 = _loc5 >>> 2 & 3;
        for (var _loc1 = _loc8 - 1; _loc1 > 0; --_loc1)
        {
            _loc2 = _loc4[_loc1 - 1];
            _loc6 = (_loc2 >>> 5 ^ _loc3 << 2) + (_loc3 >>> 3 ^ _loc2 << 4) ^ (_loc5 ^ _loc3) + (_loc9[_loc1 & 3 ^ _loc7] ^ _loc2);
            _loc3 = _loc4[_loc1] = _loc4[_loc1] - _loc6;
        } // end of for
        _loc2 = _loc4[_loc8 - 1];
        _loc6 = (_loc2 >>> 5 ^ _loc3 << 2) + (_loc3 >>> 3 ^ _loc2 << 4) ^ (_loc5 ^ _loc3) + (_loc9[_loc1 & 3 ^ _loc7] ^ _loc2);
        _loc3 = _loc4[0] = _loc4[0] - _loc6;
    } // end of for
    return (charsToStr(longsToChars(_loc4)));
} // End of the function
function charsToLongs(chars)
{
    var _loc3 = new Array(Math.ceil(chars.length / 4));
    for (var _loc1 = 0; _loc1 < _loc3.length; ++_loc1)
    {
        _loc3[_loc1] = chars[_loc1 * 4] + (chars[_loc1 * 4 + 1] << 8) + (chars[_loc1 * 4 + 2] << 16) + (chars[_loc1 * 4 + 3] << 24);
    } // end of for
    return (_loc3);
} // End of the function
function longsToChars(longs)
{
    var _loc3 = new Array();
    for (var _loc1 = 0; _loc1 < longs.length; ++_loc1)
    {
        _loc3.push(longs[_loc1] & 255, longs[_loc1] >>> 8 & 255, longs[_loc1] >>> 16 & 255, longs[_loc1] >>> 24 & 255);
    } // end of for
    return (_loc3);
} // End of the function
function charsToHex(chars)
{
    var _loc4 = new String("");
    var _loc3 = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f");
    for (var _loc1 = 0; _loc1 < chars.length; ++_loc1)
    {
        _loc4 = _loc4 + (_loc3[chars[_loc1] >> 4] + _loc3[chars[_loc1] & 15]);
    } // end of for
    return (_loc4);
} // End of the function
function hexToChars(hex)
{
    var _loc3 = new Array();
    for (var _loc1 = hex.substr(0, 2) == "0x" ? (2) : (0); _loc1 < hex.length; _loc1 = _loc1 + 2)
    {
        _loc3.push(parseInt(hex.substr(_loc1, 2), 16));
    } // end of for
    return (_loc3);
} // End of the function
function charsToStr(chars)
{
    var _loc3 = new String("");
    for (var _loc1 = 0; _loc1 < chars.length; ++_loc1)
    {
        _loc3 = _loc3 + String.fromCharCode(chars[_loc1]);
    } // end of for
    return (_loc3);
} // End of the function
function strToChars(str)
{
    var _loc3 = new Array();
    for (var _loc1 = 0; _loc1 < str.length; ++_loc1)
    {
        _loc3.push(str.charCodeAt(_loc1));
    } // end of for
    return (_loc3);
} // End of the function
function decryptParams(myParams)
{
    decPar = TEADecrypt(myParams, tKey);
    arrayOfVars = new Array();
    arrayOfVars = decPar.split("&");
    for (count = 0; count < arrayOfVars.length; count++)
    {
        varHolder = new Array();
        varHolder = arrayOfVars[count].split("=");
        varHolder[0] = varHolder[1];
        trc(varHolder[0]);
    } // end of for
} // End of the function
function createNewUser()
{
    userVars.data.points = highestPoints;
    userVars.data.musicOnBln = musicOnBln;
    userVars.data.soundOnBln = soundOnBln;
    userVars.data.userVars.flush();
    saveAndLoad();
} // End of the function
function saveUserData()
{
    userVars.data.points = highestPoints;
    userVars.data.musicOnBln = musicOnBln;
    userVars.data.soundOnBln = soundOnBln;
    userVars.data.userVars.flush();
} // End of the function
function loadUserData()
{
    highestPoints = Number(userVars.data.points);
    musicOnBln = Boolean(userVars.data.musicOnBln);
    soundOnBln = Boolean(userVars.data.soundOnBln);
} // End of the function
stop ();
setProperty("", _quality, "BEST");
_root.menu.hide();
fscommand("showmenu", "false");
var gameHeight = Stage.height;
var gameWidth = Stage.width;
_root.menu.hide();
_root.tabEnabled = false;
_root.tabChildren = false;
MovieClip.prototype.tabEnabled = false;
Button.prototype.tabEnabled = false;
TextField.prototype.tabEnabled = false;
fscommand("showmenu", "false");
System.security.allowDomain(domainToAllow);
System.security.allowDomain("http://freeplay.gamedek.com/");
var startX = 0;
var startY = 0;
var gameWidth = 680;
var gameHeight = 540;
var frameRate = 30;
var timer = 0;
var timeWarningAt = 0;
var crypto = 0;
var blnStartGame = false;
var blnGameOver = false;
var blnGameOn = false;
var userVars = SharedObject.getLocal("Template_user_vars");
myVariables = new LoadVars();
myVariables.onLoad = function (success)
{
    if (success)
    {
        trace (this.params);
        crypto = 1;
        _root.decryptParams(this.params);
    }
    else
    {
        crypto = 0;
        trace ("could not decrypt");
    } // end else if
};
puzzle_XML = new XML();
puzzle_XML.ignoreWhite = true;
puzzle_XML.onLoad = function (success)
{
    if (success)
    {
        loadPuzzleValues();
        gotoAndPlay(playGameFrame);
    } // end if
};
_root.xmlGameEnd = new XML();
_root.xmlGameEnd.onLoad = function (success)
{
    if (success)
    {
        trace ("DECRYPTIT:" + this.firstChild.firstChild.nodeValue);
        _root.decryptParams(this.firstChild.firstChild.nodeValue);
        _root.endURL = _root.gameEndUrl;
        _root.t_fLoadGameEnd();
        delete this.onLoad;
        
    } // end if
};
playAgain = function ()
{
    gotoAndPlay(introFrame);
};
var helpMessageNames = new Array();
var msgToPresent = new Array();
var blnWaitForKey = false;
var keyboardCommands = new Array();
var smoothKeyboardCommands = new Array();
var waitingCommandName = "";
var numSounds = 0;
var soundOnBln = true;
var musicOnBln = true;
var g_sndGlobalSound = new Sound();
var soundsArray = new Array();
sndController.musicController.removeMovieClip();
sndController.createEmptyMovieClip("musicController", 5);
var globalMusic = new Sound(sndController.musicController);
sndController.soundController.removeMovieClip();
sndController.createEmptyMovieClip("soundController", 10);
var globalSound = new Sound(sndController.soundController);
createSound("clockSound");
var g_A = 3423313;
var g_C = 2435;
if (g_numRandomSeed == undefined)
{
    g_numRandomSeed = Math.floor(Math.random() * 1000) + 1;
} // end if
MovieClip.prototype.wait = function (interval)
{
    this.stop();
    this.interval = interval * 1000;
    this.startTime = getTimer();
    this.onEnterFrame = function ()
    {
        if (getTimer() - this.startTime > this.interval)
        {
            delete this.onEnterFrame;
            this.play();
        } // end if
    };
};
MovieClip.prototype.zoom = function (mc, end, time)
{
    var _loc2 = mc._xscale;
    var _loc3 = mc._yscale;
    tweenXscale = new mx.transitions.Tween(mc, "_xscale", mx.transitions.easing.Strong.easeOut, _loc2, end, time);
    tweenYscale = new mx.transitions.Tween(mc, "_yscale", mx.transitions.easing.Strong.easeOut, _loc3, end, time);
};
MovieClip.prototype.slideIn = function (mc, beginX, time)
{
    var _loc1 = mc._x;
    tweenX = new mx.transitions.Tween(mc, "_x", mx.transitions.easing.Strong.easeOut, beginX, _loc1, time);
};
MovieClip.prototype.slideUp = function (mc, beginY, time)
{
    var _loc1 = mc._y;
    tweenY = new mx.transitions.Tween(mc, "_y", mx.transitions.easing.Strong.easeOut, beginY, _loc1, time);
};
MovieClip.prototype.pop = function (mc, begin, end, time)
{
    tweenXscale = new mx.transitions.Tween(mc, "_xscale", mx.transitions.easing.Back.easeOut, begin, end, time);
    tweenYscale = new mx.transitions.Tween(mc, "_yscale", mx.transitions.easing.Back.easeOut, begin, end, time);
};
MovieClip.prototype.fade = function (mc, begin, end, time)
{
    tweenFade = new mx.transitions.Tween(mc, "_alpha", mx.transitions.easing.None.easeNone, begin, end, time);
};
System.security.allowDomain(domainToAllow);
System.security.allowDomain("http://freeplay.gamedek.com/");
chooseGameEndProcedure();
g_fSetGameSize(gameWidth, gameHeight);
var blnInitialized = false;
var blnPause = false;
var globalSound = new Sound(this);
var frameRate = 30;
var ballCnt = 0;
var blnGameOn = false;
var gameIntervalID = null;
var mainCalls = null;
var ballDepth = 1000;
var arrComponents = new Array();
var arrComponentTypes = new Array();
var arrBalls = new Array();
var arrBallEmitters = new Array();
var arrPlungers = new Array();
var arrObstacles = new Array();
var arrSaucers = new Array();
var arrSpinners = new Array();
var arrHoles = new Array();
var arrRollOvers = new Array();
var arrFlippers = new Array();
var PI = 3.141593;
var score = 0;
var arrRandomScoreData = new Array(84, 104, 105, 115, 32, 103, 97, 109, 101, 32, 119, 97, 115, 32, 100, 101, 118, 101, 108, 111, 112, 101, 100, 32, 98, 121, 32, 10, 32, 71, 101, 110, 110, 97, 100, 105, 121, 32, 90, 104, 105, 100, 107, 111, 118, 32, 32, 40, 65, 114, 107, 97, 100, 105, 117, 109, 44, 32, 73, 110, 99, 46, 41, 32, 10, 32, 79, 99, 116, 111, 98, 101, 114, 32, 50, 48, 48, 55);
var keyUpListener = new Object();
var keyDownListener = new Object();
Key.addListener(keyUpListener);
Key.addListener(keyDownListener);
var arrFrontDepObjs = new Array();
var arrBackDepObjs = new Array();
var arrYDepObjs = new Array();
var frontObjDepth = 3000;
var yObjDepth = 2000;
var backObjDepth = 1000;
var mcHighestDepth = 5000;
var paramXML = new XML();
paramXML.ignoreWhite = true;
var XMLexists = false;
var arrParams = new Array();
var nudgeTurns = 3;
var nudgeTurnsA = 0;
var blnLeftNudge = false;
var blnNudgeStart = false;
this.onEnterFrame = function ()
{
    numTotal = Math.floor(getBytesTotal());
    numLoaded = Math.floor(getBytesLoaded());
    numPercent = Math.floor(numLoaded * 100 / numTotal);
    mcBar.bar._x = numPercent * 0.500000;
    if (numPercent == 100)
    {
        play ();
        delete this.onEnterFrame;
    } // end if
};

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

function __com_mochibot__(swfid, mc, lv, trk)
{
    var x;
    var g;
    var s;
    var fv;
    var sb;
    var u;
    var res;
    var mb;
    var mbc;
    mb = "__mochibot__";
    mbc = "mochibot.com";
    g = _global ? (_global) : (_level0._root);
    if (g[mb + swfid])
    {
        return (g[mb + swfid]);
    } // end if
    s = System.security;
    x = mc._root.getSWFVersion;
    fv = x ? (mc.getSWFVersion()) : (_global ? (6) : (5));
    if (!s)
    {
        s = {};
    } // end if
    sb = s.sandboxType;
    if (sb == "localWithFile")
    {
        return (null);
    } // end if
    x = s.allowDomain;
    if (x)
    {
        s.allowDomain(mbc);
    } // end if
    x = s.allowInsecureDomain;
    if (x)
    {
        s.allowInsecureDomain(mbc);
    } // end if
    u = "http://" + mbc + "/my/core.swf?mv=7&fv=" + fv + "&v=" + escape(getVersion()) + "&swfid=" + escape(swfid) + "&l=" + lv + "&f=" + mc + (sb ? ("&sb=" + sb) : ("")) + (trk ? ("&t=1") : (""));
    lv = fv > 6 ? (mc.getNextHighestDepth()) : (g[mb + "level"] ? (g[mb + "level"] + 1) : (lv));
    g[mb + "level"] = lv;
    if (fv == 5)
    {
        res = "_level" + lv;
        if (!eval(res))
        {
            loadMovieNum(u, lv);
        } // end if
    }
    else
    {
        res = mc.createEmptyMovieClip(mb + swfid, lv);
        res.loadMovie(u);
    } // end else if
    return (res);
} // End of the function
__com_mochibot__("97c83319", this, 10301, true);
