defmodule Euler do

  def multiples_of_3_and_5(), do: Stream.filter(1..999, fn n -> rem(n, 3) == 0 or rem(n,5) == 0 end) |> Enum.sum

  def even_fibonacci(), do: Fibonacci.fib_seq(1, 2) |> Stream.take_while(&(&1 < 4_000_000)) |> Stream.filter(&(rem(&1, 2) == 0)) |> Enum.sum

  def special_pythagorean_triplet(), do: hd(pythagorean(1000))

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
    Stream.unfold(100_000_000, fn acc -> {1..acc |> Enum.sum, acc + 1} end)
  end
  
  #TODO: very inefficient
  defp divisors_of(n) do
    1..round(n/2) |> Enum.filter(fn x -> rem(n, x) == 0 end)
  end
end
