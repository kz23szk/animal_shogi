module Main exposing (main, myElement, myRowOfStuff)

import Element exposing (Element, alignRight, centerY, column, el, fill, padding, rgb255, rotate, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font



-- import Style exposing (..)
-- import Element exposing(..)


main =
    Element.layout []
        myRowOfStuff


myRowOfStuff =
    row [ centerY, spacing 2 ]
        [ column [ width fill, centerY, spacing 2 ]
            [ myElement
            , myElement

            -- , el [ alignRight ] myElement
            , myElement
            , myElement
            ]
        , column [ width fill, centerY, spacing 2 ]
            [ myElement
            , myElement

            -- , el [ alignRight ] myElement
            , myElement
            , myElement
            ]
        , column [ width fill, centerY, spacing 2 ]
            [ myElement
            , myElement

            -- , el [ alignRight ] myElement
            , myElement
            , myElement
            ]
        ]



{- row [ width fill, centerY, spacing 2 ]
    [ myElement
    , myElement
    -- , el [ alignRight ] myElement
   ,  myElement
    ]
-}


myElement : Element msg
myElement =
    el
        [ Background.color (rgb255 240 0 245)
        , Font.color (rgb255 255 255 255)
        , Border.rounded 3
        , padding 13
        , rotate ((180 * 3.14) / 180)
        ]
        (text "歩")
