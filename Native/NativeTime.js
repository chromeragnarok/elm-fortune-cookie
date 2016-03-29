Elm.Native.NativeTime = {}
Elm.Native.NativeTime.make = function(elm) {
  elm.Native = elm.Native || {};
  elm.Native.NativeTime = elm.Native.NativeTime || {};

  var Task = Elm.Native.Task.make(elm);

  var getCurrentTime = Task.asyncFunction(function(callback){
    return callback(Task.succeed(Date.now()));
  });

  if (!!elm.Native.NativeTime.values) {
    return elm.Native.NativeTime.values;
  } else {
    return elm.Native.NativeTime.values = {
      getCurrentTime: getCurrentTime
    }
  }
}
