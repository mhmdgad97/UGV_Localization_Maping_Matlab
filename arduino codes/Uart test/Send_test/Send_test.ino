String ta="A";
String t="360";
String taa="-800";
String taaa="5";
String Stop="Z";
String All;


void setup() {
Serial.begin(9600);
Serial.println("first garbage");
}

void loop() {
  ta=ta+(1%28);
  All=ta+t+taa+taaa+Stop;
  Serial.println(All);
  delay(100);
}


// i want to sendit and recieve it in the form of "A360-8005Z"
