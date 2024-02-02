module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, div, h1, img, text, p)
import Html.Attributes exposing (alt, class, href, src, style)
import Http
import Markdown
import Url
import Url.Parser exposing (Parser, parse, map, oneOf, s, top, string, (</>))

type Page
    = Home
    | Blog String
    | PageNotFound

pageFromUrl : Url.Url -> Page
pageFromUrl url =
    case parse pageParser url of
        Nothing -> PageNotFound
        Just page -> page

pageParser : Parser (Page -> a) a
pageParser =
    oneOf [ map Home top
          , map Blog (s "blog" </> string)
          ]

type FailableLoad a
    = Failure
    | Loading
    | Success a

type alias Model =
    { key : Nav.Key
    , page : Page
    , blogContent : FailableLoad String
    }

type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotBlogContent (Result Http.Error String)

main : Program () Model Msg
main = Browser.application
       { init = init
       , view = view
       , update = update
       , subscriptions = (\_ -> Sub.none)
       , onUrlRequest = LinkClicked
       , onUrlChange = UrlChanged
       }

init : () -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init _ url key =
    let pa = pageFromUrl url
    in (Model key pa Loading, blogCmd pa)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        LinkClicked urlReq ->
            case urlReq of
                Browser.Internal url ->
n                    (model, Nav.pushUrl model.key (Url.toString url))
                Browser.External href ->
                    (model, Nav.load href)
        UrlChanged url ->
            let pa = pageFromUrl url
            in ({model|page = pa}, blogCmd pa)
        GotBlogContent content ->
            ({model|blogContent =
                  case content of
                      Err _ -> Failure
                      Ok val -> Success val
             }, Cmd.none)

blogCmd : Page -> Cmd Msg
blogCmd pa =
    case pa of
        Blog blogId -> getBlog blogId
        _ -> Cmd.none

getBlog : String -> Cmd Msg
getBlog blogId =
    Http.get
        { url = "/assets/blogs/" ++ blogId ++ ".md"
        , expect  = Http.expectString GotBlogContent
        }




view : Model -> Browser.Document Msg
view model =
    { title = "Jeff's blog"
    , body =
        [ div [ class "app" ]
              [ logo
              , case model.page of
                  Home ->
                      div [ class "home" ]
                          [ hero
                          , portfolio testProjects
                          ]
                  Blog _ -> viewBlog model.blogContent
                  PageNotFound -> page404
              , footer
              ]
        ]
    }

page404 : Html msg
page404 = div [ class "404" ]
          [ h1 [] [text "404"]
          , p [] [text "Page Not Found"]
          ]

viewBlog : FailableLoad String -> Html msg
viewBlog status =
    case status of
        Failure -> page404
        Loading -> text "Loading Content..."
        Success content ->
            Markdown.toHtml [class "blog-content"] content

logo : Html msg
logo =
    div [ class "logo" ] [ img [ src "assets/svgs/J.svg", alt "logo" ] [] ]

hero : Html msg
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


portfolio : List ProjectInfo -> Html msg
portfolio projects =
    div [ class "projects" ]
        [ h1 [] [ text "Projects" ]
        , div [ class "description" ] [ text "Some stuff that I made" ]
        , div [ class "project-list" ] (List.map projectCard projects)
        ]


type alias Image =
    { path : String
    , alt : String
    }

type alias ProjectInfo =
    { name : String
    , description : String
    , image : Image
    , techs : List Image
    , link : String
    }

techImages =
    { figma = { path = "assets/svgs/figma.svg", alt = "figma" }
    , reactjs = { path = "assets/svgs/react.svg", alt = "reactjs" }
    , typescript = { path = "assets/svgs/typescript.svg", alt = "typescript" }
    }

testProjects : List ProjectInfo
testProjects =
    [ { name = "Shopfront"
      , description = "A simplified shop management system for supermarkets"
      , image = { path = "assets/images/shopfront.png", alt = "shopfront" }
      , techs = [ techImages.figma, techImages.reactjs ]
      , link = "#"
      }
    , { name = "VoteCamp"
      , description = "Political data collection utility for election campaigning."
      , image = { path = "assets/images/voteCamp.png", alt = "votecamp" }
      , techs = [ techImages.figma, techImages.reactjs, techImages.typescript ]
      , link = "#"
      }
    ]

projectCard : ProjectInfo -> Html msg
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

footer : Html msg
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
