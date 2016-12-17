require "spec"
require "../src/crystal_design_patterns/adapter"

describe IphoneAdapter do
  describe "charge with micro usb" do
    it "is allow" do
      phone = Iphone.new
      phone_adapter = IphoneAdapter.new(phone)
      phone_adapter.use_micro_usb
      phone.connector.should eq(true)
    end
  end
end
