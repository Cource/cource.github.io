#! /bin/sh

path="/home/cource/Code/elm/personalWebsite"

sass $path/css:$path/
elm-format $path/src/
elm make $path/src/Main.elm --output=$path/elm.js
