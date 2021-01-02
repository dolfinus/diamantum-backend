defmodule ArkenstonWeb.Schema.Types.Custom.Locale do
  use Absinthe.Schema.Notation

  alias Arkenston.I18n

  @desc "Locale name"
  scalar :locale, name: "Locale" do
    serialize(&encode/1)
    parse(&decode/1)
  end

  @spec decode(Absinthe.Blueprint.Input.String.t()) :: {:ok, String.t()} | :error
  @spec decode(Absinthe.Blueprint.Input.Null.t()) :: {:ok, String.t()}
  defp decode(%Absinthe.Blueprint.Input.String{value: value}) do
    value = value |> to_string()

    if I18n.all_locales() |> Enum.member?(value) do
      {:ok, value}
    else
      :error
    end
  rescue
    _ in ArgumentError -> :error
  end

  defp decode(%Absinthe.Blueprint.Input.Null{}) do
    {:ok, I18n.default_locale()}
  end

  defp decode(_) do
    :error
  end

  defp encode(value), do: value |> to_string()
end
