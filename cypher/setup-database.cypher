
MATCH (n)
DETACH DELETE n;

CREATE (arduino:Controller)
SET arduino.name = "Arduino Nano",
    arduino.id = randomUUID(),
    arduino.type = "Microcontroller",
    arduino.description = "is an intelligent development board designed for building faster prototypes with the smallest
dimension. Arduino Nano being the oldest member of the Nano family, provides enough interfaces for your
breadboard-friendly applications. At the heart of the board is ATmega328 microcontroller clocked at a frequency
of 16 MHz featuring more or less the same functionalities as the Arduino® Duemilanove. The board oﬀers 20 digital
input/output pins, 8 analog pins, and a mini-USB port.",
    arduino.image = "https://store-cdn.arduino.cc/usa/catalog/product/cache/1/image/500x375/f8876a31b63532bbba4e781c30024a0a/a/0/a000005_featured_1.jpg",
    arduino.createdAt = datetime(),
    arduino.updatedAt = datetime(),
   
    // Feature Updates
    arduino.microcontroller = "ATmega328",
    arduino.processor = "High-performance low-power 8-bit processor",
    arduino.clockFrequency = "16 MHz",
    arduino.performance = "Achieve up to 16 MIPS for 16 MHz clock frequency",
    arduino.memory = "32 kB (2 KB used by bootloader), 2 kB internal SRAM, 1 kB EEPROM",
    arduino.registers = "32 x 8 General Purpose Working Registers",
    arduino.timer = "Real Time Counter with Separate Oscillator",
    arduino.pwmChannels = "6",
    arduino.serialInterfaces = ["Programmable Serial USART", "Master/Slave SPI Serial Interface"],
    arduino.powerOptions = "Mini-B USB connection, 7-15V unregulated external power supply (pin 30), 5V regulated external power supply (pin 27)",
    arduino.sleepModes = ["Idle", "ADC Noise Reduction", "Power-save", "Power-down", "Standby", "Extended Standby"],
    arduino.digitalIO = 20,
    arduino.analogIO = 8,
    arduino.pwmOutput = 6

RETURN arduino;

CREATE (temperatureSensor:Sensor)
SET temperatureSensor.type = "DHT11",
    temperatureSensor.id = randomUUID(),
    temperatureSensor.name = "Temperature and Humidity Sensor",
    temperatureSensor.description = "is a digital temperature and humidity sensor. It uses a capacitive humidity sensor and a thermistor to measure the surrounding air, and spits out a digital signal on the data pin (no analog input pins needed). Its fairly simple to use, but requires careful timing to grab data. The only real downside of this sensor is you can only get new data from it once every 2 seconds, so when using our library, sensor readings can be up to 2 seconds old.",
    temperatureSensor.image = "https://www.electronicwings.com/public/images/user_images/images/Arduino/Sensors/DHT11/DHT11_Sensor.jpg",
    temperatureSensor.createdAt = datetime(),
    temperatureSensor.updatedAt = datetime(),
    
    // Feature Updates
    temperatureSensor.temperatureRange = "0-50°C",
    temperatureSensor.humidityRange = "20-90% RH",
    temperatureSensor.accuracy = "±2°C, ±5% RH",
    temperatureSensor.voltage = "3.3-5.5V",
    temperatureSensor.current = "2.5mA max",
    temperatureSensor.communication = "Single-bus digital signal transmission",
    temperatureSensor.resolution = "8-bit",
    temperatureSensor.refreshRate = "2 seconds",
    temperatureSensor.dimensions = "15.5 x 12 x 5.5 mm"
RETURN temperatureSensor;

CREATE (screen:Display)
SET screen.type = "LCD Screen",
screen.id = randomUUID(),
screen.function = "Show Data",
screen.name = "16x2 LCD Screen",
screen.description = "is a basic 16 character by 2 line display. Black text on Green background. It utilizes the extremely common HD44780 parallel interface chipset. Interface code is freely available. You will need 11 general I/O pins to interface to this LCD screen. Includes LED backlight.",
screen.image = "https://www.electronicwings.com/public/images/user_images/images/Arduino/Modules/16x2_LCD/16x2_LCD.jpg",
screen.createdAt = datetime(),
screen.updatedAt = datetime()

