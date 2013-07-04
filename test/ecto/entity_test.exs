Code.require_file "../test_helper.exs", __DIR__

defmodule Ecto.EntityTest do
  use ExUnit.Case, async: true

  defmodule MyEntity do
    use Ecto.Entity
    table_name :my_entity

    primary_key
    field :name, :string, default: "eric"
    field :email, :string, uniq: true
  end

  test "metadata" do
    fields = [
      { :id, [type: :integer, primary_key: true] },
      { :name, [type: :string, default: "eric"] },
      { :email, [type: :string, uniq: true] }
    ]

    assert MyEntity.__ecto__(:table) == :my_entity
    assert MyEntity.__ecto__(:fields) == fields
    assert MyEntity.__ecto__(:field_names) == [:id, :name, :email]
    assert MyEntity.__ecto__(:field, :id) == fields[:id]
    assert MyEntity.__ecto__(:field, :name) == fields[:name]
    assert MyEntity.__ecto__(:field, :email) == fields[:email]
    assert MyEntity.__ecto__(:field_type, :id) == fields[:id][:type]
    assert MyEntity.__ecto__(:field_type, :name) == fields[:name][:type]
    assert MyEntity.__ecto__(:field_type, :email) == fields[:email][:type]

    assert MyEntity.__record__(:fields) ==
           [id: nil, name: "eric", email: nil]
  end
end
