defmodule ArkenstonWeb.Schema.Mutation.Author do
  use Absinthe.Schema.Notation
  import Arkenston.Middleware.HandleErrors

  alias Arkenston.Mutator.AuthorMutator

  object :author_mutations do
    field :create_author, :author do
      arg :input, non_null(:create_author_input)
      resolve &AuthorMutator.create/3
      middleware &build_payload/2
    end

    field :update_author, :author do
      arg :id, :uuid4
      arg :name, :string
      arg :email, :string
      arg :input, non_null(:update_author_input)
      resolve &AuthorMutator.update/3
      middleware &build_payload/2
    end

    field :delete_author, :author do
      arg :id, :uuid4
      arg :name, :string
      arg :email, :string
      arg :input, :delete_author_input
      resolve &AuthorMutator.delete/3
      middleware &build_payload/2
    end
  end
end
