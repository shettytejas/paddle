require "test_helper"

class AddressTest < Minitest::Test

  def test_address_list
    addresses = Paddle::Address.list("ctm_01h7dtf1yg8jge7980baqdkjk8")

    assert_equal Paddle::Collection, addresses.class
    assert_equal Paddle::Address, addresses.data.first.class
    assert_equal "add_01h7dtpj3a5ygxw13fzhw8h445", addresses.data.first.id
  end

  def test_address_retrieve
    address = Paddle::Address.retrieve("ctm_01h7dtf1yg8jge7980baqdkjk8", "add_01h7dtpj3a5ygxw13fzhw8h445")

    assert_equal Paddle::Address, address.class
    assert_equal "add_01h7dtpj3a5ygxw13fzhw8h445", address.id
    assert_equal "124 City Road", address.first_line
  end

  def test_address_create
    address = Paddle::Address.create("ctm_01h7dtf1yg8jge7980baqdkjk8", {country_code: "GB", postal_code: "SW1A 2AA", first_line: "10 Downing Street"})

    assert_equal Paddle::Address, address.class
    assert_equal "active", address.status
    assert_equal "10 Downing Street", address.first_line
  end

  def test_address_update
    address = Paddle::Address.update("ctm_01h7dtf1yg8jge7980baqdkjk8", "add_01h7dtvh64g9c20asb65dc411r", {description: "Downing Street"})

    assert_equal Paddle::Address, address.class
    assert_equal "Downing Street", address.description
  end

end