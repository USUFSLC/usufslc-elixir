defmodule Fslc.PollsTest do
  use Fslc.DataCase

  alias Fslc.Polls

  describe "polls" do
    alias Fslc.Polls.Poll

    @valid_attrs %{name: "some name", user_id: 42}
    @update_attrs %{name: "some updated name", user_id: 43}
    @invalid_attrs %{name: nil, user_id: nil}

    def poll_fixture(attrs \\ %{}) do
      {:ok, poll} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polls.create_poll()

      poll
    end

    test "list_polls/0 returns all polls" do
      poll = poll_fixture()
      assert Polls.list_polls() == [poll]
    end

    test "get_poll!/1 returns the poll with given id" do
      poll = poll_fixture()
      assert Polls.get_poll!(poll.id) == poll
    end

    test "create_poll/1 with valid data creates a poll" do
      assert {:ok, %Poll{} = poll} = Polls.create_poll(@valid_attrs)
      assert poll.name == "some name"
      assert poll.user_id == 42
    end

    test "create_poll/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_poll(@invalid_attrs)
    end

    test "update_poll/2 with valid data updates the poll" do
      poll = poll_fixture()
      assert {:ok, %Poll{} = poll} = Polls.update_poll(poll, @update_attrs)
      assert poll.name == "some updated name"
      assert poll.user_id == 43
    end

    test "update_poll/2 with invalid data returns error changeset" do
      poll = poll_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_poll(poll, @invalid_attrs)
      assert poll == Polls.get_poll!(poll.id)
    end

    test "delete_poll/1 deletes the poll" do
      poll = poll_fixture()
      assert {:ok, %Poll{}} = Polls.delete_poll(poll)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_poll!(poll.id) end
    end

    test "change_poll/1 returns a poll changeset" do
      poll = poll_fixture()
      assert %Ecto.Changeset{} = Polls.change_poll(poll)
    end
  end

  describe "questions" do
    alias Fslc.Polls.Question

    @valid_attrs %{question: "some question"}
    @update_attrs %{question: "some updated question"}
    @invalid_attrs %{question: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polls.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Polls.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Polls.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Polls.create_question(@valid_attrs)
      assert question.question == "some question"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = Polls.update_question(question, @update_attrs)
      assert question.question == "some updated question"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_question(question, @invalid_attrs)
      assert question == Polls.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Polls.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Polls.change_question(question)
    end
  end

  describe "votes" do
    alias Fslc.Polls.Vote

    @valid_attrs %{question_id: 42, user_id: 42}
    @update_attrs %{question_id: 43, user_id: 43}
    @invalid_attrs %{question_id: nil, user_id: nil}

    def vote_fixture(attrs \\ %{}) do
      {:ok, vote} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polls.create_vote()

      vote
    end

    test "list_votes/0 returns all votes" do
      vote = vote_fixture()
      assert Polls.list_votes() == [vote]
    end

    test "get_vote!/1 returns the vote with given id" do
      vote = vote_fixture()
      assert Polls.get_vote!(vote.id) == vote
    end

    test "create_vote/1 with valid data creates a vote" do
      assert {:ok, %Vote{} = vote} = Polls.create_vote(@valid_attrs)
      assert vote.question_id == 42
      assert vote.user_id == 42
    end

    test "create_vote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_vote(@invalid_attrs)
    end

    test "update_vote/2 with valid data updates the vote" do
      vote = vote_fixture()
      assert {:ok, %Vote{} = vote} = Polls.update_vote(vote, @update_attrs)
      assert vote.question_id == 43
      assert vote.user_id == 43
    end

    test "update_vote/2 with invalid data returns error changeset" do
      vote = vote_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_vote(vote, @invalid_attrs)
      assert vote == Polls.get_vote!(vote.id)
    end

    test "delete_vote/1 deletes the vote" do
      vote = vote_fixture()
      assert {:ok, %Vote{}} = Polls.delete_vote(vote)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_vote!(vote.id) end
    end

    test "change_vote/1 returns a vote changeset" do
      vote = vote_fixture()
      assert %Ecto.Changeset{} = Polls.change_vote(vote)
    end
  end

  describe "options" do
    alias Fslc.Polls.Option

    @valid_attrs %{option: "some option", question_id: 42}
    @update_attrs %{option: "some updated option", question_id: 43}
    @invalid_attrs %{option: nil, question_id: nil}

    def option_fixture(attrs \\ %{}) do
      {:ok, option} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polls.create_option()

      option
    end

    test "list_options/0 returns all options" do
      option = option_fixture()
      assert Polls.list_options() == [option]
    end

    test "get_option!/1 returns the option with given id" do
      option = option_fixture()
      assert Polls.get_option!(option.id) == option
    end

    test "create_option/1 with valid data creates a option" do
      assert {:ok, %Option{} = option} = Polls.create_option(@valid_attrs)
      assert option.option == "some option"
      assert option.question_id == 42
    end

    test "create_option/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_option(@invalid_attrs)
    end

    test "update_option/2 with valid data updates the option" do
      option = option_fixture()
      assert {:ok, %Option{} = option} = Polls.update_option(option, @update_attrs)
      assert option.option == "some updated option"
      assert option.question_id == 43
    end

    test "update_option/2 with invalid data returns error changeset" do
      option = option_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_option(option, @invalid_attrs)
      assert option == Polls.get_option!(option.id)
    end

    test "delete_option/1 deletes the option" do
      option = option_fixture()
      assert {:ok, %Option{}} = Polls.delete_option(option)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_option!(option.id) end
    end

    test "change_option/1 returns a option changeset" do
      option = option_fixture()
      assert %Ecto.Changeset{} = Polls.change_option(option)
    end
  end
end