RETURN screen;

CREATE (lightSensor:Sensor)
SET lightSensor.type = "Light Sensor",
lightSensor.id = randomUUID(),
lightSensor.name = "LDR (Light Dependent Resistor)",
lightSensor.description = "is a light-controlled variable resistor. The resistance of a photoresistor decreases with increasing incident light intensity; in other words, it exhibits photoconductivity. A photoresistor can be applied in light-sensitive detector circuits, and light- and dark-activated switching circuits.",
lightSensor.image = "https://www.electronicwings.com/public/images/user_images/images/Arduino/Sensors/Photoresistor/Photoresistor.jpg",
lightSensor.createdAt = datetime(),
lightSensor.updatedAt = datetime(),

// Feature Updates
lightSensor.voltage = "5V",
lightSensor.current = "10mA",
lightSensor.resistance = "10kΩ in darkness, 200Ω in light",
lightSensor.peakWavelength = "540nm",
lightSensor.dimensions = "5 x 2 x 2 mm"
RETURN lightSensor;

CREATE (proximitySensor:Sensor)
SET proximitySensor.type = "PIR Sensor",
proximitySensor.id = randomUUID(),
proximitySensor.name = "HC-SR501",
proximitySensor.description = "is a passive infrared sensor designed to detect movement. It can be used in security systems, automatic lighting, and other applications that require motion detection. The sensor has a range of approximately 7 meters and can be adjusted to detect motion in a specific area.",
proximitySensor.image = "https://www.electronicwings.com/public/images/user_images/images/Arduino/Sensors/PIR_Sensor/PIR_Sensor.jpg",
proximitySensor.createdAt = datetime(),
proximitySensor.updatedAt = datetime(),

// Feature Updates
proximitySensor.voltage = "5V",
proximitySensor.current = "50uA",
proximitySensor.range = "7 meters",
proximitySensor.delay = "0.3-5 seconds",
proximitySensor.dimensions = "32 x 24 x 24 mm"
RETURN proximitySensor;

CREATE (buzzer:Actuator)
SET buzzer.type = "Buzzer",
buzzer.id = randomUUID(),
buzzer.name = "Active Buzzer",
buzzer.description = "is an electronic device that produces sound. It is a type of transducer, which converts electrical energy to sound. Different types of buzzers produce different types of sounds. The most common types of buzzers are piezo and magnetic. Piezo buzzers are used for making beeps, tones, and alerts. Magnetic buzzers are used for making continuous tones.",
buzzer.image = "https://www.electronicwings.com/public/images/user_images/images/Arduino/Modules/Active_Buzzer/Active_Buzzer.jpg",
buzzer.createdAt = datetime(),
buzzer.updatedAt = datetime(),

// Feature Updates
buzzer.voltage = "3-5V",
buzzer.current = "5-30mA",
buzzer.frequency = "2-5 kHz",
buzzer.soundLevel = "85 dB",
buzzer.dimensions = "12 x 9 x 6 mm"
RETURN buzzer;

CREATE (led:Actuator)
SET led.type = "LED",
led.id = randomUUID(),
led.name = "RGB LED",
led.description = "is a light-emitting diode that can emit light of various colors. It is made of three LEDs in one package: red, green, and blue. By adjusting the intensity of each color, you can create a wide range of colors. RGB LEDs are commonly used in lighting, displays, and indicators.",
led.image = "https://www.electronicwings.com/public/images/user_images/images/Arduino/Modules/RGB_LED/RGB_LED.jpg",
led.createdAt = datetime(),
led.updatedAt = datetime(),

