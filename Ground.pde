class Ground extends Drawable{
  Ground(int x, int y, int w, int h){
    super(x, y, w, h);
    int seed = (int)(Math.random() * 199999);
    randomSeed(seed++);
    generateBase(seed++);
    generateLayer(seed++, 100, 0xffeed888);
    drop();
    generateLayer(seed++, 40, 0xff66aa66);
    drop();
    
    generateHoles(seed++, int(random(10)), 0, 0, 2);
    drop();
    
    /*
    for(int i=0; i<canvas.length; i++){
      if(canvas[i] != 0){
        canvas[i] = 0xff000088;
      }
      else{
        canvas[i] = 0;
      }
    }
    */
    
    
  }
  
  void generateBase(long seed){
    randomSeed(seed);
    
    float vy = random(2)-1;
    float cy = (h/2) + (random(50)-25);
    float roughness = random(1);
    for(int x=0; x<w; x++){
      vy += (random(2)-1) * roughness;
      
      float marginTop = h*0.5;
      float marginBottom = h*0.3;
      if(cy < marginTop && vy < 0){
        vy -= vy*((marginTop-cy)/marginTop);
      }
      else if(cy>h-marginBottom && vy > 0){
        vy -= vy*((cy-(h-marginBottom))/marginBottom);
      }
      
      cy += vy;
      
      for(int y=max(0,int(cy)); y<h; y++){
        canvas[x + y * w] = 0xffeed888;
      }
    }
  }
  
  void generateLayer(long seed, int thickness, int c){
    randomSeed(seed);
    
    float vy = random(2)-1;
    float cy = random(thickness*2)-thickness;
    float roughness = random(0.5);
    for(int x=0; x<w; x++){
      vy += (random(2)-1) * roughness;
      
      if(cy < -thickness){
        vy = 0;
        cy = -thickness;
      }
      else if(cy>thickness && vy > 0){
        vy = 0;
        cy = thickness;
      }
      
      cy += vy;
      
      for(int y=0; y<cy; y++){
        if(cy>0){
          canvas[x + y * w] = c;
        }
      }
    }
  }
  
  void generateHoles(int seed, int amount){
    generateHoles(seed, amount, 0, 0, 0);
  }
  
  void generateHoles(int seed, int amount, int radius, int p, int level){
    for(int i=0; i<amount; i++){
      int pos;
      int r = (int)random(radius > 0 ? radius : 50) + 5;
      if(radius > 0){
        pos = p + int(random(radius) - radius/2.0) * w;
        pos += int(random(radius) - radius/2.0); 
      }
      else {
          pos = int(random(w) + random(h) * w);
      }
      
      if(level > 0){
        generateHoles(seed, int(r/10.0), int(r*0.8), pos, level-1);
      }
      
      circle(pos, r, 0);
    }
  }
  
  void drop(){
    int ly = 0;
    int pos = 0;
    for(int x=0; x<w; x++){
      ly = h;
      for(int y=h-1; y>=0; y--){
        pos = x + y * w;
        if(canvas[pos] != 0){
          canvas[x + ly * w] = canvas[pos];
          plot(pos, 0);
          ly--;
        }
      }
    }
  }
}