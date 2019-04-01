module Main exposing (main)

import Animal exposing (..)
import Array exposing (Array)
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
    , size : BoardSize -- マス目の縦横
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
    List Cell



-- Array2D Cell


type AnimationCell
    = ShowUpCell Cell
    | MoveCell Cell
    | MergeCell Cell ( Cell, Cell )


type alias BoardSize =
    { w : Suji
    , h : Dan
    }



-- マス目の情報


type alias Cell =
    { position : Position
    , koma : Koma
    }


type alias Position =
    -- 筋、段と分けたほうがいいのか？
    { suji : Suji
    , dan : Dan
    }


type alias Suji =
    Int


type alias Dan =
    Int


init : Model
init =
    { board =
        [ Cell (Position 1 1) (Koma Zou Gote False)
        , Cell (Position 1 2) (Koma Emp Gote False)
        , Cell (Position 1 3) (Koma Emp Gote False)
        , Cell (Position 1 4) (Koma Kirin Sente False)
        , Cell (Position 2 1) (Koma Lion Gote False)
        , Cell (Position 2 2) (Koma Hiyoko Gote False)
        , Cell (Position 2 3) (Koma Hiyoko Sente False)
        , Cell (Position 2 4) (Koma Lion Sente False)
        , Cell (Position 3 1) (Koma Kirin Gote False)
        , Cell (Position 3 2) (Koma Emp Sente False)
        , Cell (Position 3 3) (Koma Emp Sente False)
        , Cell (Position 3 4) (Koma Zou Sente False)
        ]
    , size = BoardSize 3 4
    , state = Playing
    }



-- UPDATE
-- まだ未着手、何もしていない


type Msg
    = Touch


update : Msg -> Model -> Model
update msg model =
    model



-- VIEW


view : Model -> Html Msg
view model =
    layout [] <|
        column
            [ spacing 20, padding 20 ]
            [ viewBoard model
            , text "手番：先手"
            ]


viewBoard : Model -> Element msg
viewBoard { size, board } =
    column
        [ Border.rounded 10
        , Background.color (rgb255 187 187 187)
        , width (px 200)
        , height (px 400)
        , padding 10
        ]
        [ text "歩"
        , text "飛"
        ]
