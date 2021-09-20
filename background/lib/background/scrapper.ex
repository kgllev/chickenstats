defmodule Background.Scrapper do
  def entry(url)do
    document = url
               |> fetch_document
               |> Floki.parse_document!()
    attributes =
      Task.async(
        fn ->
          document
          |> fetch_attribute_classes
          |> clean_attributes
          |> Enum.reject(&is_nil/1)
          |> Enum.uniq
        end
      )
    [perfection | _tail] =
      document
      |> fetch_perfection_classes
      |> clean_perfection

    b = %{}
    a = Task.await(attributes, :infinity)

    Enum.reduce(a, b, fn c, b -> b |> Map.merge(c)end) |> Map.merge(%{"perfection" =>  perfection})
  end

  def clean_perfection(attributes)do
    attributes
    |> Enum.map(
         fn {
              _,
              _,
              [perfection, _, _]
            }
         ->
           {perfection, ""} = Integer.parse(perfection)
           perfection
         end
       )
  end

  def fetch_perfection_classes(document)do
    document
    |> Floki.find("div.NumericTrait--value")
  end

  def clean_attributes(attributes)do
    attributes
    |> Enum.map(
         fn {
              _,
              _,
              [
                {_, _, [label]},
                {
                  _,
                  _,
                  [value]
                },
                _
              ]
            }
         ->
           attribs = [
             "Gender",
             "Heritage",
             "Talent",
             "BaseBody",
             "EyesType",
             "CombColor",
             "CombColor",
             "WattleColor",
             "Background"
           ]
           case label in attribs do
             true ->
               label = label
                       |> String.downcase()
               %{label => value}
             _ -> nil
           end

         end
       )
  end

  def fetch_attribute_classes(document)do
    document
    |> Floki.find("div.item--property")
  end

  def fetch_document(uri)do
    case HTTPoison.get uri, [{"Content-Type", "application/json"}] do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body
      _ ->
        %{}
        |> Jason.encode!()
    end
  end
end