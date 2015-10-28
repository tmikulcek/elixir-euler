defmodule PrimeTest do
  use ExUnit.Case
  doctest Prime

  test "infinite sieve of Erathosten" do
    {:ok, primes} = Task.start_link(Prime, :extremely_inefficient_infinite_erathosten, [])
    generator = fn -> send(primes, {:get, self()})
                      receive do
                       {:next, next} -> next
                      end
                end
    first_4 = Stream.repeatedly(generator) |> Enum.take(4)
    assert first_4 === [2, 3, 5, 7]
  end

  test "is prime" do
    first_4_primes = [2, 3, 5, 7]
    assert 1..10 |> Stream.filter(&Prime.is_prime?/1) |> Enum.take(4) == first_4_primes
  end
end
