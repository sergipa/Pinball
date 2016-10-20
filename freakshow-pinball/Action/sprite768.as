// Action script...

// [Initial MovieClip Action of sprite 768]
#initclip 36
class CBallEmitter extends CComponent
{
    var _parent, mcMarking, _x, _y, _name;
    function CBallEmitter()
    {
        super();
        _parent.arrComponents.push(this);
        _parent.arrComponentTypes.push("BallEmitter");
        _parent.arrBallEmitters.push(this);
        mcMarking._visible = false;
    } // End of the function
    function generateBall()
    {
        var i = 0;
        while (i < this._parent.arrBalls.length)
        {
            if (this._parent.arrBalls[i].x == this._x && this._parent.arrBalls[i].y == this._y)
            {
                return;
            } // end if
            ++i;
        } // end while
        with (this._parent)
        {
            ++ballCnt;
            attachMovie("mcBall", "mcBall" + ballCnt, _parent.getNextHighestDepth());
            var thisBall = eval("mcBall" + ballCnt);
            arrBalls.push(thisBall);
            thisBall.swapDepths(yObjDepth - 10 + arrBalls.length);
            thisBall.x = this._x;
            thisBall.y = this._y;
            thisBall.oldX = thisBall.x + 0.010000;
            thisBall.oldY = thisBall.y + 0.010000;
            thisBall._x = thisBall.x;
            thisBall._y = thisBall.y;
            thisBall.vX = 0;
            thisBall.vY = 0;
            thisBall.blnLockMovement = true;
            thisBall.blnLockGravity = true;
            thisBall.blnAllowCollis = true;
            thisBall.location = "table";
            _parent.moveBall(thisBall);
        } // End of with
        this._parent[this._name + "Generate"](thisBall);
    } // End of the function
} // End of Class
#endinitclip
