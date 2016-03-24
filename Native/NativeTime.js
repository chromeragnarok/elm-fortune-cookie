Elm.Native.NativeTime = {}
Elm.Native.NativeTime.make = function(elm) {
  elm.Native = elm.Native || {};
  elm.Native.NativeTime = elm.Native.NativeTime || {};

  if (!!elm.Native.NativeTime.values) {
    return elm.Native.NativeTime.values;
  } else {
    return elm.Native.NativeTime.values = {
      currentTime: Date.now()
    }
  }
}
