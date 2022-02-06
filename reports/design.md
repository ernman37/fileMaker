# File Maker
This bash program is going to be able to make a handful of basic files for different programing languages
**Available Languages:**
- C
   - Including Header files (.c & .h)
- C++
   - Including header files (.c & .h)
- Python 
- Bash
- Java
- Makefile

# Usage
`./PROGRAM -OPTION FILE_NAME`

OPTIONS:
- c (c file)
- C (c++ file)
- h (header file, only for C and CPP)
- j (java file)
- b (bash file)
- p (python file)
- m (Makefile) 

# Process
**On-Entry**
1. Checks if file(s) already exist
   - Exits if already exists
2. Validate options input
   - exits if invalid
3. Creates **Header** for specific type file
   - Name, Date, For, Description
4. Copies/Creates base file for program
   - Copies stored in copy folder
5. Adds **Footer** if necessary
6. Exits

# Header
- Includes *Creator, Date, For, Description* 
Creator:
- By Who
Date: 
- MM/DD/YYYY HH:MM:SS
For: 
- What is its use for
Description: 
- Simple description of processes

## Header Design
`$` = Comment starter for various languages

$$$ \
$ Creator: USER NAME \
$ Date: MM/DD/YY HH:MM:SS \
$ For: \
$ Description: \
$$$ 
