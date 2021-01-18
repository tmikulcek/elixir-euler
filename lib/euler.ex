defmodule Euler do

  def multiples_of_3_and_5(), do: Stream.filter(1..999, fn n -> rem(n, 3) == 0 or rem(n,5) == 0 end) |> Enum.sum

  def even_fibonacci(), do: Fibonacci.fib_seq(1, 2) |> Stream.take_while(&(&1 < 4_000_000)) |> Stream.filter(&(rem(&1, 2) == 0)) |> Enum.sum

  def special_pythagorean_triplet(), do: hd(pythagorean(1000))

  @doc """
    Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
    For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
    What is the total of all the name scores in the file?
  """
  def names_scores() do
    names = File.open!(Path.expand('p022_names.txt'), [:utf8, :read])

    IO.read(names, :line)
      |> String.split(",")
      |> Enum.map(fn quoted -> String.strip(quoted, ?") end)
      |> Enum.sort
      |> Enum.map(fn quoted -> String.strip(quoted, ?") end)
      |> Enum.with_index
      |> Enum.map(fn {name, index} -> (index + 1) * sum_name(name) end)
      |> Enum.sum
  end

  defp sum_name(name) do
    String.to_char_list(name)
      |> Enum.map(fn char -> char - 64 end)
      |> Enum.sum
  end

  defp pythagorean(n) when n > 0 do
    for a <- 1..n - 2,
        b <- a + 1..n - 1,
        c <- b + 1..n,
        a + b + c == n,
        a*a + b*b == c*c,
    do: a * b * c 
  end

  def summation_of_primes do
    1..2_000_000 |> Stream.filter(&Prime.is_prime?/1) |> Enum.sum
  end

  def highly_divisible_triangular_number do
    {n, _} = triangle_numbers |> Stream.map(fn n -> {n, divisors_of n} end) |> Enum.find(fn {_, divisor_list} -> Enum.count(divisor_list) + 1 > 500 end)
    n
  end

  defp triangle_numbers do
    Stream.unfold(1_000_000_000, fn acc -> {1..acc |> Enum.sum, acc + 1} end)
  end

  #TODO: very inefficient
  def divisors_of(n) do
    1..round(n/2) |> Enum.filter(fn x -> rem(n, x) == 0 end)
  end
end
