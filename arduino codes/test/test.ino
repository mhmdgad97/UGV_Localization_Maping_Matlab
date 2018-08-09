void setup() {
  Serial.begin(115200);
}

void loop() {
  // all this is for test you can delete it if you want
   for (int i=0;i<10;i++)
   {
      Serial.println("23970008");
      delay(500);
   }

  for (int i=0;i<10;i++)
  {
      Serial.println("23970908");  
      delay(500);
  }
  
  for (int i=0;i<10;i++)
  {
      Serial.println("23971808");  
      delay(500);
  }
  
  for (int i=0;i<10;i++)
  {
      Serial.println("23972708");  
      delay(500);
  }
}
