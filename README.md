# InterruptCollector
This block defines a basic interrupt collector for **level triggered** interrupt sources.
Usually edge triggered sources e.g., timers pulse can be converted to level triggered 
ones by catching them in the user logic. 
Its purpose is to be inherited by implementations of e.g., SPI, I2C etc. controllers based on this principle.
