---
title: 'Modeling and Programming 2018-1: Seventh lab practice'
author:
- Luis Daniel Aragon Bermudez 416041271 
date: November 7th, 2017
geometry: margin=2cm
lan: en
toc: True
toc-depth: 6
colorlinks: True
---
# Stern-Brocot Representation  {#introduction}

This is a commandline game based on the classic memory game ["concentration"](<https://en.wikipedia.org/wiki/Concentration_(game)>). It is written in python 3.6.2, type annotations and literal string interpolation are only supported by python 3.6+, so please be weary of that.

## File tree  {#tree}

Next, we'll provide general information about the included files and packages, but please refer to the full documentation and source files for a more in-depth explanation:

### `src/`  {.unnumbered}

1. `clutil/` This package provides several command line utilities, including a regex matcher, inut validation and a configurable login panel.
2. `concentration.py` is the main file. It contains the concentration (game) client. Using the demo, users are able to log in, play and access their stats and new players can register and start playing. The demo is run as usual (`python src/concentration.py`).

### `local/`  {.unnumbered}

This directory may not be present before you run the program, it's the default location for generating the program's database.

## The game

Concentration is a classic memory game wherein players (usually two) compete against each other for the most pairs found. However, our version contemplates the solitarie rendition of this game: when a new game is started the cards are shuffled and displayed, the player has 5 seconds to memorize the pairs before they are hidden, then the player has to match the cards using their coorindates. A player tryin to match a pair can't:

- Select the same card twice.
- Select a card that's already been matched.
- Select coordinates outside the board.

If the player fails to match a pair three times, the game ends and the player loses. The game is won when all the pairs have been found.

## The login panel

The included panel is really simplistic and makes no safety or privacy guarantees. When a login panel is run it displays three options: login, register and exit, which are self-explanatory. The default regex for usernames and strong passowrds can be visualized in the following figures:

![Railroad Diagram of the regular expression that represents a valid username.](../../@Resources/username.png)

![Railroad Diagram of the regular expression that represents a strong password.](../../@Resources/password.png)

## Acknowledgements  {#acknowledgements}

For more information on the tools used to build, create and run this program refer to the following links:

- [SQLite](http://sqlite.org/) was used for the game's database.
- [Python](https://www.python.org/) was used to write the logic of the game, as well as the commandline app.
- [Regular expressions](https://en.wikipedia.org/wiki/Regular_expression) were used to validate and generate correct input.
- [REGEXPER](https://regexper.com) was used to generate the Railroad Diagrams used in this document.