# A clock that is just the number of days since the POSIX epoch.

It's a little web app, written in Elm.

# Build

The build is tested with Elm 0.19 (Elm is a programming language that compiles to Javascript). Install Elm from [https://guide.elm-lang.org/install/elm.html](here).

Clone this repository, run ```elm make src/Main.elm --optimize```. This generates a file called index.html that can be served from a web server.
