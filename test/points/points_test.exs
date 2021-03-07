defmodule Points.PointTest do
  use Points.DataCase
  alias Points.Repo

  describe "list_users_with_more_points_than" do
    test "no users" do
      assert Points.list_users_with_more_points_than(1) == []
    end

    test "no users with enough points" do
      %Points.User{points: 5} |> Repo.insert!()
      assert Points.list_users_with_more_points_than(6) == []
    end

    test "equal is not enough" do
      %Points.User{points: 5} |> Repo.insert!()
      assert Points.list_users_with_more_points_than(5) == []
    end

    test "one user with enough points" do
      user = %Points.User{points: 6} |> Repo.insert!()
      assert Points.list_users_with_more_points_than(5) == [user]
    end

    test "skip users who don't have enough points" do
      %Points.User{points: 1} |> Repo.insert!()
      user = %Points.User{points: 6} |> Repo.insert!()
      %Points.User{points: 2} |> Repo.insert!()
      assert Points.list_users_with_more_points_than(5) == [user]
    end

    test "two users with enough points" do
      user1 = %Points.User{points: 6} |> Repo.insert!()
      user2 = %Points.User{points: 6} |> Repo.insert!()
      assert Points.list_users_with_more_points_than(5) == [user1, user2]
    end

    test "three users with enough points, only return 2" do
      user1 = %Points.User{points: 6} |> Repo.insert!()
      user2 = %Points.User{points: 6} |> Repo.insert!()
      %Points.User{points: 6} |> Repo.insert!()
      assert Points.list_users_with_more_points_than(5) == [user1, user2]
    end
  end

  describe "update_user_points" do
    test "no users" do
      Points.update_user_points()
      assert Repo.all(Points.User) == []
    end

    test "user points get updated" do
      %Points.User{points: 0} |> Repo.insert!()
      %Points.User{points: 0} |> Repo.insert!()
      Points.update_user_points()
      # 2/100 chance this test will spuriosly fail, but :shrug:
      Points.User
      |> Repo.all()
      |> Enum.each(fn user ->
        assert user.points != 0
      end)
    end
  end
end
