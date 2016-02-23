import FortuneCookie exposing (init, update, view)
import StartApp

app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }

main =
  app.html
