class Title {
  //breakout6*32
  int title[][] = {
    {
      1, 1, 0, 0, 
      0, 0, 0, 0, 
      0, 0, 0, 0, 
      0, 0, 0, 0, 
      1, 0, 0, 0, 
      0, 1, 0, 0, 
      0, 0, 0, 0, 
      0, 0, 0, 0
    }
    , 
    {
      1, 0, 1, 0, 
      0, 0, 0, 0, 
      0, 0, 0, 0, 
      0, 0, 0, 0, 
      1, 0, 0, 0, 
      1, 0, 1, 0, 
      0, 0, 0, 0, 
      0, 1, 0, 0
    }
    , 
    {
      1, 1, 0, 0, 
      1, 0, 1, 0, 
      0, 1, 1, 0, 
      0, 1, 1, 0, 
      1, 0, 1, 0, 
      1, 0, 1, 0, 
      1, 0, 1, 0, 
      1, 1, 1, 0
    }
    , 
    {
      1, 0, 1, 0, 
      1, 1, 0, 0, 
      1, 1, 1, 0, 
      1, 0, 1, 0, 
      1, 1, 0, 0, 
      1, 0, 1, 0, 
      1, 0, 1, 0, 
      0, 1, 0, 0
    }
    , 
    {
      1, 0, 1, 0, 
      1, 0, 0, 0, 
      1, 0, 0, 0, 
      1, 0, 1, 0, 
      1, 0, 1, 0, 
      1, 0, 1, 0, 
      1, 0, 1, 0, 
      0, 1, 0, 0
    }
    , 
    {
      1, 1, 0, 0, 
      1, 0, 0, 0, 
      0, 1, 1, 0, 
      0, 1, 1, 0, 
      1, 0, 1, 0, 
      0, 1, 0, 0, 
      1, 1, 1, 0, 
      0, 1, 1, 0
    }
  };

  color[] rainbow = {
    color(255, 0, 0), 
    color(255, 182, 1), 
    color(152, 255, 1), 
    color(1, 255, 31), 
    color(1, 255, 213), 
    color(61, 1, 255), 
    color(243, 1, 255)
  };


  int dnow;

  int boundx[] = new int[40];
  int boundy[] = new int[40];
  int dboundx[] = new int[40];
  int dboundy[] = new int[40];
  
  
  float titley[][] = new float[6][32];

  boolean dtitle[][] = new boolean[6][32];

  Button start = new Button("S t a r t", 50, 200, 550, 200, 50);

  Title() {
    init();
  }

  void init() {
    dnow = 0; // title描画のための変数初期化
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 32; j++) {
        dtitle[i][j] = false;
        titley[i][j] = 0;
      }
    }
    for (int i = 0; i < 40; i++) {
      while (dboundx[i] == 0 || dboundy[i] == 0) {
        boundx[i] = int(random(380));
        boundy[i] = int(random(280));
        dboundx[i] = int(random(-3, 3));
        dboundy[i] = int(random(-3, 3));
      }
    }
  }

  void update() {
    boundrect();
    dnow++;
    println(dnow);
    dtitle[dnow % 6][(dnow / 7) % 32] = true;

    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 32; j++) {
        if (title[i][j] == 1) {
          //println("dtitle["+i+"]["+j+"] = "+dtitle[i][j]);
          if (dtitle[i][j] == true) {
            if (j < 20) {
              if (titley[i][j] < 20 + 30 * i) //たかさ
              {
                titley[i][j] += 2;
              }
              fill(rainbow[((dnow / 40)) % 7]);
              // fill((dnow/40)%2*255);
              noStroke();
              rect(20 + 22 * j /*はば*/, titley[i][j], 22, 30);
              stroke(0);
            } else {
              if (titley[i][j] < 220 + 30 * i) //たかさ
              {
                titley[i][j] += 2;
              }
              // fill((dnow/40)%2*255);
              fill(rainbow[((dnow / 40)) % 7]);
              noStroke();
              rect(22 * j - 100 /*はば*/, titley[i][j], 22, 30);
              stroke(0);
            }
          }
        }
      }
    }
    start.update();
  }

  //スタート画面跳ねる四角
  void boundrect() {
    for (int i = 0; i < 40; i++) {
      boundx[i] += dboundx[i];
      boundy[i] += dboundy[i];
      if (boundx[i] > width - 20 || boundx[i] <= 0) {
        dboundx[i] = dboundx[i] * -1;
      }
      if (boundy[i] > height - 20 || boundy[i] <= 0) {
        dboundy[i] = dboundy[i] * -1;
      }
      fill(255, 255, 255, 0);
      rect(boundx[i], boundy[i], 20, 20);
    }
  }

  Mode clicked() {
    if (start.isOnMouse()) {
      start.exist = false;
      return Mode.GAME;
    }
    return Mode.TITLE;
  }
}
