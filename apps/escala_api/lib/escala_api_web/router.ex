defmodule EscalaApiWeb.Router do
  use EscalaApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug EscalaApiWeb.Plug.Context
  end

  scope "/" do
    pipe_through :api

    forward "/gql", Absinthe.Plug.GraphiQL,
      schema: EscalaDb.Schema

    forward "/", Absinthe.Plug,
      schema: EscalaDb.Schema
  end
end
