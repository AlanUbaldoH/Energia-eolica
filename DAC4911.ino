#include "MCP_DAC.h"

MCP4911 MCP(11,13);   //Inicializar DAC
uint16_t salida = 0;

void setup() {
  MCP.begin(10);
  delay(100);
  Serial.begin(9600);
}

void loop() {/*
  for(int i = 0; i < 360; i++){
    double seno = sin((double)i/(180.0d/PI));
    double senoBias = (512.0d * seno + 512.0d);
    salida = senoBias;
    }
  if (salida > 1023) salida = 1023;
  else if (salida < 0) salida = 0;
  
  Serial.println(salida);
  MCP.analogWrite(salida, 0);
  delay(1000);*/

  for (int angulo = 0; angulo <360; angulo+=5){
    double anguloRad = angulo* M_PI / 180;
    double sinResultado = sin(anguloRad);
    int sinBias = (int)(512.0d * sinResultado + 512.0d);
    
    if (sinBias > 1023) sinBias = 1023;
    else if (sinBias < 0) sinBias = 0;

    Serial.print("sin(");
    Serial.print(angulo);
    Serial.print("°) = ");
    Serial.println(sinBias);

    MCP.analogWrite(sinBias, 0);
    delay(100);
  }
}
