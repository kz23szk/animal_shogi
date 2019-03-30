module Main exposing (main)

import Animal exposing (..)
import Array2D exposing (..)
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Keyed as Keyed
import Element.Lazy exposing (lazy, lazy2, lazy4, lazy5)
import Html exposing (Html)
import Html.Attributes


main : Program () Model Msg
main =
    -- 通信対戦できるようにするにはBrowser.elementにする必要あり
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- Model


type alias Model =
    { board : Board -- マス目の情報 Array2dのほうが良い？
    , size : ( Int, Int ) -- マス目の縦横
    , state : GameState

    -- 持ち駒や着手中の駒などの状態もある
    }


type GameState
    = Playing
    | Wait
    | Won
    | Loose
    | Sennichite


type alias Board =
    Array2D Cell



-- マス目の情報


type alias Cell =
    { position : Position
    , koma : Koma
    }


type alias Position =
    -- 筋、段と分けたほうがいいのか？
    ( Int, Int )


init : Model
init =
    { board =
        Array2D.fromList
            [ [ Cell ( 1, 1 ) (Koma Zou Gote False)
              , Cell ( 1, 2 ) (Koma Emp Gote False)
              , Cell ( 1, 3 ) (Koma Emp Gote False)
              , Cell ( 1, 4 ) (Koma Kirin Sente False)
              ]
            , [ Cell ( 2, 1 ) (Koma Lion Gote False)
              , Cell ( 2, 2 ) (Koma Hiyoko Gote False)
              , Cell ( 2, 3 ) (Koma Hiyoko Sente False)
              , Cell ( 2, 4 ) (Koma Lion Sente False)
              ]
            , [ Cell ( 3, 1 ) (Koma Kirin Gote False)
              , Cell ( 3, 2 ) (Koma Emp Sente False)
              , Cell ( 3, 3 ) (Koma Emp Sente False)
              , Cell ( 3, 4 ) (Koma Zou Sente False)
              ]
            ]
    , size = ( 3, 4 )
    , state = Playing
    }



-- UPDATE
-- まだ未着手、何もしていない


type Msg
    = Touch


update : Msg -> Model -> Model
update msg model =
    model



{- case msg of
   Touch ->
       if ban.cell.koma.komashu == Kirin then
           "王"

       else
           "飛"
-}
-- VIEW
-- view : Model -> Html Msg
{- view ban =
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
-}


view : Model -> Html Msg
view model =
    Element.layout []
        displayBoard
        model


displayBoard : Model -> Element Msg
displayBoard model =
    row [ centerY, spacing 2 ]
        [ columns [ width fill, centerY, spacing 2 ]
            [ komaElement model 1 1
            , komaElement model 1 2
            ]
        ]


komaElement : Model -> Int -> Int -> Element Msg
komaElement model suji dan =
    el
        [ Background.color (rgb255 240 0 245)
        , Font.color (rgb255 255 255 255)
        , Border.rounded 3
        , padding 13
        , rotate ((180 * 3.14) / 180)
        ]
        (text (getText suji dan model.board))
