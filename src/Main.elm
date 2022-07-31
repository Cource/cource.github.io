module Main exposing (..)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


main =
    div [class "home"] [
    div [class "hero"]
      [ div [class "center-text"]
          [ div [class "sec"]  [text "Hi, I'm"]
          , div [class "name"] [text "Jeff Jacob Joy"]
          , div [class "details"]
              [ text "= Designer"
              , text "| Programmer"
              ]
          ]
      , div [class "buttons"] []
      ]
        ]
