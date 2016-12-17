abstract class FormatIphone
  getter connector

  abstract def recharge
  abstract def use_lightning
end

abstract class FormatAndroid
  getter connector

  abstract def recharge
  abstract def use_micro_usb
end

class Iphone < FormatIphone
  def initialize
    @connector = false
  end

  def use_lightning
    @connector = true
    puts "Lightning connected"
  end

  def recharge
    if @connector
      puts "Recharge started"
      puts "Recharge finished"
    else
      puts "Connect Lightning first"
    end
  end
end

class Android < FormatAndroid
  def initialize
    @connector = false
  end

  def use_micro_usb
    @connector = true
    puts "MicroUsb connected"
  end

  def recharge
    if @connector
      puts "Recharge started"
      puts "Recharge finished"
    else
      puts "Connect MicroUsb first"
    end
  end
end

class IphoneAdapter < FormatAndroid
  private getter mobile : FormatIphone

  def initialize(@mobile)
  end

  def recharge
    @mobile.recharge
  end

  def use_micro_usb
    puts "MicroUsb connected"
    @mobile.use_lightning
  end
end

class AndroidRecharger
  def initialize
    phone = Android.new
    phone.use_micro_usb
    phone.recharge
  end
end

class IphoneMicroUsbRecharger
  def initialize
    phone = Iphone.new
    phone_adapter = IphoneAdapter.new(phone)
    phone_adapter.use_micro_usb
    phone_adapter.recharge
  end
end

class IphoneRecharger
  def initialize
    phone = Iphone.new
    phone.use_lightning
    phone.recharge
  end
end

puts "Recharging android with MicroUsb Recharger"
AndroidRecharger.new
puts

puts "Recharging iPhone with MicroUsb using Adapter pattern"
IphoneMicroUsbRecharger.new
puts

puts "Recharging iPhone with iPhone Recharger"
IphoneRecharger.new
