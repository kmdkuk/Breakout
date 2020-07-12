class Game {
  boolean isStart;

  button next = new button("N E X T", 50, 200, 550, 200, 50);

  Game() {
    isStart = false;

    setstage();
    for (int i = 0; i < 3; i++) {
      ball[i].exist = false;
    }
    ball[0].exist = true;
    ball[0].dx = ball[0].sx;
    ball[0].dy = -ball[0].sy;
    pad_w = 50.0;
    padstatus = 0;
    life = 3;
  }
  MODE draw() {
    background(0);
    drawInfo();
    int count = 0;
    for (int i = 0; i < 3; i++) {
      if (ball[i].exist == true) {
        count += 1;
      }
    }
    if (count == 1) {
      for (int i = 0; i < 3; i++) {
        if (ball[i].exist == true) {
          ball[0].x = ball[i].x;
          ball[0].y = ball[i].y;
          ball[0].sx = ball[i].sx;
          ball[0].sy = ball[i].sy;
          ball[0].speed = ball[i].speed;
          ball[i].exist = false;
          ball[0].exist = true;
        }
      }
    }
    for (int i = 0; i < 3; i++) {
      ball[i].update(isStart);
    }
    for (int i = 0; i < 3; i++) {
      if (l[i].exist == true) {
        l[i].update();
      }
    }
    for (int i = 0; i < globals.block_height; i++) {
      for (int j = 0; j < globals.block_width; j++) {
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
    for (int i = 0; i < globals.block_height; i++) {
      for (int j = 0; j < globals.block_width; j++) {
        clear = clear + block[i][j].life;
      }
    }
    if (clear == 0) //すべてのブロックを壊したとき
    {
      return MODE.CLEAR;
    }
    return MODE.GAME;
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
    text("STAGE:" + s, 0, 40);
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

  /////////////////////////////////////////////////あたり判定
  int checkHitBlock(int i, int j, int k) {
    float left = block[i][j].x;
    float right = block[i][j].x + block[i][j].w;
    float top = block[i][j].y;
    float bottom = block[i][j].y + block[i][j].h;
    float cx = left + block[i][j].w / 2;
    float cy = top + block[i][j].h / 2;
    float y1, y2;

    if ((ball[k].x + ball[k].w / 2 <= left) ||
      (ball[k].x - ball[k].w / 2 >= right) ||
      (ball[k].y + ball[k].h / 2 <= top) ||
      (ball[k].y - ball[k].h / 2 >= bottom)) {
      return 0;
    }

    y1 = ball[k].y - (-(ball[k].x - cx) * block[i][j].h / block[i][j].w + cy);
    y2 = ball[k].y - ((ball[k].x - cx) * block[i][j].h / block[i][j].w + cy);

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
          ball[k].dy = ball[k].sy;
          break;
        case 5:
          isHit(i, j);
        case 4:
        case 6:
          ball[k].dy = -ball[k].sy;
          break;
        }
        switch (ref) {
        case 3:
          isHit(i, j);
        case 2:
        case 4:
          ball[k].dx = ball[k].sx;
          break;
        case 7:
          isHit(i, j);
        case 6:
        case 8:
          ball[k].dx = -ball[k].sx;
          break;
        }
      }
    }
  }

  void isHitToWall() {
    for (int i = 0; i < 3; i++) {
      // check reflection
      if (ball[i].x + ball[i].w >= width) {
        ball[i].dx = -ball[i].sx;
      } else if (ball[i].x < 0) {
        ball[i].dx = ball[i].sx;
      }

      if (ball[i].y + ball[i].w > height) {
        ball[i].speed = 2.0;
        ball[i].exist = false;
        if (ball[0].exist == false && ball[1].exist == false &&
          ball[2].exist == false) //一気に-3
        {
          life--;
          ball[0].exist = true;
          padstatus = 0;
          pad_w = 50.0;
          isStart = false;
        }
        if (life == 0) {
          ball[i].dx = 0;
          ball[i].dy = 0;
          isStart = false;
          // mode = 4; //ゲームオーバー画面へ
        }
      } else if (ball[i].y < 60) //上
      {
        ball[i].dy = ball[i].sy;
      }
    }
  }

  void isHitToRacket() {
    for (int i = 0; i < 3; i++) {
      if (ball[i].x + ball[i].w / 2 >= pad_x &&
        ball[i].x - ball[i].w / 2 <= pad_x + pad_w &&
        ball[i].y + ball[i].h / 2 >= height - 50 &&
        ball[i].y - ball[i].h / 2 <= height - 45) {
        if (ball[i].x + ball[i].w / 2 >= pad_x &&
          ball[i].x + ball[i].w / 2 < pad_x + pad_w / 6) // 1/6
        {
          ball[i].anglex = cos(radians(30));
          ball[i].angley = sin(radians(30));
          ball[i].dx = -ball[i].sx;
        } else if (ball[i].x + ball[i].w / 2 >= pad_x + pad_w / 6 &&
          ball[i].x + ball[i].w / 2 < pad_x + pad_w * 2 / 6) // 2/6
        {
          ball[i].anglex = cos(radians(45));
          ball[i].angley = sin(radians(45));
          ball[i].dx = -ball[i].sx;
        } else if (ball[i].x + ball[i].w / 2 >= pad_x + pad_w * 2 / 6 &&
          ball[i].x < pad_x + pad_w * 3 / 6) // 3/6
        {
          ball[i].anglex = cos(radians(60));
          ball[i].angley = sin(radians(60));
          ball[i].dx = -ball[i].sx;
        } else if (ball[i].x >= pad_x + pad_w * 3 / 6 &&
          ball[i].x - ball[i].w / 2 < pad_x + pad_w * 4 / 6) // 4/6
        {
          ball[i].anglex = cos(radians(60));
          ball[i].angley = sin(radians(60));
          ball[i].dx = ball[i].sx;
        } else if (ball[i].x - ball[i].w / 2 >= pad_x + pad_w * 4 / 6 &&
          ball[i].x - ball[i].w / 2 < pad_x + pad_w * 5 / 6) // 5/6
        {
          ball[i].anglex = cos(radians(45));
          ball[i].angley = sin(radians(45));
          ball[i].dx = ball[i].sx;
        } else if (ball[i].x - ball[i].w / 2 >= pad_x + pad_w * 5 / 6 &&
          ball[i].x - ball[i].w / 2 < pad_x + pad_w) //一番右
        {
          ball[i].anglex = cos(radians(30));
          ball[i].angley = sin(radians(30));
          ball[i].dx = ball[i].sx;
        }
        ball[i].supdate();
        ball[i].dy = -ball[i].sy;
      }
    }
  }

  // hitした時の処理
  void isHit(int i, int j) {
    block[i][j].life--;
    score += 100 * rate;
    for (int k = 0; k < 3; k++) {
      ball[k].speed += 0.05;
    }
    if (!(item.exist)) {
      item.exist = item.generate(i, j);
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  void mouseClicked() {
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


    if (next.isOnMouse()) {
      s++;      //次のステージへ
      //いろいろの初期化
      for (int i = 0; i < 3; i++) {
        ball[i].exist = false;
      }
      ball[0].exist = true;
      ball[0].dx = ball[0].sx;
      ball[0].dy = -ball[0].sy;
      pad_w = 50.0;
      padstatus = 0;
      item.exist = false;
      //ブロックの配置
      setstage();
      isStart = false;
      next.exist = false;
    }
  }
}
