defmodule ReversePolishTest do
  use ExUnit.Case

  test "empty input" do
    assert ReversePolish.solve("") == nil
  end

  test "ignore unknown input" do
    assert ReversePolish.solve("1 1 + @ !") == 2
  end

  test "ignore extra text on numbers input" do
    assert ReversePolish.solve("1a 1b +") == 2
  end

  test "single digit" do
    assert ReversePolish.solve("1") == 1
  end

  test "summation" do
    assert ReversePolish.solve("1 1 +") == 2
  end

  test "substaction" do
    assert ReversePolish.solve("1 1 -") == 0
  end

  test "multiplication" do
    assert ReversePolish.solve("2 3 *") == 6
  end

  test "division" do
    assert ReversePolish.solve("6 2 /") == 3
  end

  test "complex input" do
    assert ReversePolish.solve("5 2 1 + * 1 - 7 /") == 2
  end
end
