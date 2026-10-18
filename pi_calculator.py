import decimal

def calculate_pi(places):
    decimal.getcontext().prec = places + 2
    # Leibniz formula for Pi (Simple but slow for large digits)
    pi = decimal.Decimal(0)
    for k in range(10000):
        pi += decimal.Decimal((-1)**k) / decimal.Decimal(2*k + 1)
    return +pi * 4

digits = 50  # Change this to how many decimals you want
print(f"Pi to {digits} places:\n{str(calculate_pi(digits))[:-2]}")

