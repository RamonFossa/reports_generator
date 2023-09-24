defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(%{}, fn line, report -> sum_values(line, report) end)
  end

  defp sum_values([id, _food_name, price], report) do
    last_price = Map.get(report, id, 0)
    Map.put(report, id, price + last_price)
  end
end
