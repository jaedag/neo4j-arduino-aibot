// Retrieve all sensors and their detected conditions
MATCH (sensor:Sensor)-[:DETECTS]->(condition:Condition)
RETURN sensor.createdAt,sensor.name AS Sensor, condition.type AS ConditionType, condition.value AS ConditionValue;

// Retrieve all events triggered by Arduino Nano
MATCH (arduino:Controller {name: "Arduino Nano"})-[:TRIGGERS]->(event:Event)
RETURN event.name AS EventName;

// Retrieve all events triggered by Arduino Nano with their creation date
MATCH (arduino:Controller {name: "Arduino Nano"})-[:TRIGGERS]->(event:Event)
RETURN event.createdAt, event.name AS EventName;

// Retrieve all events triggered by Arduino Nano with their creation date and the sensor that triggered them
MATCH (arduino:Controller {name: "Arduino Nano"})-[:TRIGGERS]->(event:Event)<-[:TRIGGERED]-(sensor:Sensor)
RETURN event.createdAt, event.name AS EventName, sensor.name AS SensorName;

MATCH (arduino:Controller {name: "Arduino Nano"})-[:HAS_CONTROLLER|:CONTROLS|:CONNECTS_TO|:SENDS_DATA_TO]-(device)
RETURN device.name AS DeviceName, labels(device) AS DeviceType;