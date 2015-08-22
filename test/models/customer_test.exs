defmodule ContactApi.CustomerTest do
  use ContactApi.ModelCase

  alias ContactApi.Customer

  @valid_attrs %{blood: "some content", description: "some content", gender: "some content", hobby: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Customer.changeset(%Customer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Customer.changeset(%Customer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
