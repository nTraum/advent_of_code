defmodule AdventOfCode.Y2021.D01 do
  @moduledoc "Solves https://adventofcode.com/2021/day/1 part one & two."

  def solve_part_one() do
    read_depth_measurements_from_file()
    |> chunk_in_pairs()
    |> count_number_of_depth_increases()
  end

  def solve_part_two() do
    read_depth_measurements_from_file()
    |> chunk_in_triples()
    |> sum_up_sliding_windows()
    |> chunk_in_pairs()
    |> count_number_of_depth_increases()
  end

  defp read_depth_measurements_from_file() do
    __ENV__.file
    |> Path.dirname()
    |> Path.join("input.txt")
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
  end

  defp chunk_in_pairs(measurements) do
    Stream.chunk_every(measurements, 2, 1, :discard)
  end

  defp chunk_in_triples(measurements) do
    Stream.chunk_every(measurements, 3, 1, :discard)
  end

  defp sum_up_sliding_windows(measurements) do
    Stream.map(measurements, &Enum.sum/1)
  end

  defp count_number_of_depth_increases(measurements) do
    Enum.count(measurements, fn [current_depth, next_depth] ->
      current_depth < next_depth
    end)
  end
end

IO.puts("Part one: #{AdventOfCode.Y2021.D01.solve_part_one()}")
IO.puts("Part two: #{AdventOfCode.Y2021.D01.solve_part_two()}")
