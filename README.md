# game-life
Implementation of game Life

#Instructions:
This task should be implemented server side only, using Ruby. What we’re looking for in your code is readability and easy maintenance. We want to see code that reveals its intent to the reader and follows best practices. To accomplish this you can use any paradigm you want.

You also have to make sure the code really works and use any tool or technique you need to accomplish this.

#The Problem:
1. You should start with a two-dimensional grid of 30x30 square cells and each of these cells are either alive or dead. You can grid as a 0 showing dead cells and living cells using 1. The initial configuration of living cells in this grid is arbitrary and should be random for every program run. Here’s a smaller 5x5 example:
 
00000<br />
00000<br />
01110<br />
00000<br />
00000<br />
 
2. This grid is subject to changes on what is called a tick. When a grid “ticks”, these are the rules to determine the next state of the grid:
 
Any live cell with fewer than two live neighbours dies (underpopulation).
 
Any live cell with two or three live neighbours lives on to the next generation.
 
Any live cell with more than three live neighbours dies (overcrowding).
 
Any dead cell with exactly three live neighbours becomes a live cell (reproduction).
 
Try to look at the first state of this grid and apply the rules above. The result will be the second grid, as shown below:
 
00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00000<br />
00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00100<br />
01110 - tick -> 00100<br />
00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00100<br />
00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00000<br />
