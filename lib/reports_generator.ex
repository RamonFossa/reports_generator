defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @options ["foods", "users"]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(%{"users" => %{}, "foods" => %{}}, fn line, report ->
      sum_values(line, report)
    end)
  end

  def fetch_higher(report, option) when option in @options do
    case option do
      "foods" -> Map.fetch(report, "foods") |> higher_data()

      "users" -> Map.fetch(report, "users") |> higher_data()
    end
  end

  def fetch_higher(_report, _option), do: {:error, "Invalid option!"}

  def fetch_higher(_report), do: {:error, "Invalid option!"}

  defp higher_data({_OK, report}) do
    Enum.max_by(report, fn {_id, value} -> value end)
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
