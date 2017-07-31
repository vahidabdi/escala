defmodule EscalaApiWeb.Router do
  use EscalaApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EscalaApiWeb do
    pipe_through :api
  end
end
