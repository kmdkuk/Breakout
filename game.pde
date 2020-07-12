class Game {
  boolean isStart;

  int stage = 1; //ステージ数1~10

  boolean cflag = false;

  Button next = new Button("N E X T", 50, 200, 550, 200, 50);

  Game() {
    for (int i = 0; i < Globals.block_height; i++) {
      for (int j = 0; j < Globals.block_width; j++) {
        block[i][j] = new Block(i, j);
        block[i][j].life = 1;
      }
    }
    init();
  }

  void init() {
    isStart = false;
    stage = 1;
    setstage();
    for (int i = 0; i < 3; i++) {
      Globals.ball[i].exist = false;
    }
    Globals.ball[0].exist = true;
    Globals.ball[0].dx = Globals.ball[0].sx;
    Globals.ball[0].dy = -Globals.ball[0].sy;
    pad_w = 50.0;
    padstatus = 0;
    life = 3;
  }

  void nextInit() {
    stage++;      //次のステージへ
    //いろいろの初期化
    for (int i = 0; i < 3; i++) {
      Globals.ball[i].exist = false;
    }
    Globals.ball[0].exist = true;
    Globals.ball[0].dx = Globals.ball[0].sx;
    Globals.ball[0].dy = -Globals.ball[0].sy;
    pad_w = 50.0;
    padstatus = 0;
    item.exist = false;
    //ブロックの配置
    setstage();
    isStart = false;
  }

  Mode update() {
    background(0);
    drawInfo();
    int count = 0;
    for (int i = 0; i < 3; i++) {
      if (Globals.ball[i].exist == true) {
        count += 1;
      }
    }
    if (count == 1) {
      for (int i = 0; i < 3; i++) {
        if (Globals.ball[i].exist == true) {
          Globals.ball[0].x = Globals.ball[i].x;
          Globals.ball[0].y = Globals.ball[i].y;
          Globals.ball[0].sx = Globals.ball[i].sx;
          Globals.ball[0].sy = Globals.ball[i].sy;
          Globals.ball[0].speed = Globals.ball[i].speed;
          Globals.ball[i].exist = false;
          Globals.ball[0].exist = true;
        }
      }
    }
    for (int i = 0; i < 3; i++) {
      Globals.ball[i].update(isStart);
    }
    for (int i = 0; i < 3; i++) {
      if (l[i].exist == true) {
        l[i].update();
      }
    }
    for (int i = 0; i < Globals.block_height; i++) {
      for (int j = 0; j < Globals.block_width; j++) {
        isHitToBlock(i, j);
        block[i][j].update();
      }
    }
    item.update();
    isHitToWall();
    isHitToRacket();

    if (mouseX - pad_w / 2 < 0) {
      pad_x = 0;
    } else if (mouseX + pad_w / 2 > width) {
      pad_x = width - pad_w;
    } else {
      pad_x = mouseX - pad_w / 2;
    }
    drawpad();
    for (int i = 0; i < life; i++) {
      fill(255);
      textSize(40);
      text("*", i * 20, height);
    }

    int clear = 0;
    for (int i = 0; i < Globals.block_height; i++) {
      for (int j = 0; j < Globals.block_width; j++) {
        clear = clear + block[i][j].life;
      }
    }
    if (clear == 0) //すべてのブロックを壊したとき
    {
      if (stage < Stage.finalStage)
      {
        return Mode.NEXT_STAGE;
      }
      return Mode.CLEAR;
    }

    if (life == 0) {
      // Globals.ball[i].dx = 0;
      // Globals.ball[i].dy = 0;
      isStart = false;
      // Mode = 4; //ゲームオーバー画面へ
      return Mode.OVER;
    }
    return Mode.GAME;
  }

  void drawInfo() {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(20);
    text("S C O R E", width * 1 / 3, 30);
    text(score, width * 1 / 3, 50);
    text("item", width * 2 / 3, 30);
    textAlign(LEFT);
    fill(255);
    text("STAGE:" + stage, 0, 40);
    rect(0, 54, width, 6);
  }

  void drawpad() {
    if (padstatus == 0) {
      fill(2, 0, 255);
      rect(pad_x, height - 50, pad_w, 5);
    } else if (padstatus == 1) {
      fill(255, 0, 0);
      rect(pad_x, height - 50, pad_w, 5);
    }
  }

  void setstage() {
    switch (stage) {
    case 1:
      b = Stage.stage1;
      break;
    case 2:
      b = Stage.stage2;
      break;
    case 3:
      b = Stage.stage3;
      break;
    case 4:
      b = Stage.stage4;
      break;
    case 5:
      b = Stage.stage5;
      break;
    case 6:
      b = Stage.stage6;
      break;
    case 7:
      b = Stage.stage7;
      break;
    case 8:
      b = Stage.stage8;
      break;
    case 9:
      b = Stage.stage9;
      break;
    case 10:
      b = Stage.stage10;
      break;
    }
    for (int i = 0; i < Globals.block_height; i++) {
      for (int j = 0; j < Globals.block_width; j++) {
        block[i][j].life = 0;
        if (b[i][j] == 1) {
          block[i][j].life = 1;
        }
      }
    }
  }

  /////////////////////////////////////////////////あたり判定
  int checkHitBlock(int i, int j, int k) {
    float left = block[i][j].x;
    float right = block[i][j].x + block[i][j].w;
    float top = block[i][j].y;
    float bottom = block[i][j].y + block[i][j].h;
    float cx = left + block[i][j].w / 2;
    float cy = top + block[i][j].h / 2;
    float y1, y2;

    if ((Globals.ball[k].x + Globals.ball[k].w / 2 <= left) ||
      (Globals.ball[k].x - Globals.ball[k].w / 2 >= right) ||
      (Globals.ball[k].y + Globals.ball[k].h / 2 <= top) ||
      (Globals.ball[k].y - Globals.ball[k].h / 2 >= bottom)) {
      return 0;
    }

    y1 = Globals.ball[k].y - (-(Globals.ball[k].x - cx) * block[i][j].h / block[i][j].w + cy);
    y2 = Globals.ball[k].y - ((Globals.ball[k].x - cx) * block[i][j].h / block[i][j].w + cy);

    if (y1 > 0) {
      if (y2 > 0) {
        return 1; // y1>0 y2>0
      } else if (y2 == 0)

      {
        return 2; // y1>0 y2=0
      } else {
        return 3; // y1>0 y2<0
      }
    } else if (y1 < 0) {
      if (y2 > 0) {
        return 7; // y1<0 y2>0
      } else if (y2 == 0) {
        return 6; // y1<0 y2=0
      } else {
        return 5; // y1<0 y2<0
      }
    } else {
      if (y2 > 0) {
        return 8; // y1=0 y2>0
      } else if (y2 == 0) {
        return -1; // y1=0 y2=0
      } else {
        return 4; // y1=0 y2=0
      }
    }
  }

  void isHitToBlock(int i, int j) {
    int ref;
    for (int k = 0; k < 3; k++) {
      if (block[i][j].life > 0) {
        ref = checkHitBlock(i, j, k);
        switch (ref) {
        case 1: // if(ref == 1){
          isHit(i, j);
        case 2: // if( ref == 2){   }
        case 8:
          Globals.ball[k].dy = Globals.ball[k].sy;
          break;
        case 5:
          isHit(i, j);
        case 4:
        case 6:
          Globals.ball[k].dy = -Globals.ball[k].sy;
          break;
        }
        switch (ref) {
        case 3:
          isHit(i, j);
        case 2:
        case 4:
          Globals.ball[k].dx = Globals.ball[k].sx;
          break;
        case 7:
          isHit(i, j);
        case 6:
        case 8:
          Globals.ball[k].dx = -Globals.ball[k].sx;
          break;
        }
      }
    }
  }

  void isHitToWall() {
    for (int i = 0; i < 3; i++) {
      // check reflection
      if (Globals.ball[i].x + Globals.ball[i].w >= width) {
        Globals.ball[i].dx = -Globals.ball[i].sx;
      } else if (Globals.ball[i].x < 0) {
        Globals.ball[i].dx = Globals.ball[i].sx;
      }

      if (Globals.ball[i].y + Globals.ball[i].w > height) {
        Globals.ball[i].speed = 2.0;
        Globals.ball[i].exist = false;
        if (Globals.ball[0].exist == false && Globals.ball[1].exist == false &&
          Globals.ball[2].exist == false) //一気に-3
        {
          life--;
          Globals.ball[0].exist = true;
          padstatus = 0;
          pad_w = 50.0;
          isStart = false;
        }
      } else if (Globals.ball[i].y < 60) //上
      {
        Globals.ball[i].dy = Globals.ball[i].sy;
      }
    }
  }

  void isHitToRacket() {
    for (int i = 0; i < 3; i++) {
      if (Globals.ball[i].x + Globals.ball[i].w / 2 >= pad_x &&
        Globals.ball[i].x - Globals.ball[i].w / 2 <= pad_x + pad_w &&
        Globals.ball[i].y + Globals.ball[i].h / 2 >= height - 50 &&
        Globals.ball[i].y - Globals.ball[i].h / 2 <= height - 45) {
        if (Globals.ball[i].x + Globals.ball[i].w / 2 >= pad_x &&
          Globals.ball[i].x + Globals.ball[i].w / 2 < pad_x + pad_w / 6) // 1/6
        {
          Globals.ball[i].anglex = cos(radians(30));
          Globals.ball[i].angley = sin(radians(30));
          Globals.ball[i].dx = -Globals.ball[i].sx;
        } else if (Globals.ball[i].x + Globals.ball[i].w / 2 >= pad_x + pad_w / 6 &&
          Globals.ball[i].x + Globals.ball[i].w / 2 < pad_x + pad_w * 2 / 6) // 2/6
        {
          Globals.ball[i].anglex = cos(radians(45));
          Globals.ball[i].angley = sin(radians(45));
          Globals.ball[i].dx = -Globals.ball[i].sx;
        } else if (Globals.ball[i].x + Globals.ball[i].w / 2 >= pad_x + pad_w * 2 / 6 &&
          Globals.ball[i].x < pad_x + pad_w * 3 / 6) // 3/6
        {
          Globals.ball[i].anglex = cos(radians(60));
          Globals.ball[i].angley = sin(radians(60));
          Globals.ball[i].dx = -Globals.ball[i].sx;
        } else if (Globals.ball[i].x >= pad_x + pad_w * 3 / 6 &&
          Globals.ball[i].x - Globals.ball[i].w / 2 < pad_x + pad_w * 4 / 6) // 4/6
        {
          Globals.ball[i].anglex = cos(radians(60));
          Globals.ball[i].angley = sin(radians(60));
          Globals.ball[i].dx = Globals.ball[i].sx;
        } else if (Globals.ball[i].x - Globals.ball[i].w / 2 >= pad_x + pad_w * 4 / 6 &&
          Globals.ball[i].x - Globals.ball[i].w / 2 < pad_x + pad_w * 5 / 6) // 5/6
        {
          Globals.ball[i].anglex = cos(radians(45));
          Globals.ball[i].angley = sin(radians(45));
          Globals.ball[i].dx = Globals.ball[i].sx;
        } else if (Globals.ball[i].x - Globals.ball[i].w / 2 >= pad_x + pad_w * 5 / 6 &&
          Globals.ball[i].x - Globals.ball[i].w / 2 < pad_x + pad_w) //一番右
        {
          Globals.ball[i].anglex = cos(radians(30));
          Globals.ball[i].angley = sin(radians(30));
          Globals.ball[i].dx = Globals.ball[i].sx;
        }
        Globals.ball[i].supdate();
        Globals.ball[i].dy = -Globals.ball[i].sy;
      }
    }
  }

  // hitした時の処理
  void isHit(int i, int j) {
    block[i][j].life--;
    score += 100 * rate;
    for (int k = 0; k < 3; k++) {
      Globals.ball[k].speed += 0.05;
    }
    if (!(item.exist)) {
      item.exist = item.generate(i, j);
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  void clicked() {
    if (!(isStart)) {
      isStart = true;
      return;
    }
    if (cflag == false) {
      cflag = true;
    }
    if (padstatus == 1) {
      for (int i = 0; i < 3; i++) {
        if (l[i].exist == false) {
          l[i].exist = true;
          l[i].x = pad_x + pad_w / 3 * 2;
          l[i].y = height - 50;
          break;
        }
      }
    }
  }
}