// Feature Updates
led.voltage = "2-3.3V",
led.current = "20mA",
led.wavelength = "Red: 620-625nm, Green: 520-525nm, Blue: 465-470nm",
led.luminousIntensity = "Red: 200-400 mcd, Green: 400-800 mcd, Blue: 200-400 mcd",
led.dimensions = "5 x 5 x 5 mm"
RETURN led;

CREATE (esp8266:Controller)
SET esp8266.type = "Microcontroller",
esp8266.id = randomUUID(),
esp8266.name = "ESP8266",
esp8266.description = "is a low-cost Wi-Fi microchip with full TCP/IP stack and microcontroller capability produced by Shanghai-based Chinese manufacturer, Espressif Systems. The chip first came to the attention of western makers in August 2014 with the ESP-01 module, made by a third-party manufacturer, AI-Thinker. This small module allows microcontrollers to connect to a Wi-Fi network and make simple TCP/IP connections using Hayes-style commands. However, at first, there was almost no English-language documentation on the chip and the commands it accepted. The very low price and the fact that there were very few external components on the module which suggests that it could eventually be very inexpensive in volume, attracted many hackers to explore the module, chip, and the software on it, as well as to translate the Chinese documentation.",
esp8266.image = "https://www.electronicwings.com/public/images/user_images/images/Arduino/Modules/ESP8266/ESP8266.jpg",
esp8266.createdAt = datetime(),
esp8266.updatedAt = datetime(),

// Feature Updates
esp8266.microcontroller = "Tensilica Xtensa LX106",
esp8266.clockFrequency = "80 MHz",
esp8266.memory = "32-bit RISC CPU: 80 MHz, 64 KB instruction RAM, 96 KB data RAM, 64 KB boot ROM",
esp8266.wifi = "802.11 b/g/n",
esp8266.security = "WPA/WPA2",
esp8266.io = "17 GPIO pins",
esp8266.analogIO = 1,
esp8266.serialInterfaces = ["UART", "SPI", "I2C"],
esp8266.powerOptions = "3.3V",
esp8266.sleepModes = ["Modem-sleep", "Light-sleep"],
esp8266.dimensions = "24 x 16 x 3 mm"
RETURN esp8266;

CREATE (cloudDatabase:Database)
SET cloudDatabase.type = "Database",
cloudDatabase.id = randomUUID(),
cloudDatabase.name = "Neo4j Aura",
cloudDatabase.description = "is a fully managed graph database service that enables you to build and deploy applications backed by a graph database without the operational burden of managing the database yourself. Neo4j Aura is built on the same technology as Neo4j Enterprise, but with the added benefits of a fully managed service.",
cloudDatabase.image = "https://www.electronicwings.com/public/images/user_images/images/Arduino/Modules/Neo4j_Aura/Neo4j_Aura.jpg",
cloudDatabase.createdAt = datetime(),
cloudDatabase.updatedAt = datetime(),

// Feature Updates
cloudDatabase.storage = "1 GB",
cloudDatabase.connections = "100",
cloudDatabase.bandwidth = "10 GB/month",
cloudDatabase.rules = "Customizable security rules",
cloudDatabase.backup = "Automatic daily backups",
cloudDatabase.dimensions = "N/A"

RETURN cloudDatabase;

CREATE (smartphoneApp:Application)
SET smartphoneApp.type = "Application",
smartphoneApp.id = randomUUID(),
smartphoneApp.name = "Blynk",
smartphoneApp.description = "is a platform with iOS and Android apps to control Arduino, Raspberry Pi, and the likes over the Internet. It's a digital dashboard where you can build a graphic interface for your project by simply dragging and dropping widgets.",
smartphoneApp.image = "https://www.electronicwings.com/public/images/user_images/images/Arduino/Modules/Blynk/Blynk.jpg",
smartphoneApp.createdAt = datetime(),
smartphoneApp.updatedAt = datetime(),

// Feature Updates
smartphoneApp.widgets = ["Button", "Slider", "Graph", "LCD", "LED", "Terminal", "Timer", "Value Display"],
smartphoneApp.connectivity = ["Wi-Fi", "Bluetooth", "USB"],
smartphoneApp.security = "SSL/TLS encryption",
smartphoneApp.dimensions = "N/A"
RETURN smartphoneApp;

