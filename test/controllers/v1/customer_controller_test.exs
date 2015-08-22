defmodule ContactApi.V1.CustomerControllerTest do
  use ContactApi.ConnCase

  alias ContactApi.Customer
  @valid_attrs %{blood: "some content", description: "some content", gender: "some content", hobby: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_customer_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    customer = Repo.insert! %Customer{}
    conn = get conn, v1_customer_path(conn, :show, customer)
    assert json_response(conn, 200)["data"] == %{
      "id" => customer.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_customer_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_customer_path(conn, :create), customer: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Customer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_customer_path(conn, :create), customer: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    customer = Repo.insert! %Customer{}
    conn = put conn, v1_customer_path(conn, :update, customer), customer: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Customer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    customer = Repo.insert! %Customer{}
    conn = put conn, v1_customer_path(conn, :update, customer), customer: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    customer = Repo.insert! %Customer{}
    conn = delete conn, v1_customer_path(conn, :delete, customer)
    assert response(conn, 204)
    refute Repo.get(Customer, customer.id)
  end
end
