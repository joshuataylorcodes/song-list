require "test_helper"

class SongsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/songs.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Song.count, data.length
  end

  test "show" do
    get "/songs/#{Song.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "title", "album", "artist", "year", "created_at", "updated_at"], data.keys
  end

  test "create" do
    assert_difference "Song.count", 1 do
      post "/songs.json", params: { title: "Full of Myself", album: "Mental State", artist: "Josh Taylor", year: 2023 }
      assert_response 200
    end
  end

  test "update" do
    song = Song.first
    patch "/songs/#{song.id}.json", params: { title: "Updated name" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated name", data["title"]
  end
end
