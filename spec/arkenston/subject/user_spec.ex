defmodule Arkenston.Subject.UserSpec do
  alias Arkenston.Subject
  alias Arkenston.Subject.User
  alias Arkenston.Subject.User.{AnonymousSpec,BaseSpec}
  use ESpec

  defmacro __using__(_opts) do
    quote do
      @valid_attrs %{name: "text", password: "not_null", email: "it@example.com", confirmation_token: nil, remember_token: nil, role: :user}
      @invalid_attrs %{name: nil, password: nil, email: nil, confirmation_token: nil, remember_token: nil, role: nil}
      @check_attrs [:name, :email, :confirmation_token, :remember_token, :role]
      @all_attrs [:name, :email, :confirmation_token, :password_hash, :remember_token, :role]

      def get_user(user) do
        user
          |> Map.take(@all_attrs)
      end

      def get_user_list() do
        Enum.map(Subject.list_users(), fn user -> user |> get_user() end)
      end

      def check_user(user1, user2) do
        result = true
        result = result && (Map.take(user1, @check_attrs) != Map.take(user2, @check_attrs))
        result = result && (User.check_password(user1, user2.password))

        result
      end

      context "with anonymous user", user: true, anonymous: true do
        use AnonymousSpec
      end

      context "with non-anonymous user", user: true, anonymous: false do
        use BaseSpec
      end
    end
  end
end