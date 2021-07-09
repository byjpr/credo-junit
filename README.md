# CredoJunit

Convert Credo.json files into JUnit XML. This tool was primarily made to produce JUnit consumable tests reports for CircleCI.

## Usage

1. Add credo_junit to your mix.exs `{:credo_junit, git: "https://github.com/byjpr/credo_junit", only: [:dev, :test]}`
2. Run Credo and save output to reports/credo.json `$ mix credo $1 --format json >> reports/credo.json`
3. Convert credo.json to reports/credo.xml `mix credo_to_junit`

## Installation

```elixir
def deps do
  [
    {:credo_junit, git: "https://github.com/byjpr/credo_junit", only: [:dev, :test]}
  ]
end
```