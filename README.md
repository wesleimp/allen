# Allen

<!-- MDOC !-->

A read-only module constant pool

## Installation

```elixir
def deps do
  [
    {:allen, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
value = %{ab: 123, cd: 456}
Allen.put(:key, data)
^value = Allen.get(:key)
```