defmodule FeedWatcherTest do
  use ExUnit.Case
  doctest FeedWatcher

  test "greets the world" do
    assert FeedWatcher.hello() == :world
  end
end
