defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(%{}, fn [id, _food_name, price], report ->
      last_price = Map.get(report, id, 0)
      Map.put(report, id, price + last_price)
    end)
  end
end
