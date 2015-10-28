defmodule Fibonacci do
  
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
end
