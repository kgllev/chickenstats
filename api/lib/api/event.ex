defmodule Api.Event do
  @moduledoc """
  The Event context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Event.ChickenRunner

  @doc """
  Returns the list of chicken_runners.

  ## Examples

      iex> list_chicken_runners()
      [%ChickenRunner{}, ...]

  """
  def list_chicken_runners(page, limit, filters) do
    %{"heritage" => heritage, "perfection" => %{"min" => min, "max" => max}, "talent" => talent} = filters |> Jason.decode!()


    from(c in ChickenRunner)
    |> build_heritage_query(heritage)
    |> build_talent_query(talent)
    |> where([c], c.perfection >= ^min)
    |> where([c], c.perfection <= ^max)
    |> order_by([c], desc: c.created_date)
    |> order_by(desc: :updated_at)
    |> Api.Pagination.page(page, [], per_page: limit)
  end

  defp build_heritage_query(query, heritage) do
    Enum.reduce(heritage, query, fn result, query ->
    query
    |> or_where([c], c.heritage == ^result)
    end)
  end

  defp build_talent_query(query, talent) do
    Enum.reduce(talent, query, fn result, query ->
      query
      |> or_where([c], c.talent == ^result)
    end)
  end

  def filter_dataset(query, heritage) do
    query
    |> order_by([c], desc: c.created_date)
  end


  defp  build_talent_query(query, talent)do
    query
  end

  @doc """
  Gets a single chicken_runner.

  Raises `Ecto.NoResultsError` if the Chicken runner does not exist.

  ## Examples

      iex> get_chicken_runner!(123)
      %ChickenRunner{}

      iex> get_chicken_runner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chicken_runner!(id), do: Repo.get!(ChickenRunner, id)

  def get_chicken_runner_by_event_id(event_id), do: Repo.get_by(ChickenRunner, %{event_id: event_id})

  @doc """
  Creates a chicken_runner.

  ## Examples

      iex> create_chicken_runner(%{field: value})
      {:ok, %ChickenRunner{}}

      iex> create_chicken_runner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chicken_runner(attrs \\ %{}) do
    %ChickenRunner{}
    |> ChickenRunner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a chicken_runner.

  ## Examples

      iex> update_chicken_runner(chicken_runner, %{field: new_value})
      {:ok, %ChickenRunner{}}

      iex> update_chicken_runner(chicken_runner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_chicken_runner(%ChickenRunner{} = chicken_runner, attrs) do
    chicken_runner
    |> ChickenRunner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a chicken_runner.

  ## Examples

      iex> delete_chicken_runner(chicken_runner)
      {:ok, %ChickenRunner{}}

      iex> delete_chicken_runner(chicken_runner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_chicken_runner(%ChickenRunner{} = chicken_runner) do
    Repo.delete(chicken_runner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking chicken_runner changes.

  ## Examples

      iex> change_chicken_runner(chicken_runner)
      %Ecto.Changeset{data: %ChickenRunner{}}

  """
  def change_chicken_runner(%ChickenRunner{} = chicken_runner, attrs \\ %{}) do
    ChickenRunner.changeset(chicken_runner, attrs)
  end
end
