module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text, th, tr)
import Html.Events exposing (onClick)



-- import Shogi exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- Model


type alias Model =
    String


init : Model
init =
    "飛"



-- UPDATE


type Msg
    = Touch


update : Msg -> Model -> Model
update msg model =
    case msg of
        Touch ->
            if model == "飛" then
                "王"

            else
                "飛"



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ tr []
            [ th [] [ button [] [ text "歩" ] ]
            , th [] [ button [] [ text "金" ] ]
            , th [] [ button [] [ text "桂" ] ]
            ]
        , tr
            []
            [ th [] [ button [] [ text "歩" ] ]
            , th [] [ button [ onClick Touch ] [ text model ] ]
            , th [] [ button [] [ text "桂" ] ]
            ]
        , tr
            []
            [ th [] [ button [] [ text "歩" ] ]
            , th [] [ button [ onClick Touch ] [ text model ] ]
            , th [] [ button [] [ text "桂" ] ]
            ]
        , tr
            []
            [ th [] [ button [] [ text "歩" ] ]
            , th [] [ button [ onClick Touch ] [ text model ] ]
            , th [] [ button [] [ text "桂" ] ]
            ]
        ]
