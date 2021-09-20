defmodule H do

  def sanitize_params(map) do
    for {key, val} <- map, into: %{}, do: {String.to_atom(key), val}
  end
end