defmodule Mix.Tasks.CredoToJunit do
  @moduledoc """
  Convert Credo JSON output to XML for Junit
  """
  use Mix.Task

  @spec run(any) :: :ok | {:error, atom}
  def run(_) do
    xml = convert_json()

    File.cwd!()
    |> Path.join("reports/credo.xml")
    |> File.write(xml)
  end

  defp convert_json do
    File.cwd!()
    |> Path.join("reports/credo.json")
    |> File.read!()
    |> Jason.decode!()
    |> Access.get("issues")
    |> Enum.into([], fn x -> item(x) end)
    |> List.flatten()
    |> wrap_xml
    |> String.replace(~r/ +/, " ")
  end

  # https://stackoverflow.com/a/26661423
  @spec item(map) :: <<_::64, _::_*8>>
  def item(%{
        "category" => _category,
        "check" => check,
        "column" => column,
        "column_end" => _column_end,
        "filename" => filename,
        "line_no" => line_no,
        "message" => message,
        "priority" => _priority,
        "scope" => scope,
        "trigger" => _trigger
      }) do
    """
    <testcase name="#{scope}:#{line_no}:#{column}"
              file="#{filename}"
              assertions="#{message |> Phoenix.HTML.html_escape |> Phoenix.HTML.safe_to_string()}"
              classname="#{scope}">
      <failure type="#{check}">
        #{message}
        #{filename}:#{line_no}:#{column} (#{scope})
      </failure>
    </testcase>
    """
  end

  defp wrap_xml(xml) do
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <testsuite>
      #{xml}
    </testsuite>
    """
  end
end
