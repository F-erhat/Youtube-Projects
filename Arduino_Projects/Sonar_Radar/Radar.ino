
const int trigPin = 8;
const int echoPin = 9;

const int redLED = 3;
const int greenLED = 5;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  pinMode(redLED, OUTPUT);
  pinMode(greenLED, OUTPUT);

  Serial.begin(9600);
}

void loop() {

  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);

  digitalWrite(trigPin, LOW);

  long sure = pulseIn(echoPin, HIGH, 30000);

  if (sure == 0) {
    Serial.println("YANKI ALINAMADI!");

    digitalWrite(redLED, LOW);
    digitalWrite(greenLED, LOW);
  }
  else {
    float mesafe = sure * 0.0343 / 2;

    Serial.print("Mesafe: ");
    Serial.print(mesafe);
    Serial.println(" cm");

    if (mesafe <= 40) {
      digitalWrite(redLED, HIGH);
      digitalWrite(greenLED, LOW);
    }
    else {
      digitalWrite(redLED, LOW);
      digitalWrite(greenLED, HIGH);
    }
  }

  delay(200);
}
