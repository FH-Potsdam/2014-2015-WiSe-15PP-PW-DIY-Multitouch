// Knock the on LED
// written by fabianmoronzirfas
// knock the table blink a led
// written for the OLIMEX-S85
// based on this http://arduino.cc/en/Tutorial/Knock

//Connect the piezo + to pin #2 (analog 1)
//Connect the piezo - to GND

// Connect parallel a 10kOHM resistor to pin #2
// Connect parallel the same 10kOHM resistor to GND


int sensorValue = 0;// the value we read and compare
int ledpin = 1; // build in LED Digital 
// it is wired but we call the analog pins with their own numbers
// so if we would use the pin as digital pin it would be number 2
// but if we use it as an analog pin it is number 1
int piezopin = 1;

// the threshold when the knock is loud enough
int threshold = 10;

// setup executed once
void setup(){
  // the olimexino has an build in LED at digital pin 1
  pinMode(ledpin, OUTPUT); // set the pin as output
  digitalWrite(ledpin, LOW);// turn it off
   // this is for the uno or other arduino boards wo can write to the serial
//  Serial.begin(9600);
}

void loop(){
  
  sensorValue = analogRead(piezopin); // read the knocj
//  Serial.println(sensorValue); // also for Arduion Uno and others
  
  // now we check if the knock is loud enough
  if(sensorValue >= threshold){
    // it s loud enough
    digitalWrite(ledpin,HIGH); // turn on the LED
  }else{
    // knock harder
    digitalWrite(ledpin,LOW); // turn of the LED
  }
}
