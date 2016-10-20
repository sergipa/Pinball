// Action script...

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
