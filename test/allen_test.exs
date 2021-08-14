defmodule AllenTest do
  use ExUnit.Case
  doctest Allen

  test "put/2 - puts a new key" do
    value = :some_value
    assert :ok = Allen.put(:my_key, value)
    assert ^value = Allen.get(:my_key)
  end

  test "get/1 - try to get a non existent key" do
    refute Allen.get(:non_existent)
  end

  test "get/2 - try to get a non existent key with defaults" do
    value = "default"
    assert ^value = Allen.get(:non_existent, value)
  end

  test "delete/1 - try to get a non existent key with defaults" do
    key = :test_delete
    assert :ok = Allen.put(key, :value)
    assert :value = Allen.get(key)
    Allen.delete(key)
    assert nil == Allen.get(key)
  end
end
