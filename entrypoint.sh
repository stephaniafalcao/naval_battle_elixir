#!/bin/bash
mix local.hex --force
mix archive.install hex phx_new 1.5.9 --force
mix local.rebar --force # pesquisar
mix deps.get 
mix phx.server
