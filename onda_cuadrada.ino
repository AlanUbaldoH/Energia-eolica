const int outPin = 7;
unsigned int maxv = 0;
unsigned int frecuencia = 1;
bool toogleBit = false;

void setup() {
  pinMode(outPin, OUTPUT);
  digitalWrite(outPin, LOW);

  cli();
  TCCR1A = 0;
  TCCR1B = 0;
  TCCR1B |= B00000100;
  TCCR1B |= (1 << WGM12);
  TIMSK1 |= B0000010;
  maxv = (int) ((16e6)/(2*255*frecuencia))-1;
  OCR1A = maxv;
  sei();
  Serial.begin(9600);

}

void loop() {
  Serial.println(maxv);
  if(toogleBit == true){
    digitalWrite(outPin, HIGH);
    }
    else{
      digitalWrite(outPin, LOW);
      }

}

ISR(TIMER1_COMPA_vect){
  toogleBit = !toogleBit;
}
