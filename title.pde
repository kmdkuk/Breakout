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

  button start = new button("S t a r t", 50, 200, 550, 200, 50);

  void draw() {
    dnow++;
    dtitle[dnow % 6][(dnow / 7) % 32] = true;

    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 32; j++) {
        if (title[i][j] == 1) {
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

  MODE mouseClicked() {
    if (start.isOnMouse()) {
      start.exist = false;
      return MODE.GAME;
    }
    return MODE.TITLE;
  }
}
