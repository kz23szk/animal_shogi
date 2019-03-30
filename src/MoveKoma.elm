module MoveKoma exposing(main)

-- Array2D?
import Array exposing(Array)
import Browser
import Dict exposing (Dict)
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
    Browser.document
        { init = init
        , view = \model -> { title = "どうぶつしょうぎ", body = [ view model ] }
        , update = update
        , subscriptions = subscriptions
        }

-- MODEL

type alias Model =
    { board : Board
    , size : ( Int, Int )
    , score : Int
    , state : GameState
    , nextId : Int
    }

type GameState
    = Playing 
    | Won
    | Over

type alias Board = 
    List AnimationCell

type alias Cell =
    { position : Position -- マスの位置
    , num : Int -- 本来は駒の種類
    , id : String 
    }

{-
type AnimationCell
    = ShowUpCell Cell
    | MoveCell Cell
    | MergeCell Cell ( Cell, Cell)
-}
type alias Postion = 
    ( Int, Int)

init : () -> ( Model, Cmd Msg)
init _ =
    ( { board = []
      , size = ( 3, 4 )
      , score = 0
      , state = Playing
      , nextId = 0
      }
    , _
    )

-- UPDATE


-- VIEW

view : Model -> Html Msg
view model = 
    layout [ Font.family [ Font.typeface "Consolas"] ] <|
        column [ spacing 20, padding 20 ]
            [ viewBoard model]

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
                    (viewEmptyCells size ++ viewAnimationCells board)


viewAnimationCells : List AnimationCell -> List ( String, Element msg )
viewAnimationCells animationCells =
    List.concatMap viewAnimationCell animationCells


viewAnimationCell : AnimationCell -> List ( String, Element msg )
viewAnimationCell animationCell =
    case animationCell of
        ShowUpCell cell ->
            [ ( cell.id, lazy4 positionHelp "" "showup" cell.position cell.num ) ]

        MoveCell cell ->
            [ ( cell.id, lazy4 positionHelp "move" "" cell.position cell.num ) ]

        MergeCell cell ( cell1, cell2 ) ->
            [ ( cell.id, lazy4 positionHelp "merge" "showup" cell.position cell.num )
            , ( cell1.id, lazy4 positionHelp "move" "shrink" cell.position cell1.num )
            , ( cell2.id, lazy4 positionHelp "move" "shrink" cell.position cell2.num )
            ]


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

                4 ->
                    rgb255 248 252 223

                8 ->
                    rgb255 243 190 152

                16 ->
                    rgb255 234 162 109

                32 ->
                    rgb255 245 156 135

                64 ->
                    rgb255 255 97 61

                128 ->
                    rgb255 238 229 161

                256 ->
                    rgb255 245 231 132

                512 ->
                    rgb255 228 214 111

                1024 ->
                    rgb255 224 195 88

                2048 ->
                    rgb255 196 224 88

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


viewResult : GameState -> Element msg
viewResult state =
    case state of
        Won ->
            text "You win!"

        Over ->
            text "Game over!"

        Playing ->
            none


viewScore : Int -> Element msg
viewScore score =
    el
        [ Border.rounded 10
        , padding 10
        , Font.size 20
        , Background.color <| rgb255 187 187 187
        ]
    <|
        text <|
            "Score: "
                ++ String.fromInt score


class : String -> Attribute msg
class =
    htmlAttribute << Html.Attributes.class
