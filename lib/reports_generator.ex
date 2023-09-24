defmodule ReportsGenerator do
  def build(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Enum.reduce(%{}, fn line, report ->
      [id, _food_name, price] = parse_line(line)
      last_price = Map.get(report, id, 0)
      Map.put(report, id, price + last_price)
    end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end
end
