defmodule Api.Repo.Migrations.CreateChickenRunners do
  use Ecto.Migration

  def change do
    create table(:chicken_runners, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :approved_account, :string
      add :asset, :map
      add :auction_type, :string
      add :bid_amount, :string
      add :collection_slug, :string
      add :contract_address, :string
      add :created_date, :utc_datetime
      add :custom_event_name, :string
      add :dev_fee_payment_event, :string
      add :duration, :string
      add :ending_price, :string
      add :event_type, :string
      add :from_account, :map
      add :event_id, :integer
      add :owner_account, :string
      add :payment_token, :map
      add :quantity, :string
      add :starting_price, :string
      add :total_price, :string
      add :transaction, :string
      add :gender, :string
      add :heritage, :string
      add :talent, :string
      add :background, :string
      add :basebody, :string
      add :combcolor, :string
      add :eyestype, :string
      add :wattlecolor, :string
      add :perfection, :integer
      timestamps()
    end
    create unique_index(:chicken_runners, [:event_id])
  end
end
