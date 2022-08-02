module Main exposing (..)

import Browser
import Html exposing (Html, a, div, img, text)
import Html.Attributes exposing (alt, class, href, src, style)


type alias Image =
    { path : String
    , alt : String
    }


type alias Project =
    { name : String
    , description : String
    , image : Image
    , techs : List Image
    , link : String
    }


testProjects : List Project
testProjects =
    [ { name = "Shopfront"
      , description = "A simplified shop management system for supermarkets"
      , image = { path = "assets/images/shopfront.png", alt = "shopfront" }
      , techs = [ { path = "assets/svgs/figma.svg", alt = "figma" }, { path = "assets/svgs/react.svg", alt = "reactjs" } ]
      , link = "#"
      }
    , { name = "VoteCamp"
      , description = "Political data collection utility for election campaigning."
      , image = { path = "assets/images/voteCamp.png", alt = "votecamp" }
      , techs = [ { path = "assets/svgs/figma.svg", alt = "figma" }, { path = "assets/svgs/react.svg", alt = "reactjs" }, { path = "assets/svgs/typescript.svg", alt = "typescript" } ]
      , link = "#"
      }
    ]


main =
    div [ class "home" ]
        [ hero
        , portfolio testProjects
        ]


hero =
    div [ class "hero" ]
        [ div [ class "center-text" ]
            [ text "Hi, I'm"
            , div [ class "title" ] [ text "Jeff Jacob Joy" ]
            , div [ class "details" ]
                [ div [ class "row" ]
                    [ text "= "
                    , div [ class "designer" ] [ text "Designer" ]
                    ]
                , text "| Programmer"
                ]
            ]
        , div [ class "buttons" ] []
        ]


portfolio : List Project -> Html msg
portfolio projects =
    div [ class "projects" ]
        [ div [ class "title" ] [ text "Projects" ]
        , div [ class "description" ] [ text "Some stuff that I made" ]
        , div [ class "project-list" ] (List.map projectCard projects)
        ]


projectCard : Project -> Html msg
projectCard project =
    a [ class "project-card", href project.link ]
        [ div [ class "project-details" ]
            [ div [ class "techs" ]
                (List.map
                    (\techIcon ->
                        img [ src techIcon.path, alt techIcon.alt ] []
                    )
                    project.techs
                )
            , div [ class "text" ]
                [ div [ class "name" ] [ text project.name ]
                , text project.description
                ]
            ]
        , div
            [ class "project-bg"
            , style "background" ("linear-gradient(90deg, #114642, transparent), url(" ++ project.image.path ++ ")")
            ]
            []
        ]
