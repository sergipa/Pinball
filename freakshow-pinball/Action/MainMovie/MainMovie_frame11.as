// Action script...

// [Action in Frame 11]
function checkLoaded()
{
    if (paramXML.loaded)
    {
        componentsInit();
        destributeComponentDepths();
        soundsInit();
        clearInterval(intID);
    } // end if
} // End of the function
stop ();
var intID;
if (!blnInitialized)
{
    blnInitialized = true;
    if (paramXML.loaded)
    {
        componentsInit();
        destributeComponentDepths();
        soundsInit();
    }
    else
    {
        intID = setInterval(checkLoaded, 400);
    } // end if
} // end else if
gameInit();
scenarioInit();
setTimeout(this, "assignMission", getRandomMissionTime());
this.startFranticLights();
if (soundOnBln)
{
    g_fSetSoundOn();
}
else
{
    g_fSetSoundOff();
} // end else if
plunger1.onMouseDown = function ()
{
    if (this.mcLaunchVector != undefined)
    {
        this.startDrag();
        this.dragging = true;
        trace ("plunger1.mcSpring.onMouseDown ");
    } // end if
};
var listener = new Object();
Mouse.addListener(listener);
listener.onMouseUp = function ()
{
    if (plunger1.mcLaunchVector != undefined && plunger1.dragging)
    {
        plunger1.dragging = false;
        plunger1.stopDrag();
        ballEmitter1._x = plunger1._x;
        ballEmitter1._y = plunger1._y;
    } // end if
};
mcHelpBgr._visible = false;
mcHelp._visible = false;
mcDlg._visible = false;
