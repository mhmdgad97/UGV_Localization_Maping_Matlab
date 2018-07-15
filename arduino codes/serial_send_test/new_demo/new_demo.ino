
void setup() {
    Serial.begin(9600);
}
int i=i;
void loop() 
{
  
 //go straight
  for(int i=0;i<5;i++)
  {
      Serial.println("0000001007");
      delay(750);
  }  
      
  for(int i=0;i<5;i++)
  {
      Serial.println("0900001007");
      delay(750);
  }  
      
  for(int i=0;i<5;i++)
  {
      Serial.println("1800001007");
      delay(750);
  }  
  
  for(int i=0;i<5;i++)
  {
      Serial.println("2700001007");
      delay(750);
  }  
 
}
