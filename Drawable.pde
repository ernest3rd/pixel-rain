class Drawable{
  int[] canvas;
  int x, y, w, h;
  
  Drawable(){
    this(0,0,1,1);
  }
  
  Drawable(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    canvas = new int[w + h * w];
  }
  
  void draw(int[] pixels){
    draw(pixels, width, x, y);
  }
  
  void draw(int[] pixels, int pixelsWidth){
    draw(pixels, pixelsWidth, x, y);
  }
  
  void draw(int[] pixels, int pixelsWidth, int x, int y){
    int offset = x+y*pixelsWidth;
    int rowOffset = pixelsWidth-w;
    int offsetCounter = w;
    for(int i=0; i<canvas.length; i++){
      // TODO: Jump to next row if pixel is beyond target width
      int c = getColor(i);
      if(/*canvas[i] != 0 && */ c != 0 && offset+i>0){
        if(offset+i<pixels.length){
          pixels[offset+i] = c;
        }
        else{
          return;
        }
      }
      if(--offsetCounter == 0){
        offsetCounter = w;
        offset += rowOffset;
      }
    }
  }
  
  void circle(int pos, int radius, int c){
    int dy = (int)pos / w;
    int dx = pos - dy * w;
    circle(dx, dy, radius, c);
  }
  
  void circle(int x, int y, int radius, int c){
    int radius2 = radius*radius;
    for(int dy=-radius; dy<radius; dy++){
      for(int dx=-radius; dx<radius; dx++){
        if(dx*dx+dy*dy < radius2){
          plot(x+dx, y+dy, c);
        }
      }
    }
  }
  
  void plot(int pos, int c){
    if(pos > 0 && pos < canvas.length){
      canvas[pos] = (short)c;
    }
  }
  
  void plot(int x, int y, int c){
    int pos = x + y * w;
    plot(pos, c);
  }
  
  int getColor(int pos){
    return canvas[pos];
  }
}