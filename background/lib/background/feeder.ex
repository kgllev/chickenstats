defmodule Background.Feeder do
  alias Background.Scrapper

  def seed_chicken_runner(%{"asset_events" => data})do
    data
    |> Enum.each(
         fn %{
              "id" => id,
              "asset" => %{
                "permalink" => permalink
              }
            } = runner ->

           runner = runner
                    |> Map.merge(%{"event_id" => id})
                    |> Map.delete("id")
                    |> Map.merge(Scrapper.entry(permalink))

           params =   %{"chicken_runner" => runner} |> Jason.encode!()
           url = "http://api.chickenstats.com/api/chicken-derby"
           HTTPoison.post url, params, [{"Content-Type", "application/json"}]
           :ok
         end
       )
  end
  def seed_chicken_runner(_)do
    nil
  end
end
