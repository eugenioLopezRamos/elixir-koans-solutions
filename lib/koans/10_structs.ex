defmodule Structs do
  use Koans

  @intro "Structs"

  defmodule Person do
    defstruct [:name, :age]
  end

  koan "Structs are defined and named after a module" do
    person = %Person{}
    assert person == %Structs.Person{name: nil, age: nil}
  end

  koan "Unless previously defined, fields begin as nil" do
    nobody = %Person{}
    assert nobody.age == nil
  end

  koan "You can pass initial values to structs" do
    joe = %Person{name: "Joe", age: 23}
    assert joe.name == "Joe"
  end

  koan "Update fields with the cons '|' operator" do
    joe = %Person{name: "Joe", age: 23}
    older = %{joe | age: joe.age + 10}
    assert older.age == 33
  end

  defmodule Plane do
    defstruct passengers: 0, maker: :boeing
  end
<
  def plane?(%Plane{}), do: true
  def plane?(_), do: false

  koan "Or onto the type of the struct itself" do
    assert plane?(%Plane{passengers: 417, maker: :boeing}) == true
    assert plane?(%Person{}) == false
  end

  koan "Struct can be treated like maps" do
    silvia = %Person{age: 22, name: "Silvia"}

    assert Map.fetch(silvia, :age) == {:ok, 22}
  end

  defmodule Airline do
    defstruct plane: %Plane{}, name: "Southwest"
  end

  koan "Use the put_in macro to replace a nested value" do
    airline = %Airline{plane: %Plane{maker: :boeing}}
    assert put_in(airline.plane.maker, :airbus) == %Structs.Airline{name: "Southwest", plane: %Structs.Plane{maker: :airbus, passengers: 0}}
  end

  koan "Use the update_in macro to modify a nested value" do
    airline = %Airline{plane: %Plane{maker: :boeing, passengers: 200}}
    assert update_in(airline.plane.passengers, &(&1 + 2)) == %Structs.Airline{plane: %Structs.Plane{maker: :boeing, passengers: 202}}
  end

  koan "Use the put_in macro with atoms to replace a nested value in a non-struct" do
    airline = %{plane: %{maker: :boeing}, name: "Southwest"}
    assert put_in(airline[:plane][:maker], :cessna) == %{plane: %{maker: :cessna}, name: "Southwest"}
  end
end