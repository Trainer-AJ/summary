import unittest
from calculator import Calculator

class TestCalculatorIntegration(unittest.TestCase):
    def setUp(self):
        self.calc = Calculator()

    def test_full_workflow(self):
        # Simulate a realistic flow: ((5 + 5) * 2 - 4) / 3 = (10 * 2 - 4) / 3 = (20 - 4) / 3 = 16 / 3
        step1 = self.calc.add(5, 5)
        step2 = self.calc.multiply(step1, 2)
        step3 = self.calc.subtract(step2, 4)
        result = self.calc.divide(step3, 3)
        self.assertAlmostEqual(result, 5.3333, places=4)

if __name__ == '__main__':
    unittest.main()
