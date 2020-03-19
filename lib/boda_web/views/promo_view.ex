defmodule BodaWeb.PromoView do
  use BodaWeb, :view
  alias BodaWeb.PromoView

  def render("index.json", %{promos: promos}) do
    %{data: render_many(promos, PromoView, "promo.json")}
  end

  def render("show.json", %{promo: promo}) do
    %{data: render_one(promo, PromoView, "promo.json")}
  end

  def render("promo.json", %{promo: promo}) do
    %{
      id: promo.id,
      code: promo.code,
      amount: promo.amount,
      expiry_date: promo.expiry_date,
      is_expired: promo.is_expired,
      is_active: promo.is_active,
      radius: promo.radius
    }
  end

  def render("details.json", %{promo: promo, polyline: polyline}) do
    %{
      promo: %{
        id: promo.id,
        code: promo.code,
        amount: promo.amount,
        expiry_date: promo.expiry_date,
        is_expired: promo.is_expired,
        is_active: promo.is_active,
        radius: promo.radius
      },
      polyline: polyline
    }
  end
end
