# Introduction

Conway's Game of Life, a cellular automaton devised by mathematician John Horton Conway, serves as a model of complexity arising from simple rules. This project aims to implement the Game of Life using MASM (Microsoft Macro Assembler), allowing for a deeper understanding of assembly language programming and the underlying mechanics of cellular automata.

# Project Description

## 0.1. Overview of Conway's Game of Life

The Game of Life consists of a grid of cells that can be alive or dead. Each cell's state in the next generation is determined by the following rules based on its eight neighbors:

- Any live cell with two or three live neighbors survives.
- Any dead cell with exactly three live neighbors becomes a live cell.
- All other live cells die, and all other dead cells remain dead.

## 0.2. Implementation Plan

### Environment Setup
Set up the MASM development environment with appropriate tools for assembly language programming.

### Design the Data Structure
Create a two-dimensional array to represent the grid. The grid's size will be defined at runtime to allow flexibility.

### Implement Game Logic
Write procedures to handle:
- Initialization of the grid with a random or user-defined configuration.
- Calculation of the next generation based on the rules of the game.
- Displaying the current state of the grid.

### Testing and Optimization
Conduct tests to ensure the correctness of the game logic. Optimize performance, focusing on memory usage and execution speed.

# Technical Requirements

- **Programming Language**: MASM (Assembly Language)
- **Development Tools**: MASM assembler, VS Code, GitHub
- **Target Platform**: Windows OS (or compatible environments)
