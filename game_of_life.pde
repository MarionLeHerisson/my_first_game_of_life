int[][] grid;  // Declare the array
int win_w = 800;
int win_h = 800;
int cell_width = 20;
int w = win_w / cell_width;
int h = win_h / cell_width;

void setup() {
  size(800, 800);  // Window size
  grid = new int[w][h];  // Create the array
  init_array();  // initialize array
  apply_conf();
  draw_grid();
}

void draw() {
  set_new_array();
  draw_grid();
  delay(100);
}


/**********************************************************
 *                                                        *
 *     G A M E    O F    L I F E    F U N C T I O N S     *
 *                                                        *
 **********************************************************/

void set_new_array() {
  int[][] new_grid = new int[w][h];
  int neighbors = 0;

  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      neighbors = get_neighbors(i, j);
      switch(neighbors) {
      case 3:
        new_grid[i][j] = 1;
        break;
      case 2: 
        new_grid[i][j] = grid[i][j];
        break;
      default:
        new_grid[i][j] = 0;
      }
      if(i < 5 && j < 5) {
       println("grid[", i, "][", j, "] = ", grid[i][j]," and has ", neighbors, "neighbors.");
      }
    }
  }
  println("-----------------------------");
  grid = new_grid;
}

int get_neighbors(int i, int j) {
  int nb = 0;
  int k_min = i - 1, l_min = j - 1, k_max = i + 2, l_max = j + 2;

  if (k_min < 0) {
    k_min = 0;
  }
  if (l_min < 0) {
    l_min = 0;
  }
  if (k_max > w) {
    k_max = w;
  }
  if (l_max > h) {
    l_max = h;
  }

  for (int k = k_min; k < k_max; k++) {
    for (int l = l_min; l < l_max; l++) {
      if(k != i || l != j) {
        //println("k = ", k, ", l = ", l);
        fill(0, 255, 0);
        if (grid[k][l] == 1) {
          nb ++;
          fill(0, 0, 255);
        }
        rect(k * cell_width, l * cell_width, cell_width, cell_width);
      }
    }
  }

  return nb;
}


/**********************************************************
 *                                                        *
 *   I N I T I A L I S A T I O N     F U N C T I O N S    *
 *                                                        *
 **********************************************************/

void init_array() {
  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      grid[i][j] = 0;
    }
  }
}

void draw_cell(int i, int j) {

  stroke(240, 240, 240);

  if (grid[i][j] == 0) {
    fill(255, 255, 255);
  } else {
    fill(255, 0, 0);
  }

  rect(i * cell_width, j * cell_width, cell_width, cell_width);
}

void draw_grid() {
  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      draw_cell(i, j);
    }
  }
}

void apply_conf() {
  int count = 0;
  int i = 0, j = 0;
  //String conf = get_conf();  // get initial conf in txt file
  String conf = "0 25 1 23 1 25 2 13 2 14 2 21 2 22 2 35 2 36 3 12 3 16 3 21 3 22 3 35 3 36 4 1 4 2 4 11 5 1 5 2 5 11 6 11 4 17 4 21 4 22 5 23 5 15 5 17 5 18 6 17 7 16 7 12 8 13 8 14 5 25 6 25";
  
  // PLANEUR
  // "0 25 1 23 1 25 2 13 2 14 2 21 2 22 2 35 2 36 3 12 3 16 3 21 3 22 3 35 3 36 4 1 4 2 4 11 5 1 5 2 5 11 6 11 4 17 4 21 4 22 5 23 5 15 5 17 5 18 6 17 7 16 7 12 8 13 8 14 5 25 6 25"
  
  while (conf.length() > 0) {  // run through conf stopping at every space
    int space = conf.indexOf(" ");

    if (space == -1) {  // if no space left in conf
      space = conf.length();
    }

    String firstChar = conf.substring(0, space);  // get number

    if (count % 2 == 1) {
      j = int(firstChar);
      grid[j][i] = 1;
    } else {
      i = int(firstChar);
    }

    if (space + 1 < conf.length()) { // end of conf file
      conf = conf.substring(space + 1, conf.length());
    } else {
      break;
    }
    count ++;
  }
}