// Action script...

// [Initial MovieClip Action of sprite 760]
#initclip 28
class Trace
{
    function Trace()
    {
    } // End of the function
    static function info($message)
    {
        Trace.out("[ info ]  " + $message);
    } // End of the function
    static function wrapper($message)
    {
        Trace.out("[ wrapper ]  " + $message);
    } // End of the function
    static function toWrapper($message)
    {
        Trace.out("[ to wrapper ]  " + $message);
    } // End of the function
    static function error($message)
    {
        Trace.out("[ error ]  " + $message);
    } // End of the function
    static function out($message)
    {
        Trace.lcOut.send("_FlashLogger", "writeLog", $message.toString());
    } // End of the function
    static var lcOut = new LocalConnection();
} // End of Class
#endinitclip
