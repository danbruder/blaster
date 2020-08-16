module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



---- MODEL ----


type alias Model =
    { coords : ( Int, Int )
    , scale : Float
    }


init : ( Model, Cmd Msg )
init =
    ( { coords = ( 0, 0 ), scale = 1 }, Cmd.none )



---- UPDATE ----


type Msg
    = LaunchButtonClicked
    | LandButtonClicked
    | ClickedBigger
    | ClickedSmaller


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



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div [ style "display" "flex", style "position" "relative", style "flex-direction" "column", style "align-items" "center", style "justify-content" "flex-end", style "height" "100vh" ]
            [ img
                [ style "position" "absolute"
                , style "bottom" ((model.coords |> Tuple.first |> String.fromInt) ++ "px")
                , style "left" ((model.coords |> Tuple.second |> String.fromInt) ++ "px")
                , style "transition" "bottom 0.8s ease-in-out 0.1s"
                , style "transform" ("scale(" ++ String.fromFloat model.scale ++ ")")
                , src "/rocket.png"
                ]
                []
            , div
                [ style "z-index" "10" ]
                [ button [ onClick LaunchButtonClicked, style "background-color" "green", style "color" "white", style "padding" "20px 30px", style "font-size" "20px", style "font-weight" "bold", style "border-radius" "10px" ] [ text "blast off" ]
                , button [ onClick LandButtonClicked, style "background-color" "red", style "color" "white", style "padding" "20px 30px", style "font-size" "20px", style "font-weight" "bold", style "border-radius" "10px" ] [ text "come home" ]
                , button [ onClick ClickedBigger, style "background-color" "blue", style "color" "white", style "padding" "20px 30px", style "font-size" "20px", style "font-weight" "bold", style "border-radius" "10px" ] [ text "BIGGER" ]
                , button [ onClick ClickedSmaller, style "background-color" "yellow", style "color" "black", style "padding" "20px 30px", style "font-size" "20px", style "font-weight" "bold", style "border-radius" "10px" ] [ text "SMALLER" ]
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
