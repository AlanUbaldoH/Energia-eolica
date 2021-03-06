import controlP5.*;
import processing.serial.*;

ControlP5 cp5; 
ControlFont font;
Serial myPort;

float posDeseada, posReal;
int indiceSlider = 0;
int indiceKnob = 0;
int indiceButton = 0;
int maxImages=2;//numero maximo de imagenes
int indexImg=0;
PImage [] imagenes=new PImage[maxImages];
PImage turbina;
PImage [] aire=new PImage[maxImages];
Graficas g = new Graficas(width, height, 0);
boolean pH;
float vol=0;
int x=0;

Slider agregaSlider(String nombre, float min, float max, float inicial) {
  Slider slider;
  slider = cp5.addSlider(nombre).setRange(min, max).setSize(180, 25);
  slider.setPosition(30, 100 + 40 * indiceSlider);
  slider.getCaptionLabel().setFont(font);  // cambiar fuente de la etiqueta
  slider.getCaptionLabel().setColor(0); //
  slider.getValueLabel().setFont(font);    // cambiar fuente del valor mostrado
  slider.setValue(inicial);
  slider.setColorValue(color(255));
  slider.setColorActive(color(153, 51, 0));
  slider.setColorForeground(color(255, 153, 0));
  slider.setColorBackground(color(0));
  indiceSlider++;
  return slider;
}

Knob agregaKnob(String nombre, float min, float max, float inicial, float radio){
  Knob knob;
  knob = cp5.addKnob(nombre).setRadius(radio).setRange(min,max).setValue(inicial);
  knob.setPosition(250 + 400 * indiceKnob, 8*(displayHeight/10) - 50);
  knob.getCaptionLabel().setFont(font);  // cambiar fuente de la etiqueta
  knob.getCaptionLabel().setColor(0); //
  knob.getValueLabel().setFont(font);
  knob.setColorValue(color(255));
  knob.setColorActive(color(127, 255, 212));
  knob.setColorForeground(color(175, 238, 238));
  knob.setColorBackground(color(0));
  indiceKnob++;
  return knob;  
}

Button agregaButton(String nombre){
  Button button;
  button = cp5.addButton(nombre).setPosition((displayWidth/2) + 180 + 400 * indiceButton,  8*(displayHeight/10)-20).setSize(200, 50);
  button.getCaptionLabel().setFont(font);  // cambiar fuente de la etiqueta
  button.getCaptionLabel().setColor(255); //
  button.getValueLabel().setFont(font);
  button.setColorValue(color(255));
  button.setColorForeground(color(114, 158, 161));
  button.setColorBackground(color(0));
  indiceButton++;
  return button;
}
void settings(){
  size(displayWidth,displayHeight-50);
}

void setup(){
  PFont pfont = createFont("Verdana", 12);
  font = new ControlFont(pfont, 12);
  cp5 = new ControlP5(this);
  //agregaSlider("Posici??n deseada", 0, 90, 45);  //Inicio,final,Valor por default
  //agregaSlider("Posici??n real", 0, 90, 45);
  agregaKnob("??ngulo de compuerta deseado", 0, 90, 45, 40);
  agregaKnob("??ngulo de compuerta real", 0, 90, 45, 40);
  agregaButton("Iniciar Prueba");
  agregaButton("Paro de emergencia");
  for(int i=0; i<imagenes.length;i++){
  imagenes[i]=loadImage("G"+i+".png");
  aire[i]=loadImage("AIRE"+i+".png");
  }
  turbina=loadImage("B0.png");
  frameRate(15);
  imageMode(CENTER);
  pH=true;
  /*println(Serial.list());
  
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');*/
}

void draw(){
  background(0);
  
  //CUADRO 1
  noStroke();
  fill(76,87,96);
  rect(20, 20, (displayWidth/2) - 20, 7*(displayHeight/10) - 40, 20);
  
  //CUADRO 2
  rect(20, 7*(displayHeight/10), (displayWidth/2) - 20, 4*(displayHeight/15) - 80, 20);
  
  //CUADRO 3
  rect((displayWidth/2) + 20, 7*(displayHeight/10), (displayWidth/2) - 40, 4*(displayHeight/15) - 80, 20);
  
  //CUADRO 4
  rect((displayWidth/2) + 20, 7*(displayHeight/10) - 80, (displayWidth/2) - 40, 60, 20);
  
  // CUADRO RPM
  noStroke();
  fill(114,158,161);
  rect((3*displayWidth/4) - 140, 7*(displayHeight/10) - 70, 100, 40);
  
  // T??tulos
  textSize(14);
  fill(0);
  text(" RPM ", (3*displayWidth/4) - 20, 7*(displayHeight/10) - 50);
  
  //RPM
  /*String inString = myPort.readStringUntil('\n');
  if(inString != null){
    fill(0);
    text(inString, 715, 375);
    //println(inString);
  }*/
  //Animacion
  
  image(imagenes[indexImg],width/2+700,height/2-100);
  image(aire[indexImg],width/2+570,height/2-70);
  image(aire[indexImg],width/2+570,height/2-60);
  image(turbina,width/2+500,height/2-100);
  indexImg=(indexImg+1)%imagenes.length;
  //Graficas
  g.Cuadricula(width-1500,height/2-400);
  vol=abs(sin(x)*10);
  println(vol);
  g.voltaje(x,vol,pH);
  x+=5;
  pH=false;
}
