class Rain extends Drawable {
  int amount;
  Drawable[] colliders = new Drawable[10];
  boolean[] wasMoved;
  boolean movedFlag;
  int colliderCount = 0;
  int odd = 1;
  
  final int PDOWN = 2;
  final int PLEFT = -1;
  final int PRIGHT = 1;
  final int PSTATIC = 4;
  
  Rain(int amount){
    super(0, 0, width, height);
    this.amount = amount;
    wasMoved = new boolean[canvas.length];
    movedFlag = true;
  }
  
  int odd(){
    //odd=-odd;
    return odd;
  }
  
  int rand(){
    return Math.random()*100 > 50 ? 1 : -1;
    //double r = Math.random();
    //return r > 0.3 ? (movedFlag ? -1 : 1) : (r>0.5 ? 1 : -1); 
    //return odd;
    //return movedFlag ? PLEFT : PRIGHT;
    //return 1;
  }
  
  void update(){
    movedFlag = !movedFlag;
    odd = !movedFlag ? PRIGHT : PLEFT;
    
    for(int a=0; a<amount; a++){
      plot((int)random(w), 0, PDOWN);
    }
    
    if(movedFlag){
      //for(int y=0; y<h; y++){
      for(int y=h-1; y>-1; y--){
        for(int x=0; x<w-1; x++){
          moveParticle(y*w+x);
        }
      }
    }
    else{
      //for(int y=0; y<h; y++){
      for(int y=h-1; y>-1; y--){
        for(int x=w; x>-1; x--){
          moveParticle(y*w+x);
        }
      }
    }
  }
  
  void moveParticle(int i){
    int d = canvas[i];
    moveParticle(i, d, 0);
  }
  
  void moveParticle(int i, int d){
    moveParticle(i, d, 0);
  }
  
  void moveParticle(int i, int d, int extraM){
    int target = 0;
    int m = 20;
    boolean first = true;
    boolean yes = false;
    if(canvas[i] != 0 && (canvas[i] != PSTATIC || extraM > 0)){
        if(wasMoved[i] != movedFlag){
          if(d != PLEFT || d != PRIGHT){ d = rand(); }
          while(m > 0){
            yes = false;
            if(!checkCollision(i+target+w)){
              target += w;
              m-=9;
              yes = true;
            }
            else if(!checkCollision(i+target+d+w)){
              target += d+w;
              m-=6;
              yes = true;
            }
            else if(!checkCollision(i+target+d)){
              target += d;
              m--;
              yes = true;
            }
            else if(first){
              if(!checkCollision(i+target-d)){
                d=-d;
                yes = true;
              }
            }
            
            first = false;
            if(!yes){ break; }
          }
          
          if(target != 0){
            plot(i+target, d);
            plot(i, 0);
            if(target + i > -1 && target + i < canvas.length){
              wasMoved[i+target] = movedFlag;
            }
            activateNeighbours(i, d);
          }
          else if(atleastNeighbours(i, 6)){
            plot(i, PSTATIC);
          }
        }
      }
      wasMoved[i] = movedFlag;
  }
  
  void activateNeighbours(int pos, int d){
    for(int i=0; i<neighbours.length; i++){
      if(pos+neighbours[i] > 0 && pos+neighbours[i] < canvas.length-1){
        if(canvas[pos+neighbours[i]] != 0){
          canvas[pos+neighbours[i]] = d;
        }
      }
    }
  }
  
  void addCollider(Drawable col){
    colliders[colliderCount] = col;
    colliderCount++;
  }
  
  boolean checkCollision(int pos){
    if(pos > 0 && pos < canvas.length-1){
      if(canvas[pos] != 0){
        return true;
      }
      for(int i=0; i<colliderCount; i++){
        if(colliders[i].canvas[pos] != 0){
          return true;
        };
      }
    }  
    return false;
  }
  
  int[] neighbours = {-w-1,-w,-w+1,-1,1,w-1,w,w+1};
  int countNeighbours(int pos){
    int count = 0;
    for(int i=0; i<neighbours.length; i++){
      if(pos+neighbours[i] > 0 && pos+neighbours[i] < canvas.length-1){
        if(canvas[pos+neighbours[i]] != 0){
          count++;
        }
      }
    }
    return count;
  }
  
  boolean atleastNeighbours(int pos, int min){
    int count = 0;
    for(int i=0; i<neighbours.length; i++){
      if(pos+neighbours[i] > 0 && pos+neighbours[i] < canvas.length-1){
        if(canvas[pos+neighbours[i]] != 0){
          count++;
          if(count >= min){
           return true;
          }
        }
      }
    }
    return false;
  }
  
  int getColor(int pos){
      //int nc = countNeighbours(pos);
      if(canvas[pos] == 0 /*&& nc < 5*/){
        return 0;
      }
      /*else if (canvas[pos] == PSTATIC){
        return 0xff000000;
      }*/
      else {
        //return 0xff88bbff;
        return 0xff4499ff;
      }
  }
}
