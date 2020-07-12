package src;

class Globals {
  static final int block_height = 12; // ブロック配列の縦の数
  static final int block_width = 13; // 横の数
  static int life = 3;

  static Ball ball[] = new Ball[3];

  static Block[][] block = new Block[Globals.block_height][Globals.block_width];
  static int[][] b = new int[12][13];

  static float pad_x;
  static float pad_w = (float) 75.0;

  static Stage stage = new Stage();

  static int score = 0;
  static int rate = 1;

  static int padstatus = 0; // 0なら普通 1ならレーザー

  static Item item;
  static Laser l[] = new Laser[3];
}
