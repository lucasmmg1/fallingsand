float[][] grid;
int resolution = 5;
int cols;
int rows;
float hueValue = 0;

void setup()
{
  size(800, 640);
  colorMode(HSB, 360, 255, 255);
  cols = width / resolution;
  rows = height / resolution;
  grid = make2DArray(cols, rows);
}

void draw()
{  
  noStroke();
  background(0, 0, 0);
  
  for (int i = 0; i < cols; i++)
  { 
    for (int j = 0; j < rows; j++)
    {
      fill(grid[i][j], 255, grid[i][j] == 0 ? 0 : 255);
      square(i * resolution, j * resolution, resolution);
    }
  }
  
  float[][] nextGrid = make2DArray(cols, rows);
  for (int i = 0; i < cols; i++)
  { 
    for (int j = 0; j < rows; j++)
    {
      int current = floor(grid[i][j]);
      if (current > 0)
      {
        if (j + 1 < rows && grid[i][j+1] == 0)
        {
          nextGrid[i][j+1] = grid[i][j];
        }
        else if (i - 1 >= 0 && j + 1 < rows && grid[i-1][j+1] == 0)
        {
          nextGrid[i-1][j+1] = grid[i][j];
        }
        else if (i + 1 < cols && j + 1 < rows && grid[i+1][j+1] == 0)
        {
          nextGrid[i+1][j+1] = grid[i][j];
        }
        else
        {
          nextGrid[i][j] = grid[i][j];
        }
      }
    }
  }
  grid = nextGrid;
}
void mouseDragged()
{
  int col = floor(mouseX / resolution);
  int row = floor(mouseY / resolution);
  
  if ((col < 0 || col >= cols) || (row < 0) || (row >= rows)) return;
  grid[col][row] = hueValue;
  hueValue = hueValue % 360 + 0.1;
}

float[][] make2DArray(int cols, int rows)
{
  float[][] arr = new float[cols][];
  for (int i = 0; i < arr.length; i++)
  {
    arr[i] = new float[rows];
    for (int j = 0; j < arr[i].length; j++)
      arr[i][j] = 0;
  } 
  return arr;
}