CREATE (event:Event)
SET event.type = "Event",
event.id = randomUUID(),
event.name = "Motion Detected",
event.description = "is triggered when the PIR sensor detects motion. The event can be used to activate other components like the buzzer or LED.",
event.createdAt = datetime(),
event.updatedAt = datetime()

RETURN event;

CREATE (event:Event)
SET event.type = "Event",
event.id = randomUUID(),
event.name = "Temperature and Humidity Reading",
event.description = "is triggered when the DHT11 sensor provides temperature and humidity data. The event can be used to display the data on the LCD screen.",
event.createdAt = datetime(),
event.updatedAt = datetime()
RETURN event;

CREATE (event:Event)
SET event.type = "Event",
event.id = randomUUID(),
event.name = "Light Intensity Change",
event.description = "is triggered when the LDR detects a change in light intensity. The event can be used to adjust the brightness of the LED.",
event.createdAt = datetime(),
event.updatedAt = datetime()

RETURN event;

// Relationships
MATCH (arduino:Controller {name: "Arduino Nano"})
MATCH (temperatureSensor:Sensor {name: "Temperature and Humidity Sensor"})
MATCH (screen:Display {name: "16x2 LCD Screen"})
MATCH (lightSensor:Sensor {name: "LDR (Light Dependent Resistor)"})
MATCH (proximitySensor:Sensor {name: "HC-SR501"})
MATCH (buzzer:Actuator {name: "Active Buzzer"})
MATCH (led:Actuator {name: "RGB LED"})
MATCH (esp8266:Controller {name: "ESP8266"})
MATCH (cloudDatabase:Database {name: "Neo4j Aura"})
MATCH (smartphoneApp:Application {name: "Blynk"})
MATCH (motionEvent:Event {name: "Motion Detected"})
MATCH (tempEvent:Event {name: "Temperature and Humidity Reading"})
MATCH (lightEvent:Event {name: "Light Intensity Change"})
MERGE (arduino)<-[:SENDS_DATA_TO]-(temperatureSensor)
MERGE (arduino)-[:DISPLAYS_DATA_ON]->(screen)
MERGE (arduino)<-[:SENDS_DATA_TO]-(lightSensor)
MERGE (arduino)<-[:SENDS_DATA_TO]-(proximitySensor)
MERGE (arduino)-[:CONTROLS]->(buzzer)
MERGE (arduino)-[:CONTROLS]->(led)
MERGE (arduino)-[:HAS_CONTROLLER]->(esp8266)
MERGE (arduino)-[:CONNECTS_TO]->(cloudDatabase)
MERGE (arduino)-[:CONNECTS_TO]->(smartphoneApp)

MERGE (tempCondition:Condition {type: "Temperature", value: 28})
MERGE (lightCondition:Condition {type: "Light Intensity", value: 500})
MERGE (motionCondition:Condition {type: "Motion", value: true})


MERGE (temperatureSensor)-[:DETECTS]->(tempCondition)
MERGE (lightSensor)-[:DETECTS]->(lightCondition)

MERGE (proximitySensor)-[:DETECTS]->(motionCondition)
MERGE (motionCondition)-[:CAUSES]->(motionEvent)
MERGE (tempCondition)-[:CAUSES]->(tempEvent)
MERGE (lightCondition)-[:CAUSES]->(lightEvent)
MERGE (motionEvent)-[:TRIGGERS]->(buzzer)
MERGE (motionEvent)-[:TRIGGERS]->(led)
MERGE (tempEvent)-[:TRIGGERS]->(screen)
MERGE (lightEvent)-[:TRIGGERS]->(led)


RETURN arduino, temperatureSensor, screen, lightSensor, proximitySensor, buzzer, led, esp8266, cloudDatabase, smartphoneApp, lightEvent, tempEvent, motionEvent, tempCondition, lightCondition, motionCondition;