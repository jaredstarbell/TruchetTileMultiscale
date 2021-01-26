import java.util.Collections;

// Truchet Tile Multiscale
//   Jared S Tarbell
//   March 21, 2020
//   Albuquerque, New Mexico USA
//   Based on work described by Christopher Carlson 
//      www.christophercarlson.com/portfolio/multi-scale-truchet-patterns/

ArrayList<TTile> tiles = new ArrayList<TTile>();

int maxgen = 5;

void setup() {
  size(1200,1200,FX2D);
  background(0);
  rectMode(CENTER);
  
  init();
}

void init() {
  tiles.clear();
  TTile t = new TTile(width/2,height/2,width*.6,0,0);
  tiles.add(t);
}

void draw() {
}

void render() {
  background(0);
  for (TTile t:tiles) t.render();
  
}

void subdivide() {
  if (tiles.size()==0) return;
  
  int i = floor(random(tiles.size()));
  TTile t = tiles.get(i);
  if (t.subdivided) return;
  if (t.gen>=maxgen) return;
  
  // make a new tile in the corners
  float dx = t.w/4;
  float dy = t.w/4;
  float nw = t.w/2;
  int ns = (t.state+1)%2;
  TTile tA = new TTile(t.x+dx,t.y+dy,nw,ns,t.gen+1);
  tiles.add(tA);
  TTile tB = new TTile(t.x-dx,t.y+dy,nw,ns,t.gen+1);
  tiles.add(tB);
  TTile tC = new TTile(t.x-dx,t.y-dy,nw,ns,t.gen+1);
  tiles.add(tC);
  TTile tD = new TTile(t.x+dx,t.y-dy,nw,ns,t.gen+1);
  tiles.add(tD);
  
  t.subdivided = true;
  //tiles.remove(t);
  
  // sort the tiles by size, smallest tiles first
  Collections.sort(tiles);
  
  // render the whole tile set
  //render();
}

void subdivideAll() {
  ArrayList<TTile> temp = new ArrayList<TTile>();
  for (TTile tp:tiles) temp.add(tp);
  
  //for (int i=temp.size()-1;i>=0;i--) {
  //  TTile t = temp.get(i);
  for (TTile t:temp) {  
    if (!t.subdivided) {
      // make a new tile in the corners
      float dx = t.w/4;
      float dy = t.w/4;
      float nw = t.w/2;
      int ns = (t.state+1)%2;
      TTile tA = new TTile(t.x+dx,t.y+dy,nw,ns,t.gen+1);
      tiles.add(tA);
      TTile tB = new TTile(t.x-dx,t.y+dy,nw,ns,t.gen+1);
      tiles.add(tB);
      TTile tC = new TTile(t.x-dx,t.y-dy,nw,ns,t.gen+1);
      tiles.add(tC);
      TTile tD = new TTile(t.x+dx,t.y-dy,nw,ns,t.gen+1);
      tiles.add(tD);
      
      t.subdivided=true;
      //tiles.remove(t);
    }
  }
  
  // sort the tiles by size, smallest tiles first
  Collections.sort(tiles);
  
  //render();
}

void mouseOver(TTile t) {
  if (!t.modified) {
    t.motif = floor(random(6));
    t.modified = true;
    render();
  }
}

void checkOver() {
  for (TTile t:tiles) {
    if (mouseX>t.x-t.w/2 && mouseX<t.x+t.w/2 && mouseY>t.y-t.w/2 && mouseY<t.y+t.w/2) {
      mouseOver(t);
    } else {
      t.modified = false;
    }
  }
}

void clickOver() {
  for (TTile t:tiles) {
    if (mouseX>t.x-t.w/2 && mouseX<t.x+t.w/2 && mouseY>t.y-t.w/2 && mouseY<t.y+t.w/2) {
      // force a change to the tile
      t.modified = false;
      mouseOver(t);
    }
  }
}


void mouseMoved() {
  checkOver(); 
}

void mousePressed() {
  clickOver();
}

void keyPressed() {
  if (key==' ') init();
  if (key=='a' || key=='A') subdivideAll();
  if (key=='d' || key=='D') subdivide();
  if (key=='r' || key=='R') render();
  if (key=='s' || key=='S') Collections.sort(tiles);
  
}
