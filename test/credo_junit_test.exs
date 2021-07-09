defmodule CredoJunitTest do
  use ExUnit.Case
  doctest CredoJunit

  test "greets the world" do
    assert CredoJunit.hello() == :world
  end
end
