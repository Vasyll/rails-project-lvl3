[![hexlet-check](https://github.com/Vasyll/rails-project-lvl3/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Vasyll/rails-project-lvl3/actions/workflows/hexlet-check.yml)
[![CI](https://github.com/Vasyll/rails-project-lvl3/actions/workflows/master.yml/badge.svg)](https://github.com/Vasyll/rails-project-lvl3/actions/workflows/master.yml)

# Bulletin board

The Bulletin board application allows users authorized through github to create and edit their listings and send them for moderation or archiving.

The administrator can view all users' listings, return them for moderation, publish them, or archive them. He can also appoint other users as administrators.

You can test the Bulletin board here: https://rails-project-lvl3-403793.herokuapp.com

# Installation

$ git clone https://github.com/Vasyll/rails-project-lvl3

$ make setup

You need to have administrator rights to fully test the application. To do this, edit the email (lowercase) and user name in db/seeds.rb 

$ bin/rails db:seed

In the root of the application, create an .env file, which you fill with data from Github Apps:
GITHUB_CLIENT_ID=
GITHUB_CLIENT_SECRET=

After that, start the server with the command:

$ bin/rails s

# Contributing and license

If you want to expand the functionality by adding blackjack or kittens, you can do it yourself or contact the author of this gem.
