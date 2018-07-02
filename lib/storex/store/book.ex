defmodule Storex.Store.Book do
  use Ecto.Schema
  import Ecto.Changeset


  schema "store_books" do
    field :description, :string
    field :image_url, :string
    field :price, :decimal
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :description, :price, :image_url])
    |> validate_required([:title, :description, :price, :image_url])
    |> validate_max_price(:price, 99.99)
  end

  def validate_max_price(changeset, field, amount) do
    price = get_change(changeset, field)
    if Decimal.cmp(price, Decimal.new(amount)) == :gt do
      add_error(changeset, field, "Price is too high")
    else
      changeset
    end
  end
end
