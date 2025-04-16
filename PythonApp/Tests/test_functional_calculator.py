import unittest
from calculator import Calculator

class TestCalculatorFunctional(unittest.TestCase):
    def setUp(self):
        self.calc = Calculator()

    def test_complex_calculation(self):
        # (2 + 3) * (10 - 4) = 5 * 6 = 30
        result = self.calc.multiply(
            self.calc.add(2, 3),
            self.calc.subtract(10, 4)
        )
        self.assertEqual(result, 30)

    def test_division_chain(self):
        # ((100 / 2) / 5) = 10
        result = self.calc.divide(
            self.calc.divide(100, 2),
            5
        )
        self.assertEqual(result, 10)

if __name__ == '__main__':
    unittest.main()
