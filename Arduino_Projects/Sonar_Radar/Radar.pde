
import processing.serial.*;

Serial myPort;

int iAngle = 90;
int iDistance = 999;

float maxRange = 40;

float R;
float cx, cy;

// Her açı için tespit edilen engel mesafesi
int[] detectedDistance = new int[181];

void setup() {
  size(1200, 700);
  smooth();

  cx = width / 2;
  cy = height - 80;
  R = width / 2 - 60;

  println(Serial.list());

  // Arduino'nun COM portunu kontrol et
  myPort = new Serial(this, "COM4", 9600);
  myPort.bufferUntil('\n');

  textFont(createFont("Arial Bold", 24));
}

void draw() {

  background(0);

  drawRadar();
  drawDetectedObjects();
  drawLine();
  drawText();
}

// Arduino'dan gelen verileri oku
void serialEvent(Serial p) {

  String data = p.readStringUntil('\n');

  if (data == null) return;

  data = trim(data);

  String[] parts = split(data, ',');

  if (parts.length == 2) {

    iAngle = constrain(int(parts[0]), 0, 180);
    iDistance = int(parts[1]);

    // Engel bulunduysa hafızaya kaydet
    if (iDistance <= maxRange && iDistance > 0) {
      detectedDistance[iAngle] = iDistance;
    }
  }
}

void drawRadar() {

  pushMatrix();
  translate(cx, cy);

  noFill();
  stroke(98, 245, 31);
  strokeWeight(2);

  // Mesafe halkaları
  for (int i = 1; i <= 4; i++) {

    float r = R * i / 4.0;

    arc(0, 0, r * 2, r * 2, PI, TWO_PI);
  }

  // Açı çizgileri
  for (int a = 0; a <= 180; a += 30) {

    line(0, 0,
      R * cos(radians(a)),
      -R * sin(radians(a)));
  }

  line(-R, 0, R, 0);

  fill(98, 245, 31);
  noStroke();

  textSize(18);
  textAlign(CENTER, CENTER);

  for (int i = 1; i <= 4; i++) {

    text(i * 10 + "cm",
      R * i / 4.0 - 5, 15);
  }

  for (int a = 30; a <= 150; a += 30) {

    text(a + "°",
      (R + 28) * cos(radians(a)),
      -(R + 28) * sin(radians(a)));
  }

  popMatrix();
}

// Daha önce bulunan engelleri göster
void drawDetectedObjects() {

  pushMatrix();
  translate(cx, cy);

  stroke(255, 0, 0);
  strokeWeight(10);

  for (int a = 0; a <= 180; a++) {

    if (detectedDistance[a] > 0) {

      float d = detectedDistance[a] * (R / maxRange);

      float x = d * cos(radians(a));
      float y = -d * sin(radians(a));

      point(x, y);
    }
  }

  popMatrix();
}

// Anlık servo yönünü göster
void drawLine() {

  pushMatrix();
  translate(cx, cy);

  strokeWeight(5);
  stroke(30, 250, 60);

  line(0, 0,
    R * cos(radians(iAngle)),
    -R * sin(radians(iAngle)));

  popMatrix();
}

// Bilgiler
void drawText() {

  noStroke();
  fill(0);

  rect(0, height - 70, width, 70);

  fill(98, 245, 31);

  textSize(25);
  textAlign(LEFT, CENTER);

  text("Açı: " + iAngle + "°", 40, height - 35);

  if (iDistance <= maxRange) {

    fill(255, 40, 40);

    text("ENGEL VAR!", 400, height - 35);

    text("Mesafe: " + iDistance + " cm",
      750, height - 35);
  }
  else {

    fill(98, 245, 31);

    text("TEMİZ ALAN", 400, height - 35);

    text("Mesafe: --",
      750, height - 35);
  }
}
