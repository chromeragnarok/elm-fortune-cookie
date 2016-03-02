module FortuneCookie where

import StartApp.Simple as StartApp
import Effects exposing (Effects, Never)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import Http
import Json.Decode as Decode exposing (Decoder, (:=))
import Task exposing (andThen)
import Maybe
import Random
import Time
import List exposing (head)
import Native.NativeTime

type alias Fortune =
  { id: String, message : String }

type alias Model =
  { fortune: Fortune,
    currentTime: Int
  }

type Action = GetFortune
              | ReceiveFortune (Maybe Fortune)
              | GetCurrentTime (Maybe Int)


defaultFortune : Fortune
defaultFortune =
  Fortune "0" "Loading your fortune..."


init : (Model, Effects Action)
init =
  ({
    fortune = defaultFortune,
    currentTime = 1
  }, getCurrentTime)


fortuneUrl : Int -> String
fortuneUrl skip =
  "http://fortunecookieapi.com/v1/fortunes?limit=1&skip=" ++ (toString skip)


update : Action -> Model -> (Model, Effects Action)
update action model =
  -- (model, Effects.none)
  case action of
    GetFortune ->
      (model, getCurrentTime)

    ReceiveFortune maybeFortune ->
      ( {
        fortune =
          Maybe.withDefault defaultFortune maybeFortune,
        currentTime = model.currentTime
        }
      , Effects.none
      )

    GetCurrentTime maybeCurrentTime ->
      let
        currentTime = Maybe.withDefault model.currentTime (Debug.log "maybe time" maybeCurrentTime)
      in
        ( {
          fortune = model.fortune,
          currentTime =  (Debug.log "actual current time" currentTime)
          }
        , getFortune currentTime
        )


view : Address Action -> Model -> Html
view address model =
  div [id "container"] [text model.fortune.message]


-- Effects

getFortune : Int ->  Effects Action
getFortune currentTime =
  Http.get decodeFortuneList
    ( fortuneUrl
      ( fst ( Random.generate
        ( Random.int 0 20 )
        ( Random.initialSeed currentTime)
      )
    ) )
  |> Task.toMaybe
  |> Task.map ReceiveFortune
  |> Effects.task


getCurrentTime : Effects Action
getCurrentTime =
  Native.NativeTime.getCurrentTime
  |> Task.map GetCurrentTime
  |> Effects.task


decodeFortuneList : Decoder Fortune
decodeFortuneList =
  Decode.object1 getFirstElement ( Decode.list decodeFortune )


getFirstElement : List Fortune -> Fortune
getFirstElement fortuneList =
  Maybe.withDefault defaultFortune (head fortuneList)


decodeFortune : Decoder Fortune
decodeFortune =
  Decode.object2 Fortune
    ( "id" := Decode.string )
    ( "message" := Decode.string)


-- Main
