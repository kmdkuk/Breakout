//1015047  鎌田幸希
int mode = 0;
boolean sflag = false;
int life = 3;

int tate = 12;//ブロック配列の縦の数
int yoko = 13;//               横の数
ball ball[] = new ball[3];
block[][] block = new block[int(tate)][int(yoko)];
int[][] b = new int[12][13];

boolean dtitle[][] = new boolean[6][32];


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


/*int title[][] = {
 {
 0, 0, 0, 1, 0, 1, 0,
 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0,
 0, 0, 1, 0, 0, 0, 0,
 1, 0, 0, 1, 0, 0, 1,
 0, 1, 0, 0, 0, 0, 0
 }//1
 ,
 {
 1, 1, 1, 1, 1, 1, 0,
 1, 1, 1, 1, 1, 1, 0,
 0, 0, 0, 0, 0, 0, 0,
 0, 0, 1, 1, 1, 1, 0,
 1, 1, 1, 1, 1, 1, 1,
 0, 1, 0, 0, 0, 0, 0
 }//2
 ,
 {
 0, 0, 0, 0, 0, 1, 0,
 1, 0, 0, 0, 0, 1, 0,
 0, 0, 0, 0, 0, 0, 0,
 0, 1, 0, 0, 0, 1, 0,
 0, 1, 1, 1, 1, 1, 1,
 0, 1, 0, 0, 0, 0, 0
 }//3
 ,
 {
 0, 0, 0, 0, 0, 1, 0,
 1, 0, 0, 0, 0, 1, 0,
 1, 0, 1, 0, 1, 0, 0,
 1, 0, 0, 0, 0, 1, 0,
 0, 1, 0, 1, 1, 0, 1,
 0, 1, 0, 0, 0, 0, 0
 }//4
 ,
 {
 0, 0, 0, 0, 1, 0, 0,
 1, 0, 0, 0, 0, 1, 0,
 1, 0, 1, 0, 1, 0, 0,
 0, 0, 0, 0, 1, 0, 0,
 0, 1, 1, 1, 1, 1, 1,
 0, 1, 0, 0, 0, 0, 0
 }//5
 ,
 {
 0, 0, 0, 1, 0, 0, 0,
 1, 0, 0, 0, 0, 1, 0,
 0, 0, 0, 1, 0, 0, 0,
 0, 0, 0, 1, 0, 0, 0,
 0, 1, 0, 1, 1, 0, 1,
 0, 1, 0, 0, 0, 1, 0
 }
 ,
 {
 0, 1, 1, 0, 0, 0, 0,
 1, 1, 1, 1, 1, 1, 0,
 0, 1, 1, 0, 0, 0, 0,
 0, 1, 1, 0, 0, 0, 0,
 1, 0, 1, 1, 0, 1, 1,
 0, 0, 1, 1, 1, 0, 0
 }
 };*/

color[] rainbow = new color[7];

int boundx[] = new int[40];
int boundy[] = new int[40];
int dboundx[] = new int[40];
int dboundy[] = new int[40];

float pad_x;
float pad_w = 75.0;

int dnow;
float titley[][] = new float[6][32];

button start = new button("S t a r t", 50, 200, 550, 200, 50);
button totitle = new button("T I T L E", 50, 200, 550, 200, 50);
button next = new button("N E X T", 50, 200, 550, 200, 50);

stage stage = new stage();
int s = 1; //ステージ数1~10

int score = 0;
int rate = 1;

int padstatus = 0; // 0なら普通 1ならレーザー

boolean cflag = false;
float catchx;

item item = new item();
laser l[] = new laser[3];

void setup() {
  size(600, 700);
  frameRate(120);
  for (int i = 0; i < tate; i++) {
    for (int j = 0; j < yoko; j++) {
      block[i][j] = new block(i, j);
      block[i][j].life = 1;
    }
  }
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j < 32; j++) {
      dtitle[i][j] = false;
      titley[i][j] = 0;
    }
  }
  for (int i = 0; i < 40; i++) {
    while (dboundx[i] == 0 || dboundy[i] == 0) {
      boundx[i] = int(random(width - 20));
      boundy[i] = int(random(height - 20));
      dboundx[i] = int(random(-3, 3));
      dboundy[i] = int(random(-3, 3));
    }
  }
  //七色の格納
  rainbow[0] = color(255, 0, 0);
  rainbow[1] = color(255, 182, 1);
  rainbow[2] = color(152, 255, 1);
  rainbow[3] = color(1, 255, 31);
  rainbow[4] = color(1, 255, 213);
  rainbow[5] = color(61, 1, 255);
  rainbow[6] = color(243, 1, 255);

  setstage();
  println(s);

  for (int i = 0; i < 3; i++) {
    l[i] = new laser();
    ball[i] = new ball();
  }
}

void draw() {

  switch (mode) {
  case 0:
    background(0);
    // boundrect();
    drawtitle();
    break;
  case 2:
    game();
    break;
  case 3:
    clear();
    break;
  case 4:
    over();
  }
  /*0:titledraw
   1:titlewait
   2:maingame
   3:クリアー画面
   4:ゲームオーバー画面
   */
}

