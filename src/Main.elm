module Main exposing (main)

import Browser
import Element
import Element.Font as Font
import FormatNumber as Fn
import FormatNumber.Locales exposing (Decimals(..))
import Html
import Time


main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Time.millisToPosix 0, Cmd.none )


type Msg
    = TheTime Time.Posix


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 20 TheTime


type alias Model =
    Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update (TheTime t) model =
    ( t, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = prettyTime model
    , body = [ Element.layout [] (viewHelp model) ]
    }


prettyTime : Time.Posix -> String
prettyTime t =
    let
        millis =
            toFloat <| Time.posixToMillis t

        millisInDay =
            24 * 60 * 60 * 1000

        days =
            millis / millisInDay
    in
        prettyFloat days
    


viewHelp : Model -> Element.Element Msg
viewHelp model =
    Element.el
        [ Element.width <| Element.fill
        , Element.height <| Element.fill
        ]
    <|
        Element.el
            [ Font.family [ Font.monospace ]
            , Font.size 100
            , Element.centerX
            , Element.centerY
            ]
            (Element.text <| prettyTime model)


prettyFloat : Float -> String
prettyFloat f =
    Fn.format format f


format =
    { decimals = Exact 5
    , thousandSeparator = ","
    , decimalSeparator = "."
    , negativePrefix = "-"
    , negativeSuffix = ""
    , positivePrefix = ""
    , positiveSuffix = ""
    , zeroPrefix = ""
    , zeroSuffix = ""
    }
