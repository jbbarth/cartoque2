require "spec_helper"

describe History do
  it "groups some versions with a model" do
    model = stub
    versions = stub(:to_a => "foo")
    history = History.new(versions, model)
    history.versions.should == versions
    history.model.should == model
  end

  it "raises an error if parameters are in the wrong order" do
    model = stub
    versions = stub(:to_a => "foo")
    expect do
      History.new(model, versions)
    end.to raise_error ArgumentError
  end
end
