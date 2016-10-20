// Action script...

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
