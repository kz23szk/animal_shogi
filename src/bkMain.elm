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
    layout [] <|
        column [ spacing 20, padding 20 ]
            [ -- viewScore model.state
              -- ,
              viewBoard model

            -- , viewResult model.state
            ]


viewBoard : Model -> Element msg
viewBoard { size, board } =
    let
        ( w, h ) =
            size
    in
    Keyed.column
        [ Border.rounded 10
        , Background.color <| rgb255 187 187 187
        , width <| px <| w * 50 + (w - 1) * 5 + 20
        , height <| px <| h * 50 + (h - 1) * 5 + 20
        , padding 10
        ]
    <|
        List.reverse <|
            List.sortBy Tuple.first <|
                List.map (Tuple.mapSecond <| el [ width <| px 0, height <| px 0 ])
                    (viewEmptyCells size)


positionHelp : String -> String -> Position -> Int -> Element msg
positionHelp moveClass cellClass ( i, j ) num =
    el
        [ moveRight <| toFloat <| i * 55
        , moveDown <| toFloat <| j * 55
        , class moveClass
        ]
    <|
        lazy2 viewCell cellClass num


viewCell : String -> Int -> Element msg
viewCell cls num =
    column
        [ class cls
        , width <| px 50
        , height <| px 50
        , Border.rounded 5
        , Font.size 24
        , Background.color <|
            case num of
                2 ->
                    rgb255 238 238 238

                _ ->
                    rgb255 100 100 100
        , Font.color <|
            if num == 2 || num == 4 then
                rgb255 34 34 34

            else
                rgb255 250 250 250
        ]
        [ el [ centerX, centerY ] <| text (String.fromInt num) ]


viewEmptyCells : ( Int, Int ) -> List ( String, Element msg )
viewEmptyCells ( w, h ) =
    List.range 0 (h - 1)
        |> List.concatMap
            (\j ->
                List.range 0 (w - 1)
                    |> List.map
                        (\i ->
                            ( "empty" ++ String.fromInt i ++ "_" ++ String.fromInt j
                            , el
                                [ width <| px 50
                                , height <| px 50
                                , Border.rounded 5
                                , Background.color <| rgb255 204 204 204
                                , moveRight <| toFloat <| i * 55
                                , moveDown <| toFloat <| j * 55
                                ]
                                none
                            )
                        )
            )


class : String -> Attribute msg
class =
    htmlAttribute << Html.Attributes.class
