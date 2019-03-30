module Main exposing (main)

import Animal exposing (..)
import Array exposing (Array)
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Keyed as Keyed
import Html exposing (Html, button, div, text, th, tr)
import Html.Events exposing (onClick)


main : Program () Ban Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- Model


type alias Ban =
    Array Cell



-- { cell : List Cell }


init : Ban
init =
    Array.fromList
        [ Cell 1 1 (Koma Zou Gote False)
        , Cell 1 2 (Koma Emp Gote False)
        , Cell 1 3 (Koma Emp Gote False)
        , Cell 1 4 (Koma Kirin Sente False)
        , Cell 2 1 (Koma Lion Gote False)
        , Cell 2 2 (Koma Hiyoko Gote False)
        , Cell 2 3 (Koma Hiyoko Sente False)
        , Cell 2 4 (Koma Lion Sente False)
        , Cell 3 1 (Koma Kirin Gote False)
        , Cell 3 2 (Koma Emp Sente False)
        , Cell 3 3 (Koma Emp Sente False)
        , Cell 3 4 (Koma Zou Sente False)
        ]



-- UPDATE


type Msg
    = Touch


update : Msg -> Ban -> Ban
update msg ban =
    ban



{- case msg of
   Touch ->
       if ban.cell.koma.komashu == Kirin then
           "王"

       else
           "飛"
-}
-- VIEW


view : Ban -> Html Msg
view ban =
    div []
        [ tr []
            [ th [] [ button [] [ text (getText 8 ban) ] ]
            , th [] [ button [] [ text (getText 4 ban) ] ]
            , th [] [ button [] [ text (getText 0 ban) ] ]
            ]
        , tr
            []
            [ th [] [ button [] [ text (getText 9 ban) ] ]
            , th [] [ button [] [ text (getText 5 ban) ] ]
            , th [] [ button [] [ text (getText 1 ban) ] ]
            ]
        , tr
            []
            [ th [] [ button [] [ text (getText 10 ban) ] ]
            , th [] [ button [] [ text (getText 6 ban) ] ]
            , th [] [ button [] [ text (getText 2 ban) ] ]
            ]
        , tr
            []
            [ th [] [ button [] [ text (getText 11 ban) ] ]
            , th [] [ button [] [ text (getText 7 ban) ] ]
            , th [] [ button [] [ text (getText 3 ban) ] ]
            ]
        ]
