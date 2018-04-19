module Domain
    exposing
        ( Model
        , Diff
        , decodeUpdate
        , init
        , incr
        , Update
        , applyUpdate
        , modelToString
        )

import Json.Decode as Decode


type Model
    = Model (Maybe Int)


modelToString : Model -> String
modelToString (Model maybeValue) =
    case maybeValue of
        Just int ->
            toString int

        Nothing ->
            "uninitialized"


type Update
    = Update Int


type alias Diff =
    { pre : Int, post : Int }


decodeUpdate : Decode.Value -> Maybe Update
decodeUpdate value =
    value
        |> Decode.decodeValue Decode.int
        |> Result.toMaybe
        |> Maybe.map Update


init : Model
init =
    Model Nothing


applyUpdate : Update -> Model -> Model
applyUpdate (Update value) _ =
    Model (Just value)


incr : Model -> Maybe Diff
incr (Model maybeValue) =
    maybeValue
        |> Maybe.map (\value -> { pre = value, post = value + 1 })
