defmodule Allen do
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  @doc """
  Store a value at key, replaces an existing term if present
  """
  @spec put(atom(), any()) :: :ok
  def put(key, value) do
    module = to_module(key)
    binary = compile(module, value)

    :code.purge(module)

    {:module, ^module} = :code.load_binary(module, '#{module}.erl', binary)
    :ok
  end

  @doc """
  Get the value for key or return default
  """
  @spec get(atom(), any()) :: any() | nil
  def get(key, default \\ nil) do
    module = to_module(key)
    module.value
  rescue
    _ -> default
  end

  @doc """
  Delete value stored at key, no-op if non-existent.
  """
  @spec delete(atom()) :: boolean()
  def delete(key) do
    module = to_module(key)
    :code.purge(module)
    :code.delete(module)
  end

  defp to_module(key), do: :"Elixir.Allen.#{key}"

  defp compile(module, value) do
    {:ok, ^module, binary} =
      module
      |> generate_ast(value)
      |> :compile.forms([:verbose, :report_errors])

    binary
  end

  defp generate_ast(module, value) do
    [
      {:attribute, 0, :module, module},
      {:attribute, 0, :export, [value: 0]},
      {:function, 0, :value, 0,
       [{:clause, 0, [], [], [:erl_syntax.revert(:erl_syntax.abstract(value))]}]}
    ]
  end
end
