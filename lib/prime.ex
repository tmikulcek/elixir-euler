defmodule Prime do

  def extremely_inefficient_infinite_erathosten(stream \\ Stream.iterate(2, &(&1 + 1))) do
   next = stream |> Enum.take(1) |> hd
   receive do
     {:get, sender} -> send(sender, {:next, next})
   end
   next_stream = Stream.reject(stream, fn x -> rem(x, next) == 0 end)
   extremely_inefficient_infinite_erathosten(next_stream)
  end

  def is_prime?(n) when n == 1, do: false
  def is_prime?(n) when n == 2, do: true
  def is_prime?(n) do
    divisors = 2..round(:math.sqrt n) |> Enum.filter(fn x -> x != n && rem(n, x) == 0 end)
    Enum.empty? divisors
  end

end
