module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



---- MODEL ----


type alias Model =
    ( Int, Int )


init : ( Model, Cmd Msg )
init =
    ( ( 0, 0 ), Cmd.none )



---- UPDATE ----


type Msg
    = LaunchButtonClicked
    | LandButtonClicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LaunchButtonClicked ->
            ( ( 1200, 0 ), Cmd.none )

        LandButtonClicked ->
            ( ( 0, 0 ), Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div [ style "display" "flex", style "position" "relative", style "flex-direction" "column", style "align-items" "center", style "justify-content" "flex-end", style "height" "100vh" ]
            [ img
                [ style "position" "absolute"
                , style "bottom" ((Tuple.first model |> String.fromInt) ++ "px")
                , style "left" ((Tuple.second model |> String.fromInt) ++ "px")
                , style "transition" "bottom 1s ease-out 0.5s"
                , src "/rocket.jpg"
                ]
                []
            , button [ onClick LaunchButtonClicked, style "background-color" "green", style "color" "white", style "padding" "20px 30px", style "font-size" "20px", style "font-weight" "bold", style "border-radius" "10px" ] [ text "blast off" ]
            , button [ onClick LandButtonClicked, style "background-color" "red", style "color" "white", style "padding" "20px 30px", style "font-size" "20px", style "font-weight" "bold", style "border-radius" "10px" ] [ text "come home" ]
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
