port module Ports exposing (..)

import Json.Decode exposing (Value)
import Domain


port incomingDomainUpdate : (Value -> msg) -> Sub msg


port outgoingDomainUpdate : Domain.Diff -> Cmd msg
