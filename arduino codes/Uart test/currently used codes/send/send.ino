void setup() {
  Serial.begin(115200);
}

void loop() {
  // all this is for test you can delete it if you want
   for (int i=0;i<5;i++)
   {
      Serial.println("23970007");
      delay(100);
   }

  for (int i=0;i<5;i++)
  {
      Serial.println("23970907");  
      delay(100);
  }
  
  for (int i=0;i<5;i++)
  {
      Serial.println("23971807");  
      delay(100);
  }
  
  for (int i=0;i<5;i++)
  {
      Serial.println("23972707");  
      delay(100);
  }
}
