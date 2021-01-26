class TTile implements Comparable<TTile> {
  
  float x,y;
  float w;
  int state;
  int gen;
  
  int motif;
  float r;
  float tw;
  
  boolean modified = false;
  boolean subdivided = false;

  int segs = 20;                  // segment fidelity of arc paths
  float theta = HALF_PI/segs;     // precalculated radian interval 
  
  TTile(float _x, float _y, float _w, int _state, int _gen) {
    x = _x;
    y = _y;
    w = _w;
    state = _state;
    gen = _gen;
    
    // random rotation
    r = HALF_PI*floor(random(2));

    // pick motif pattern
    motif = floor(random(6));
    
    // compute third width
    tw = w/3;
    
    render();
  }
  
  void render() {  
    //if (subdivided) return;
    pushMatrix();
    translate(x,y);
    rotate(r);
    noStroke();
    
    // draw background
    if (state==0) fill(0); else fill(255);
    
    ellipse(-w/2,-w/2,tw*2,tw*2);
    ellipse(w/2,w/2,tw*2,tw*2);
    ellipse(w/2,-w/2,tw*2,tw*2);
    ellipse(-w/2,w/2,tw*2,tw*2);
    rect(0,0,w,w);
    
    // draw foreground
    if (state==0) fill(255); else fill(0);
    
    if (motif==0) {
      // two arcs
      for (int t=0;t<=segs;t++) {
        float tx = w/2*cos(theta*t);
        float ty = w/2*sin(theta*t);
        ellipse(tx-w/2,ty-w/2,tw,tw);
        ellipse(w/2-tx,w/2-ty,tw,tw);
      }
    } else if (motif==1) {
      // division symbol
      ellipse(0,-w/2,tw,tw);
      ellipse(0,w/2,tw,tw);
      for (int t=0;t<=segs;t++) ellipse(map(t,0,segs,-w/2,w/2),0,tw,tw);
    } else if (motif==2) {
      // four dots
      ellipse(0,-w/2,tw,tw);
      ellipse(0,w/2,tw,tw);
      ellipse(-w/2,0,tw,tw);
      ellipse(w/2,0,tw,tw);
    } else if (motif==3) {
      // soft plus
      for (int t=0;t<=segs;t++) {
        float tx = w/2*cos(theta*t);
        float ty = w/2*sin(theta*t);
        ellipse(tx-w/2,ty-w/2,tw,tw);
        ellipse(w/2-tx,w/2-ty,tw,tw);
        ellipse(tx-w/2,w/2-ty,tw,tw);
        ellipse(w/2-tx,ty-w/2,tw,tw);
        ellipse(0,0,tw,tw);
      }
    } else if (motif==4) {
      // frowny face
      for (int t=0;t<=segs;t++) {
        float tx = w/2*cos(theta*t);
        float ty = w/2*sin(theta*t);
        ellipse(tx-w/2,ty-w/2,tw,tw);
        r = 0;
      }
      ellipse(w/2,0,tw,tw);
      ellipse(0,w/2,tw,tw);
    } else if (motif==5) {
      // man
      for (int t=0;t<=segs;t++) {
        float tx = w/2*cos(theta*t);
        float ty = w/2*sin(theta*t);
        ellipse(tx-w/2,ty-w/2,tw,tw);
        ellipse(w/2-tx,ty-w/2,tw,tw);
      }
      for (int t=0;t<=segs;t++) ellipse(map(t,0,segs,-w/2,w/2),0,tw,tw);
      ellipse(0,w/2,tw,tw);
    }      
    popMatrix();
  }
  
  @Override
    int compareTo(TTile other) {
      if (this.w<other.w) return 1;
      if (this.w==other.w) return 0;
      return -1;
    }  
}