//クリック時
//基本モード変更
void mouseClicked() {
  if (mode == 2 && !(sflag)) {
    sflag = true;
    return;
  }
  if (mode == 2 && cflag == false) {
    cflag = true;
  }
  if (mode == 2 && padstatus == 1) {
    for (int i = 0; i < 3; i++) {
      if (l[i].exist == false) {
        l[i].exist = true;
        l[i].x = pad_x + pad_w / 3 * 2;
        l[i].y = height - 50;
        break;
      }
    }
  }
  //  switch(mode)
  //  {
  //  case 2:
  //    for (int i = 0; i<tate; i++)
  //    {
  //      for (int j = 0; j<yoko; j++)
  //      {
  //        block[i][j].life = 0;
  //      }
  //    }
  //    break;
  //  }
  if (start.Isonbutton()) {
    mode = 2; //ゲーム画面
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
    start.exist = false;
  }
  if (next.Isonbutton()) {
    mode = 2; //ゲーム画面
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
    sflag = false;
    next.exist = false;
  }
  if (totitle.Isonbutton()) {
    mode = 0; // title画面へ
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
    s = 0; //ステージリセット
    totitle.exist = false;
  }
}

//背景描画処理
void drawback() {
  for (int i = 0; i < width / 20; i++) {
    for (int j = 0; j < height / 20; j++) {
      if (mode == 2 && j < 3) {
        fill(0);
      } else if ((i + j) % 2 == 1) {
        fill(1, 122, 255);
      } else {
        fill(0, 57, 120);
      }

      noStroke();
      rect(20 * i, 20 * j, 20, 20);
      stroke(0);
    }
  }
}

//タイトル生成
void drawtitle() {
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

void drawinfo() {
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

void game() {
  background(0);
  drawinfo();
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
    ball[i].update(sflag);
  }
  for (int i = 0; i < 3; i++) {
    if (l[i].exist == true) {
      l[i].update();
    }
  }
  for (int i = 0; i < tate; i++) {
    for (int j = 0; j < yoko; j++) {
      Ishittoblock(i, j);
      block[i][j].update();
    }
  }
  item.update();
  Ishittowall();
  Ishittoracket();

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
  for (int i = 0; i < tate; i++) {
    for (int j = 0; j < yoko; j++) {
      clear = clear + block[i][j].life;
    }
  }
  if (clear == 0) //すべてのブロックを壊したとき
  {
    mode = 3; //クリアー画面
  }
}

void clear() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(30);
  if (s < 9) {
    text("NextStage!!", width / 2, 100);
    next.update();
  } else {
    text("Conglaturation!!", width / 2, 100);
    totitle.update();
  }
  textAlign(LEFT);
}

void over() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(30);
  text("GameOver!!", width / 2, 100);
  textAlign(LEFT);
  totitle.update();
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

void Ishittoblock(int i, int j) {
  int ref;
  for (int k = 0; k < 3; k++) {
    if (block[i][j].life > 0) {
      ref = checkHitBlock(i, j, k);
      switch (ref) {
      case 1: // if(ref == 1){
        ishit(i, j);
      case 2: // if( ref == 2){   }
      case 8:
        ball[k].dy = ball[k].sy;
        break;
      case 5:
        ishit(i, j);
      case 4:
      case 6:
        ball[k].dy = -ball[k].sy;
        break;
      }
      switch (ref) {
      case 3:
        ishit(i, j);
      case 2:
      case 4:
        ball[k].dx = ball[k].sx;
        break;
      case 7:
        ishit(i, j);
      case 6:
      case 8:
        ball[k].dx = -ball[k].sx;
        break;
      }
    }
  }
}

void Ishittowall() {
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
        sflag = false;
      }
      if (life == 0) {
        ball[i].dx = 0;
        ball[i].dy = 0;
        sflag = false;
        mode = 4; //ゲームオーバー画面へ
      }
    } else if (ball[i].y < 60) //上
    {
      ball[i].dy = ball[i].sy;
    }
  }
}

void Ishittoracket() {
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
void ishit(int i, int j) {
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

void setstage() {
  switch (s) {
  case 1:
    b = stage.stage1;
    break;
  case 2:
    b = stage.stage2;
    break;
  case 3:
    b = stage.stage3;
    break;
  case 4:
    b = stage.stage4;
    break;
  case 5:
    b = stage.stage5;
    break;
  case 6:
    b = stage.stage6;
    break;
  case 7:
    b = stage.stage7;
    break;
  case 8:
    b = stage.stage8;
    break;
  case 9:
    b = stage.stage9;
    break;
  case 10:
    b = stage.stage10;
    break;
  }
  for (int i = 0; i < tate; i++) {
    for (int j = 0; j < yoko; j++) {
      block[i][j].life = 0;
      if (b[i][j] == 1) {
        block[i][j].life = 1;
      }
    }
  }
}

void stop() {
  super.stop();
}

/////class
