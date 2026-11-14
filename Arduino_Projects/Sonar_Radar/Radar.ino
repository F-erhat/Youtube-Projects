
#include <Servo.h>

Servo radarServo;

// Pin definitions
const int servoPin = 8;
const int trigPin = 9;
const int echoPin = 10;

// Servo scanning range
const int minAngle = 0;
const int maxAngle = 180;

// Distance measurement
long duration;
int distance;

void setup() {
  Serial.begin(9600);

  radarServo.attach(servoPin);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  radarServo.write(minAngle);
  delay(500);
}

int measureDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH, 30000);

  if (duration == 0) {
    return 999;
  }

  return (int)(duration * 0.0343 / 2);
}

void sendRadarData(int angle) {
  distance = measureDistance();

  Serial.print(angle);
  Serial.print(",");
  Serial.print(distance);
  Serial.print(".");
}

void loop() {

  // Scan from 0 to 180 degrees
  for (int angle = minAngle; angle <= maxAngle; angle++) {
    radarServo.write(angle);
    delay(30);

    sendRadarData(angle);
  }

  // Scan from 180 to 0 degrees
  for (int angle = maxAngle; angle >= minAngle; angle--) {
    radarServo.write(angle);
    delay(30);

    sendRadarData(angle);
  }
}
