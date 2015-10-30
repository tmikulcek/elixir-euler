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


  defp sum_name(name) do
    String.to_char_list(name)
      |> Enum.map(fn char -> char - 64 end)
      |> Enum.sum
  end

  @doc """
    Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
    For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
    What is the total of all the name scores in the file?
  """
  def names_scores() do
    names = File.open!(Path.expand('p022_names.txt'), [:utf8, :read])

    IO.read(names, :line)
      |> String.split(",")
      |> Enum.sort
      |> Enum.map(fn quoted -> String.strip(quoted, ?") end)
      |> Enum.with_index
      |> Enum.map(fn {name, index} -> (index + 1) * sum_name(name) end)
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
end
