defmodule Background.Jobs do
  alias Background.OpenSeas
  alias Background.Feeder


  def handle_request(:chicken_derby, limit)do
    "chicken-derby"
     |> OpenSeas.fetch_data(limit)
    |> Feeder.seed_chicken_runner()
  end
end