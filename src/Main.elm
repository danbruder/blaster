module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



---- MODEL ----


type alias Model =
    { coords : ( Int, Int )
    , scale : Float
    , temperature : Float
    }


init : ( Model, Cmd Msg )
init =
    ( { coords = ( 0, 0 ), scale = 1, temperature = 0.0 }, Cmd.none )



---- UPDATE ----


type Msg
    = LaunchButtonClicked
    | LandButtonClicked
    | ClickedBigger
    | ClickedSmaller
    | ClickedHotter Float
    | ClickedColder Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LaunchButtonClicked ->
            ( { model | coords = ( 1200, 0 ) }, Cmd.none )

        LandButtonClicked ->
            ( { model | coords = ( 0, 0 ) }, Cmd.none )

        ClickedBigger ->
            ( { model | scale = model.scale * 1.5 }, Cmd.none )

        ClickedSmaller ->
            ( { model | scale = model.scale * 0.5 }, Cmd.none )

        ClickedHotter scale ->
            ( { model | temperature = model.temperature + scale }, Cmd.none )

        ClickedColder scale ->
            ( { model | temperature = model.temperature - scale }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        control msg txt color =
            button [ class (color ++ " p-4 rounded text-xl uppercase text-white"), onClick msg ] [ text txt ]
    in
    div []
        [ div [ class "h-screen flex flex-row" ]
            [ div [ class "border-r border-gray-100 w-64" ]
                [ img
                    [ style "position" "absolute"
                    , style "bottom" ((model.coords |> Tuple.first |> String.fromInt) ++ "px")
                    , style "left" ((model.coords |> Tuple.second |> String.fromInt) ++ "px")
                    , style "transition" "bottom 0.8s ease-in-out 0.1s"
                    , style "transform" ("scale(" ++ String.fromFloat model.scale ++ ")")
                    , src "/rocket.png"
                    ]
                    []
                ]
            , div
                [ style "z-index" "10", class "bg-gray-400 h-full w-full" ]
                [ div []
                    [ control ClickedBigger "Bigger" "bg-purple-500"
                    , control ClickedSmaller "Smaller" "bg-yellow-500"
                    , control (ClickedHotter 1) "Hotter" "bg-red-500 "
                    , control (ClickedColder 1) "Colder" "bg-blue-500"
                    , control (ClickedHotter 100) "WAY Hotter" "bg-red-700 "
                    , control (ClickedColder 100) "WAY Colder" "bg-blue-700"
                    , control LaunchButtonClicked "Launch" "bg-gray-900"
                    , control LandButtonClicked "Land" "bg-gray-600"
                    ]
                , div [ style "font-size" "100px", class "flex justify-center items-center" ]
                    [ model.temperature |> String.fromFloat |> text
                    , span [] [ text "°F" ]
                    ]
                , div [ style "font-size" "100px", class "flex justify-center items-center" ]
                    [ ((model.temperature - 32.0) * 5 / 9) |> String.fromFloat |> text
                    , span [] [ text "°C" ]
                    ]
                ]
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
