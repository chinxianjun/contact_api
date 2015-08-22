defmodule ContactApi.Customer do
  use ContactApi.Web, :model

  schema "customers" do
    field :name, :string
    field :phone, :string
    field :gender, :string
    field :hobby, :string
    field :blood, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w(name phone gender hobby blood description)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
