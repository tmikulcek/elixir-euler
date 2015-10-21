defmodule Euler do
  def multiples_of_3_and_5(), do: Stream.filter(1..999, fn n -> rem(n, 3) == 0 or rem(n,5) == 0 end) |> Enum.sum

  def even_fibonacci(), do: fib_seq(1, 2) |> Stream.take_while(&(&1 < 4_000_000)) |> Stream.filter(&(rem(&1, 2) == 0)) |> Enum.sum

  def special_pythagorean_triplet(), do: hd(pythagorean(1000))

  def fib_seq(start1, start2), do: Stream.unfold({start1, start2}, fn {a, b} -> {a, {b, a + b}} end)
  
  @doc """
    This function will not work as expected.
    No matter how many times you call the returned function, first and second will always have the values a and b, respectively.
  """
  def fib_wrong(a,b) do
    first = a
    second = b
    fn -> next = first + second
      IO.puts(first)
      IO.puts(second)
      IO.puts(next)
      first = second
      second = next
    end
  end

  def fibonacci_actor(first, second) do
    next = first + second
    receive do
      {:get, sender} -> send(sender, {:next, first})
    end
    fibonacci_actor(second, next)
  end

  defp pythagorean(n) when n > 0 do
    for a <- 1..n - 2,
        b <- a + 1..n - 1,
        c <- b + 1..n,
        a + b + c == n,
        a*a + b*b == c*c,
    do: a * b * c 
  end
end
