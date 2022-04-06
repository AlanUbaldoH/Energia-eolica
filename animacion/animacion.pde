int maxImages=7;//numero maximo de imagenes
int indexImg=0;
PImage [] imagenes=new PImage[maxImages];


void setup(){
  size(400,400);
  for(int i=0; i<imagenes.length;i++){
  images[i]=loadImage("Nombre"+i+".png");
  }
  frameRate(15);
  
}

void draw(){
background(0);
image(image[indexImg],width/2,height/2);
indexImg=(indexImg+1)%imagenes.length;
}
