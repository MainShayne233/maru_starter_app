defmodule MaruStarterApp.Router.Homepage do
  use Maru.Router

  namespace :api do
    namespace :v1 do
      get do
        json(conn, %{ hello: :world })
      end
    end
  end


end

defmodule MaruStarterApp.API do
  use Maru.Router

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]

  mount MaruStarterApp.Router.Homepage

  rescue_from :all do
    conn
    |> put_status(500)
    |> text("Server Error")
  end
end
