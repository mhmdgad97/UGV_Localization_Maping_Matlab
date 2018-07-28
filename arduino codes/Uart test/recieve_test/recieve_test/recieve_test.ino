char inData[64];
char inChar=-1;

void setup(){
   Serial.begin(9600);
}


void loop(){
    byte numBytesAvailable= Serial.available();

    // if there is something to read
    if (numBytesAvailable > 0){
        // store everything into "inData"
        int i;
        for (i=0;i<numBytesAvailable;i++){
            inChar= Serial.read();
            inData[i] = inChar;
        }

        inData[i] = '\0';


        Serial.print("Arduino Received: ");
        Serial.println(inData);
    }
}
