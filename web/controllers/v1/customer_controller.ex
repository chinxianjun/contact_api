defmodule ContactApi.V1.CustomerController do
  use ContactApi.Web, :controller

  alias ContactApi.Customer

  plug :scrub_params, "customer" when action in [:create, :update]

  def index(conn, _params) do
    customers = Repo.all(Customer)
    render(conn, "index.json", customers: customers)
  end

  def create(conn, %{"customer" => customer_params}) do
    changeset = Customer.changeset(%Customer{}, customer_params)

    case Repo.insert(changeset) do
      {:ok, customer} ->
        conn
        |> put_status(:created)
        |> render("show.json", customer: customer)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ContactApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, id)
    render conn, "show.json", customer: customer
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Repo.get!(Customer, id)
    changeset = Customer.changeset(customer, customer_params)

    case Repo.update(changeset) do
      {:ok, customer} ->
        render(conn, "show.json", customer: customer)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ContactApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    customer = Repo.delete!(customer)

    send_resp(conn, :no_content, "")
  end
end
