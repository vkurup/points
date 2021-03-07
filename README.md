# Points


## About

This app serves an API endpoint that returns up to two users, each having a certain
number of points. Each user's points are updated each minute.


## Setup

* [Install](https://elixir-lang.org/install.html) Erlang (23.2.7) and Elixir (1.11.3).
* Install dependencies with `mix deps.get`
* Add a `config/dev.secret.exs` file to customize how the app will connect to your
  Postgresql DB. Here's what mine looks like, for Ubuntu:

  ```
  import Config

  config :points, Points.Repo,
    socket_dir: "/var/run/postgresql",
    username: "vkurup",
    password: ""
  ```
* Create and migrate your database with `mix ecto.setup`
* [OPTIONAL] Install Node.js dependencies with `npm install` inside the `assets` directory
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser to see the
JSON response from the API.

## Development

* Use `mix ecto.reset` to refresh your DB from scratch
* Use `./verify.sh` to format and test your code

## First time setup

Here are the steps I took to create this project, from a laptop that had [`asdf`
installed](https://github.com/asdf-vm/asdf), but with out-of-date versions of elixir and
erlang.

```
asdf update
asdf plugin update --all
asdf install erlang latest
asdf global erlang 23.2.7
asdf install elixir latest
asdf global elixir 1.11.3-otp-23
mix local.hex
mix archive.install hex phx_new
mix phx.new points
cd points
mix phx.gen.schema User users points:integer
```
