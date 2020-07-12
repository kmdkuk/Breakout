//1015047  鎌田幸希
int life = 3;

Ball ball[] = new Ball[3];

Block[][] block = new Block[int(Globals.block_height)][int(Globals.block_width)];
int[][] b = new int[12][13];

float pad_x;
float pad_w = 75.0;

Stage stage = new Stage();

int score = 0;
int rate = 1;

int padstatus = 0; // 0なら普通 1ならレーザー

Item item = new Item();
Laser l[] = new Laser[3];

Main m;

void setup() {
  size(600, 700);
  frameRate(120);

  for (int i = 0; i < 3; i++) {
    l[i] = new Laser();
    ball[i] = new Ball();
  }
  m = new Main();
}

void draw() {
  m.draw();
}

//クリック時
//基本モード変更
void mouseClicked() {
  m.mouseClicked();
}

void stop() {
  super.stop();
}

/////class
