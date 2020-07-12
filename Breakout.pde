//1015047  鎌田幸希
int life = 3;

ball ball[] = new ball[3];
block[][] block = new block[int(globals.block_height)][int(globals.block_width)];
int[][] b = new int[12][13];

boolean dtitle[][] = new boolean[6][32];

color[] rainbow = new color[7];

int boundx[] = new int[40];
int boundy[] = new int[40];
int dboundx[] = new int[40];
int dboundy[] = new int[40];

float pad_x;
float pad_w = 75.0;

int dnow;
float titley[][] = new float[6][32];

stage stage = new stage();
int s = 1; //ステージ数1~10

int score = 0;
int rate = 1;

int padstatus = 0; // 0なら普通 1ならレーザー

boolean cflag = false;
float catchx;

item item = new item();
laser l[] = new laser[3];

main m;

void setup() {
  size(600, 700);
  frameRate(120);
  for (int i = 0; i < globals.block_height; i++) {
    for (int j = 0; j < globals.block_width; j++) {
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
  m = new main();
}

void draw() {
  m.draw();
}

//クリック時
//基本モード変更
void mouseClicked() {
  m.mouseClicked();
}

//背景描画処理
void drawback() {
  for (int i = 0; i < width / 20; i++) {
    for (int j = 0; j < height / 20; j++) {
      if (/*mode == 2 && */j < 3) {
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
  for (int i = 0; i < globals.block_height; i++) {
    for (int j = 0; j < globals.block_width; j++) {
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
