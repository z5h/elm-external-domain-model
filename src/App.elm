module App exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Domain
import Ports


type UIState
    = Error
    | NoError


type alias Model =
    { uiState : UIState
    , domainModel : Domain.Model
    }


initModel : Model
initModel =
    Model NoError Domain.init


type Message
    = Noop
    | DomainUpdate Domain.Update
    | Incr


main : Program Never Model Message
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Message )
init =
    ( initModel, Cmd.none )


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        Noop ->
            model ! []

        DomainUpdate domainUpdate ->
            { model | domainModel = Domain.applyUpdate domainUpdate model.domainModel } ! []

        Incr ->
            let
                maybeCmd =
                    Domain.incr model.domainModel
                        |> Maybe.map Ports.outgoingDomainUpdate
            in
                case maybeCmd of
                    Just cmd ->
                        { model | uiState = NoError } ! [ cmd ]

                    Nothing ->
                        { model | uiState = Error } ! []


subscriptions : Model -> Sub Message
subscriptions model =
    Ports.incomingDomainUpdate
        (Domain.decodeUpdate
            >> Maybe.map DomainUpdate
            >> Maybe.withDefault Noop
        )


view : Model -> Html Message
view model =
    div []
        [ button [ onClick Incr ] [ text "+" ]
        , br [] []
        , text (Domain.modelToString model.domainModel)
        , br [] []
        , text <|
            case model.uiState of
                Error ->
                    "Error"

                NoError ->
                    "Ok"
        ]
