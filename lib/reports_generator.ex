defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(%{"users" => %{}, "foods" => %{}}, fn line, report ->
      sum_values(line, report)
    end)
  end

  def teste(filename) do
    filename
    |> build()
    |> fetch_higher_cost()
  end

  def fetch_higher_cost(report) do
    Enum.max_by(report, fn {_id, price} -> price end)
  end

  defp sum_values([id, food_name, price], report) do
    {_ok, users} = Map.fetch(report, "users")
    {_ok, foods} = Map.fetch(report, "foods")

    last_price = Map.get(users, id, 0)
    users_data = Map.put(users, id, price + last_price)

    food_count = Map.get(foods, food_name, 0)
    foods_data = Map.put(foods, food_name, food_count + 1)

    # report
    # |> Map.replace("users", users_data)
    # |> Map.replace("foods", foods_data)

    %{report | "users" => users_data, "foods" => foods_data}
  end
end
