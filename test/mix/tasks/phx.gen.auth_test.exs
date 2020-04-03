Code.require_file("../../mix_helper.exs", __DIR__)

defmodule Mix.Tasks.Phx.Gen.AuthTest do
  use ExUnit.Case

  import MixHelper
  alias Mix.Tasks.Phx.Gen

  setup do
    Mix.Task.clear()
    :ok
  end

  test "invalid mix arguments", config do
    in_tmp_project(config.test, fn ->
      assert_raise Mix.Error, ~r/Expected the context, "accounts", to be a valid module name/, fn ->
        Gen.Auth.run(~w(accounts User users))
      end

      assert_raise Mix.Error, ~r/Expected the schema, "user", to be a valid module name/, fn ->
        Gen.Auth.run(~w(Accounts user users))
      end

      assert_raise Mix.Error, ~r/The context and schema should have different names/, fn ->
        Gen.Auth.run(~w(User User users))
      end

      assert_raise Mix.Error, ~r/Cannot generate context PhxGenAuth because it has the same name as the application/, fn ->
        Gen.Auth.run(~w(PhxGenAuth User users))
      end

      assert_raise Mix.Error, ~r/Cannot generate schema PhxGenAuth because it has the same name as the application/, fn ->
        Gen.Auth.run(~w(Accounts PhxGenAuth users))
      end

      assert_raise Mix.Error, ~r/Invalid arguments/, fn ->
        Gen.Auth.run(~w())
      end

      assert_raise Mix.Error, ~r/Invalid arguments/, fn ->
        Gen.Auth.run(~w(Accounts))
      end

      assert_raise Mix.Error, ~r/Invalid arguments/, fn ->
        Gen.Auth.run(~w(Accounts User))
      end
    end)
  end
end
