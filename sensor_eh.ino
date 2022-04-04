/* 
 *  Programa que permite contar los pulsos por minuto mediante interrupciones de tiempo, realizadas cada segundo.
 */
 
volatile unsigned long contador = 0; // Variable global usada en loop() y función ISR
volatile unsigned long rpm = 0;
unsigned long anteriorRPM = 0;
unsigned long anteriorContador = 0;

void setup() {
  cli();  // Detiene las interrupciones hasta realizar los ajustes 
  
  // Configuración del TIMER1
  TCCR1A = 0;   // El registro de control A queda todo en 0
  TCCR1B = 0;   // El registro de control B queda todo en 0 

  // Configuración del valor del registro A (para la interrupción cada segundo)
  OCR1A = 62499;   // Carga del registro de comparación [16MHz/(256*1Hz)] - 1 = 62499
  
  // Configuración del preescaler al valor deseado mediante el cambio de CS10, CS11 y CS12
  //TCCR1B |= (1 << WGM12)|(1 << CS11)|(1 << CS10);  // Modo CTC, prescaler de 64: CS12 = 0, CC11 =1, CC10 = 1 

  // Configuración del preescaler al valor deseado mediante el cambio de CS12 (para la interrupción cada segundo)
  TCCR1B |= (1 << WGM12)|(1 << CS12);  // Modo CTC, prescaler de 256: CS12 = 1
  
  // Se habilita el compare match mode en el registro A
  TIMSK1 |= (1 << OCIE1A);   // Habilita interrupción por igualdad de comparación
  

  Serial.begin(9600);
  // Para el arduino UNO, puede emplearse el PIN 2 o 3
  attachInterrupt(digitalPinToInterrupt(2), interrupcionExterna, FALLING); //PIN 2, Función ISR, flanco de bajada 
  
  sei();
}

void loop() {
  //  Método 1
  if (anteriorRPM != rpm){
    //Serial.print("\n Pulsos por minuto: ");
    Serial.println(rpm);
    anteriorRPM = rpm; // Actualiza el valor anterior 
    }
}

// Función que se llama cuando dectecta la interrupción (detectar eventos de forma inmediata) 
void interrupcionExterna(){
  contador++;
}

ISR(TIMER1_COMPA_vect){
  TCNT1 = 0; // Inicializa el temporizador
  
  rpm = (contador * 60);
  contador = 0;
  }
