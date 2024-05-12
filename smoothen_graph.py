import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("TED-S-MATERIAL-CART.csv")

# TSBOARD_SMOOTHING = [0.5, 0.85, 0.99]
ts_factor = 0.99
df = df.ewm(alpha=(1 - ts_factor)).mean()
df.to_csv("TED-S-MATERIAL-CART_SMOOTH.csv", index=False)
