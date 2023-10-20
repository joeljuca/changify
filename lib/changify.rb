# frozen_string_literal: true

require "json"

module Changify
  VERSION = "0.1.0"

  class Transform
    def initialize
      @handlers = []
    end

    def add_step(handler, opts = {})
      @handlers.append([handler, opts])
    end

    def call(data, changedefs)
      changedefs.reduce(data) do |data, changedef|
        @handlers.reduce(data) do |data, entry|
          handler = entry[0]
          opts = entry[1]

          case true # rubocop:disable Lint/LiteralAsCondition
          when opts[:only_for].nil?
            handler.call(data, changedef)

          when opts[:only_for] == changedef.type
            handler.call(data, changedef)
          end

          data
        end
      end
    end
  end

  class Changedef
    attr_reader :type, :args

    def initialize(type, args)
      @type = type
      @args = args
    end

    def self.from_jsonl(jsonline)
      tuple = JSON.parse(jsonline)
      type = tuple[0]
      args = tuple[1]

      Changedef.new(type, args)
    end
  end

  def self.cli(source, changes, dest = nil, opts = {})
    transform = opts.fetch(:transform)

    data = JSON.load_file(source)
    changedefs = File.open(changes).read.split("\n")
                     .filter { |line| line.strip.length.positive? }
                     .map { |line| Changedef.from_jsonl(line) }

    json = data
           .then { |data| transform.call(data, changedefs) }
           .then { |data| JSON.generate(data) }

    if dest.nil?
      puts json
    else
      file = File.new(dest, "w")
      file.write(json)
      file.close
    end
  end
end
