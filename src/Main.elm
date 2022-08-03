module Main exposing (..)

import Browser
import Html exposing (Html, a, div, h1, img, text)
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
    div [ class "app" ]
        [ logo
        , div [ class "home" ]
            [ hero
            , portfolio testProjects
            ]
        , footer
        ]


logo =
    div [ class "logo" ] [ img [ src "assets/svgs/J.svg", alt "logo" ] [] ]


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
        [ h1 [] [ text "Projects" ]
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


footer =
    div [ class "footer" ]
        [ div [ class "nopyright" ]
            [ div [ class "name" ] [ text "ジエフ" ]
            , div [] [ text "The source of this website is open." ]
            , text "You can find it on: github.com/cource/cource.github.io"
            ]
        , div [ class "socials" ]
            (List.map
                (\social ->
                    a [ class "social", href social.link ]
                        [ img [ src social.image ] []
                        , text social.name
                        ]
                )
                [ { link = "https://github.com/cource"
                  , image = "assets/svgs/github.svg"
                  , name = "Github"
                  }
                , { link = "https://instagram.com/jeffjacobjoy"
                  , image = "assets/svgs/instagram.svg"
                  , name = "Instagram"
                  }
                ]
            )
        ]
