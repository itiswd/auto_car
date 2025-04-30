#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "اسم_شبكة_الواي_فاي";
const char* password = "كلمة_المرور";

WebServer server(80);

// تعريف مخارج المحركات
const int motor1Pin1 = 2; 
const int motor1Pin2 = 3; 
const int motor2Pin1 = 4; 
const int motor2Pin2 = 5;

void setup() {
  Serial.begin(115200);
  
  // تهيئة مخارج المحركات
  pinMode(motor1Pin1, OUTPUT);
  pinMode(motor1Pin2, OUTPUT);
  pinMode(motor2Pin1, OUTPUT);
  pinMode(motor2Pin2, OUTPUT);
  
  // الاتصال بالواي فاي
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("جاري الاتصال بالواي فاي...");
  }
  
  Serial.println("تم الاتصال!");
  Serial.println(WiFi.localIP());
  
  // تعريف مسارات السيرفر
  server.on("/forward", HTTP_GET, []() {
    forward();
    server.send(200, "text/plain", "Forward");
  });
  
  server.on("/backward", HTTP_GET, []() {
    backward();
    server.send(200, "text/plain", "Backward");
  });
  
  server.on("/left", HTTP_GET, []() {
    left();
    server.send(200, "text/plain", "Left");
  });
  
  server.on("/right", HTTP_GET, []() {
    right();
    server.send(200, "text/plain", "Right");
  });
  
  server.on("/stop", HTTP_GET, []() {
    stopCar();
    server.send(200, "text/plain", "Stop");
  });
  
  server.begin();
}

void loop() {
  server.handleClient();
}

void forward() {
  digitalWrite(motor1Pin1, HIGH);
  digitalWrite(motor1Pin2, LOW);
  digitalWrite(motor2Pin1, HIGH);
  digitalWrite(motor2Pin2, LOW);
}

void backward() {
  digitalWrite(motor1Pin1, LOW);
  digitalWrite(motor1Pin2, HIGH);
  digitalWrite(motor2Pin1, LOW);
  digitalWrite(motor2Pin2, HIGH);
}

void left() {
  digitalWrite(motor1Pin1, LOW);
  digitalWrite(motor1Pin2, HIGH);
  digitalWrite(motor2Pin1, HIGH);
  digitalWrite(motor2Pin2, LOW);
}

void right() {
  digitalWrite(motor1Pin1, HIGH);
  digitalWrite(motor1Pin2, LOW);
  digitalWrite(motor2Pin1, LOW);
  digitalWrite(motor2Pin2, HIGH);
}

void stopCar() {
  digitalWrite(motor1Pin1, LOW);
  digitalWrite(motor1Pin2, LOW);
  digitalWrite(motor2Pin1, LOW);
  digitalWrite(motor2Pin2, LOW);
}