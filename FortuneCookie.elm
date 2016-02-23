module FortuneCookie where

import StartApp.Simple as StartApp
import Effects exposing (Effects, Never)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import Http
import Json.Decode as Decode exposing (Decoder, (:=))
import Task

type alias Fortune =
  { id: String, message : String }

type alias Model = {
  fortune: Fortune
}

type Action = GetFortune | ReceiveFortune


init : (Model, Effects Action)
init =
  ({
    fortune = Fortune "0" "Loading your fortune..."
  }, Effects.none)


fortuneUrl : String
fortuneUrl =
  "http://fortunecookieapi.com/v1/fortunes?limit=1"


update : Action -> Model -> (Model, Effects Action)
update action model =
  (model, Effects.none)
  -- case action of
  --   GetFortune ->
  --     (model, getFortune)

    -- ReceiveFortune maybeFortune ->
    --   ( Model (Maybe.withDefault model.fortune maybeFortune), Effects.none )


view : Address Action -> Model -> Html
view address model =
  div [id "container"] [text model.fortune.message]


-- Effects

-- getFortune : Effects Action
-- getFortune =
--   Http.get decodeFortunes fortuneUrl
--     |> Task.toMaybe
--     |> Task.map ReceiveFortune
--     |> Effects.task


-- decodeListFortunes : Decoder Fortune
-- decodeListFortunes =
--   Decode.list Decode.tuple2
--   -- Decode.object1 identity ( Decode.list decodeFortune )
--
--
-- decodeFortune : Decoder Fortune
-- decodeFortune =
--   Decode.object2 Fortune
--     ( "id" := Decode.string )
--     ( "message" := Decode.string)
--

-- Main
