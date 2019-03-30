module Animal exposing (Cell, Koma, Komashu(..), Sengo(..), getText)

import Array2D exposing (Array2D)



-- 駒やマス目の状態
-- Emp:空マス


type alias Cell =
    { suji : Int
    , dan : Int
    , koma : Koma
    }



{-
   -- 駒台はまだ
   type alias Komadai =
       { komashu : Komashu
       , sengo : Sengo
       , count : Int
       }
-}
-- こんな書き方できないかな？
{-
   type KomaOrEmp
       = Koma_ : Koma
       | Emp
-}


type alias Koma =
    { komashu : Komashu
    , sengo : Sengo
    , nari : Bool
    }


type Komashu
    = Emp
    | Lion
    | Kirin
    | Zou
    | Hiyoko
    | Niwatori


type Sengo
    = Sente
    | Gote



-- 画像を取り出したいがまずはテキストから


addone : Int -> Int
addone a =
    a + 1


getMoji : Maybe Cell -> String
getMoji cell =
    case cell of
        Just cell_ ->
            case cell_.koma.komashu of
                Emp ->
                    " "

                Lion ->
                    "王"

                Kirin ->
                    "キ"

                Zou ->
                    "ゾ"

                Hiyoko ->
                    "ヒ"

                Niwatori ->
                    "ニ"

        Nothing ->
            "x"


getText : Int -> Int -> Array2D Cell -> String
getText suji dan ban =
    getMoji (Array2D.get suji dan ban)



-- type Nari : Bool
