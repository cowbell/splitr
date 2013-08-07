require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "amount_class works properly with negative amounts" do
    assert_equal "text-danger", amount_class(-1)
  end

  test "amount_class works properly with positive amounts" do
    assert_equal "text-success", amount_class(1)
  end

  test "amount_class works properly with zero" do
    assert_equal "", amount_class(0)
  end
end
