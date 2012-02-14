/*
* Program to interactively navigate directories.
* By Dave McKenna
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
  char selection[2]; 
  puts("/blah");

  scanf("%2s", selection); 

  //printf("=> %s \n", selection);

  printf(getcwd());

  chdir("/usr");
  
  return 0; 

}
