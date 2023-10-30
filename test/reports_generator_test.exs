defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "report_test.csv"

      response = ReportsGenerator.build(file_name)

      expected_response = %{"foods" => %{"açaí" => 1, "churrasco" => 2, "esfirra" => 3, "hambúrguer" => 2, "pizza" => 2}, "users" => %{"1" => 48, "10" => 36, "2" => 45, "3" => 31, "4" => 42, "5" => 49, "6" => 18, "7" => 27, "8" => 25, "9" => 24}}

      assert response == expected_response
    end
  end

  describe "fetch_higher/2" do
    test "when the option is 'users', returns the user who spent the most" do
      file_name = "report_test.csv"

      response = file_name
      |> ReportsGenerator.build()
      |> ReportsGenerator.fetch_higher("users")

      expected_response = {"5", 49}

      assert response == expected_response
    end

    test "when the option is 'foods', returns the user who spent the most" do
      file_name = "report_test.csv"

      response = file_name
      |> ReportsGenerator.build()
      |> ReportsGenerator.fetch_higher("foods")

      expected_response = {"esfirra", 3}

      assert response == expected_response
    end

    test "when an invalid option is given, returns an error" do
      file_name = "report_test.csv"

      response = file_name
      |> ReportsGenerator.build()
      |> ReportsGenerator.fetch_higher("banana")

      expected_response = {:error, "Invalid option!"}

      assert response == expected_response
    end
  end

  describe "fetch_higher/1" do
    test "when an invalid option is given, returns an error" do
      file_name = "report_test.csv"

      response = file_name
      |> ReportsGenerator.build()
      |> ReportsGenerator.fetch_higher()

      expected_response = {:error, "Invalid option!"}

      assert response == expected_response
    end
  end
end
