defmodule ContactApi.Repo.Migrations.CreateCustomer do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :phone, :string
      add :gender, :string
      add :hobby, :text
      add :blood, :string
      add :description, :text

      timestamps
    end

  end
end
