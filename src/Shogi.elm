module Shogi exposing (Koma, Komadai, Komashu(..), Masu, Sengo(..))

-- 駒やマス目の状態
-- Emp:空マス


type alias Masu =
    { suji : Int
    , dan : Int
    , koma : Koma
    }


type alias Komadai =
    { komashu : Komashu
    , sengo : Sengo
    , count : Int
    }


type alias Koma =
    { komashu : Komashu
    , sengo : Sengo
    , nari : Bool
    }


type Komashu
    = Emp
    | Fu
    | Kyo
    | Kei
    | Gin
    | Kin
    | Kaku
    | Hisha
    | Gyoku


type Sengo
    = Sente
    | Gote



-- type Nari : Bool
