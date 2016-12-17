require "./spec_helper"

describe LinuxButton do
  it "renders linux button" do
    button = LinuxButton.new
    button.paint.should eq("Render a button in a Linux style")
  end
end

describe WindowsButton do
  it "renders linux button" do
    button = WindowsButton.new
    button.paint.should eq("Render a button in a Windows style")
  end
end

describe MacOSButton do
  it "renders linux button" do
    button = MacOSButton.new
    button.paint.should eq("Render a button in a MacOS style")
  end
end

describe LinuxFactory do
  it "create Linux Button" do
    factory = LinuxFactory.new
    factory.create_button.should be_a(LinuxButton)
  end
end

describe WindowsFactory do
  it "create Window Button" do
    factory = WindowsFactory.new
    factory.create_button.should be_a(WindowsButton)
  end
end

describe MacOSFactory do
  it "create MacOS Button" do
    factory = MacOSFactory.new
    factory.create_button.should be_a(MacOSButton)
  end
end
