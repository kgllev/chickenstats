defmodule ApiWeb.ChickenDerby.ChickenRunnerView do
  use ApiWeb, :view
  alias ApiWeb.ChickenDerby.ChickenRunnerView

  def render("index.json", %{chicken_runners: chicken_runners, stats: stats}) do
    %{data: render_many(chicken_runners, ChickenRunnerView, "chicken_runner.json"), stats: stats}
  end

  def render("show.json", %{chicken_runner: chicken_runner}) do
    %{data: render_one(chicken_runner, ChickenRunnerView, "chicken_runner.json")}
  end

  def render("chicken_runner.json", %{chicken_runner: chicken_runner}) do
    %{
      id: chicken_runner.id,
      approved_account: chicken_runner.approved_account,
      asset: chicken_runner.asset,
      auction_type: chicken_runner.auction_type,
      bid_amount: chicken_runner.bid_amount,
      collection_slug: chicken_runner.collection_slug,
      contract_address: chicken_runner.contract_address,
      created_date: chicken_runner.created_date,
      custom_event_name: chicken_runner.custom_event_name,
      dev_fee_payment_event: chicken_runner.dev_fee_payment_event,
      duration: chicken_runner.duration,
      ending_price: chicken_runner.ending_price,
      event_type: chicken_runner.event_type,
      from_account: chicken_runner.from_account,
      event_id: chicken_runner.event_id,
      owner_account: chicken_runner.owner_account,
      payment_token: chicken_runner.payment_token,
      quantity: chicken_runner.quantity,
      starting_price: chicken_runner.starting_price,
      total_price: chicken_runner.total_price,
      perfection: chicken_runner.perfection,
      gender: chicken_runner.gender,
      heritage: chicken_runner.heritage,
      talent: chicken_runner.talent,
      background: chicken_runner.background,
      basebody: chicken_runner.basebody,
      combcolor: chicken_runner.combcolor,
      eyestype: chicken_runner.eyestype,
      wattlecolor: chicken_runner.wattlecolor

    }
  end
end
