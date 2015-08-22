defmodule ContactApi.V1.CustomerView do
  use ContactApi.Web, :view

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, ContactApi.V1.CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, ContactApi.V1.CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id,
      name: customer.name,
      phone: customer.phone,
      gender: customer.gender,
      hobby: customer.hobby,
      blood: customer.blood,
      description: customer.description}
  end
end
