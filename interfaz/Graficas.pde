class Graficas {

  int nX, nY, colF;
  int anteriorXT , anteriorXH;
  float anteriorYT, anteriorYH;
  //boolean primeroT, primeroH;
  Graficas (int x, int y, int cF){
    nX = x;
    nY = y; 
    colF  = cF;
  }
  
  void Cuadricula(int posx, int posy){
    fill(0, 0, 0);
    text("ghg", (posx), posy-50);
    stroke(255,255,255);   
    for (int  j = posy-10 ; j <= posx+500; j = j + 15){
      line (j, 80, j, (posy ) + 595);      } // Vert
    for (int  j = posx-340 ; j <= (posy) + 600; j = j + 15){
      line (posy-10, j, posx +495, j);} // Horiz
    int i = 0;
    for (int n = (posy) + 600; n >= (posy) - 20; n = n - 15){
      fill(0, 0, 0);
      text(i, posx-350, n + 5);
      i = i+1;
      
    }
  }
  
  void voltaje(int x, float vol, boolean primeroH){
    float vH = 700-(vol*15); 
      ellipse(300+x, vH, 5, 5);
      if (primeroH == false){
        stroke(255,0,0);
        line(300+anteriorXH, anteriorYH, 300+x, vH);
      }
        anteriorXH = x;
        anteriorYH = vH;   
  }
}
