defmodule Background.OpenSeas do

  def fetch_data(collection,  limit)do
    build_uri(collection, limit)
    |> process_request()
    |> Jason.decode!()
  end

  def process_request(uri)do
    case HTTPoison.get uri, [{"Content-Type", "application/json"}] do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body
      _ -> %{} |> Jason.encode!()
    end
  end

  def build_uri(collection, limit), do:
   "https://api.opensea.io/api/v1/events?collection_slug=#{collection}&only_opensea=false&offset=0&limit=#{limit}"

  end
