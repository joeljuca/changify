# frozen_string_literal: true

require_relative "../lib/changify"

RSpec.describe Changify do
  it "has a version number" do
    expect(Changify::VERSION).not_to be nil
  end
end

RSpec.describe Changify::Changedef do
  it "expects a type" do
    cd = Changify::Changedef.new("my_changedef", { "foo" => "bar" })

    expect(cd.type).to eq("my_changedef")
  end

  it "expects some args" do
    cd = Changify::Changedef.new("my_changedef", { "foo" => "bar" })

    expect(cd.args).to be_an_instance_of(Hash)
    expect(cd.args["foo"]).to eq("bar")
  end

  context ".from_jsonl" do
    it "creates a Changedef from a JSONL" do
      line = '["my_changedef", {"do":"something"}]'

      cd = Changify::Changedef.from_jsonl(line)

      expect(cd).to be_an_instance_of(Changify::Changedef)
      expect(cd.type).to eq("my_changedef")
      expect(cd.args).to be_an_instance_of(Hash)
      expect(cd.args["do"]).to eq("something")
    end
  end
end

RSpec.describe Changify::Transform do
  before do
    @transform = Changify::Transform.new
  end

  context "#call(data, changedefs)" do
    before do
      step_set_name = lambda { |data, changedef|
        data["name"] = changedef.args["name"] unless changedef.args["name"].nil?
        data
      }
      @transform.add_step(step_set_name, only: "set.name")
    end

    it "transforms `data` using `changedefs`" do
      changedef = Changify::Changedef.new("set.name", { "name" => "Joel" })

      data = @transform.call({}, [changedef])

      expect(data["name"]).to eq("Joel")
    end
  end
end
