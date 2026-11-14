import processing.serial.*;

Serial myPort;
int iAngle = 90;
int iDistance = 999;
float maxRange = 40;      // cm
float R;                  // yarıçap (piksel)
float cx, cy;             // radar merkezi

void setup() {
  size(1200, 700);
  smooth();
  cx = width / 2;
  cy = height - 80;
  R = width / 2 - 60;
  background(0);

  println(Serial.list());          // portları konsola yazar
  myPort = new Serial(this, "COM4", 9600);
  myPort.bufferUntil('.');
  textFont(createFont("Arial Bold", 24));
}

void draw() {
  // yavaş sönen iz efekti
  noStroke();
  fill(0, 12);
  rect(0, 0, width, height - 70);

  drawRadar();
  drawObject();
  drawLine();
  drawText();
}

int toNumber(String t) {
  int result = 0;
  for (int i = 0; i < t.length(); i++) {
    char c = t.charAt(i);
    if (c >= '0' && c <= '9') {
      result = result * 10 + (c - '0');
    }
  }
  return result;
}

void serialEvent(Serial p) {
  String s = p.readStringUntil('.');
  if (s == null) return;
  int comma = s.indexOf(',');
  if (comma < 0) return;
  iAngle = toNumber(s.substring(0, comma));
  iDistance = toNumber(s.substring(comma + 1));
}

void drawRadar() {
  pushMatrix();
  translate(cx, cy);
  noFill();
  stroke(98, 245, 31);
  strokeWeight(2);

  // mesafe halkaları (10, 20, 30, 40 cm)
  for (int i = 1; i <= 4; i++) {
    float r = R * i / 4.0;
    arc(0, 0, r * 2, r * 2, PI, TWO_PI);
  }
  // açı çizgileri
  for (int a = 0; a <= 180; a += 30) {
    line(0, 0, R * cos(radians(a)), -R * sin(radians(a)));
  }
  line(-R, 0, R, 0);

  // yazılar
  fill(98, 245, 31);
  noStroke();
  textSize(18);
  textAlign(CENTER, CENTER);
  for (int i = 1; i <= 4; i++) {
    text(i * 10 + "cm", R * i / 4.0 - 5, 15);
  }
  for (int a = 30; a <= 150; a += 30) {
    text(a + "°", (R + 28) * cos(radians(a)), -(R + 28) * sin(radians(a)));
  }
  popMatrix();
}

void drawObject() {
  if (iDistance < maxRange) {
    pushMatrix();
    translate(cx, cy);
    strokeWeight(9);
    stroke(255, 10, 10);
    float d = iDistance * (R / maxRange);
    line(d * cos(radians(iAngle)), -d * sin(radians(iAngle)),
         R * cos(radians(iAngle)), -R * sin(radians(iAngle)));
    popMatrix();
  }
}

void drawLine() {
  pushMatrix();
  translate(cx, cy);
  strokeWeight(6);
  stroke(30, 250, 60);
  line(0, 0, R * cos(radians(iAngle)), -R * sin(radians(iAngle)));
  popMatrix();
}

void drawText() {
  noStroke();
  fill(0);
  rect(0, height - 70, width, 70);
  fill(98, 245, 31);
  textSize(30);
  textAlign(LEFT, CENTER);
  String durum = (iDistance < maxRange) ? "Menzilde" : "Menzil Dışı";
  text("Nesne: " + durum, 40, height - 35);
  text("Açı: " + iAngle + "°", 500, height - 35);
  if (iDistance < maxRange) {
    text("Mesafe: " + iDistance + " cm", 800, height - 35);
  } else {
    text("Mesafe: --", 800, height - 35);
  }
}