path = /home/cource/Code/elm/personalWebsite

web: sass elm

elm: format
	elm make $(path)/src/Main.elm --output=$(path)/elm.js

format:
	elm-format --yes $(path)/src/

sass:
	sass $(path)/css:$(path)/
