#!/usr/bin/env ruby
# frozen_string_literal: true

# require "awesome_print"
require_relative "../../lib/changify"

source = ARGV[0]
changes = ARGV[1]
dest = ARGV[2]

t = Changify::Transform.new

playlist_create = lambda { |data, changedef|
  playlist = {
    "id" => Random.new_seed.to_s,
    "owner_id" => changedef.args["user_id"],
    "song_ids" => changedef.args["song_ids"]
  }

  raise ArgumentError, "Playlist is empty" unless playlist["song_ids"].length.positive?

  data["playlists"].append(playlist)
  data
}
t.add_step(playlist_create, only_for: "playlist.create")

playlist_append = lambda { |data, changedef|
  playlist_id = changedef.args["id"]
  song_ids = changedef.args["song_ids"]

  playlist = data["playlists"].find { |p| p["id"] == playlist_id }

  raise ArgumentError, "Playlist ID is invalid" if playlist.nil?

  song_ids.each { |song| playlist["song_ids"].append(song) }
  data
}
t.add_step(playlist_append, only_for: "playlist.append")

playlist_append = lambda { |data, changedef|
  playlist_id = changedef.args["id"]
  data["playlists"] = data["playlists"].filter { |p| p["id"] != playlist_id }
  data
}
t.add_step(playlist_append, only_for: "playlist.destroy")

Changify.cli(source, changes, dest, transform: t)
