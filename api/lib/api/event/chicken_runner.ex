defmodule Api.Event.ChickenRunner do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "chicken_runners" do
    field :approved_account, :string
    field :asset, :map
    field :auction_type, :string
    field :bid_amount, :string
    field :collection_slug, :string
    field :contract_address, :string
    field :created_date, :utc_datetime
    field :custom_event_name, :string
    field :dev_fee_payment_event, :string
    field :duration, :string
    field :ending_price, :string
    field :event_type, :string
    field :from_account, :map
    field :event_id, :integer
    field :owner_account, :string
    field :payment_token, :map
    field :quantity, :string
    field :starting_price, :string
    field :total_price, :string
    field :transaction, :string
    field :gender, :string
    field :heritage, :string
    field :talent, :string
    field :background, :string
    field :basebody, :string
    field :combcolor, :string
    field :eyestype, :string
    field :wattlecolor, :string
    field :perfection, :integer
    timestamps()
  end

  @doc false
  def changeset(chicken_runner, attrs) do
    chicken_runner
    |> cast(
         attrs,
         [
           :approved_account,
           :asset,
           :auction_type,
           :bid_amount,
           :collection_slug,
           :contract_address,
           :created_date,
           :custom_event_name,
           :dev_fee_payment_event,
           :duration,
           :ending_price,
           :event_type,
           :from_account,
           :event_id,
           :owner_account,
           :payment_token,
           :quantity,
           :starting_price,
           :total_price,
           :transaction,
           :gender,
           :heritage,
           :talent,
           :background,
           :basebody,
           :combcolor,
           :eyestype,
           :wattlecolor,
           :perfection
         ]
       )
    |> validate_required([:event_id])
  end
end
