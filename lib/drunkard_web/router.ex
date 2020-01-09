defmodule DrunkardWeb.Router do
  use DrunkardWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash

    plug Phoenix.LiveView.Flash

    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug DrunkardWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :unauthorized do
    plug :fetch_session
  end

  pipeline :authorized do
    plug :fetch_session

    plug Guardian.Plug.Pipeline,
      module: Drunkard.Guardian,
      error_handler: DrunkardWeb.AuthErrorController

    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/", DrunkardWeb do
    pipe_through :browser

    scope "/" do
      pipe_through :unauthorized

      live "/", LiveView.Page.Show

      # get "/login", SessionController, :new
      # post "/sessions/state", SessionController, :state

      live "/signup", LiveView.User.New

      live "/search", LiveView.Search.All
      live "/search/:value", LiveView.Search.All

      live "/ingredients/store", LiveView.Ingredient.Selector
      live "/ingredients/store/:user_uuid", LiveView.Ingredient.Selector

      live "/glasses/:uuid", LiveView.Glass.Show
      live "/ingredients/:uuid", LiveView.Ingredient.Show
      live "/recipes/:uuid", LiveView.Recipe.Show
    end

    # scope "/" do
    #   pipe_through :authorized

    #   live "/users/:uuid", LiveView.User.Show, session: [ Guardian.Plug.Keys.token_key() ]
    # end
  end

  # Other scopes may use custom stacks.
  # scope "/api", DrunkardWeb do
  #   pipe_through :api

  #   scope "/" do
  #     pipe_through :unauthorized

  #     resources "/glasses", GlassController
  #     resources "/ingredients", IngredientController
  #     resources "/recipes", RecipeController
  #     resources "/tags", TagController

  #     post "/sessions", SessionController, :create

  #     resources "/users", UserController, only: [:create]
  #   end

  #   scope "/" do
  #     pipe_through :authorized

  #     delete "/sessions", SessionController, :delete
  #     post "/sessions/refresh", SessionController, :refresh

  #     resources "/users", UserController, except: [:create]
  #   end
  # end
end
