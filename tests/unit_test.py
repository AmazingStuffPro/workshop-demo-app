from lib.demo import add, subtract, multiply


def test_add():
    result = add(2, 2)
    assert result == 4


def test_subtract():
    result = subtract(4, 2)
    assert result == 2


def test_multiply():
   result = multiply(3, 2)
   assert result == 6
