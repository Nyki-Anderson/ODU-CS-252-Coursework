#include <stdio.h>
#include <string.h>


void yylex();


void keyword (char* word)
{
  printf ("<span class='keyword'>%s</span>", word);
}

int wslen (char* whitespace)
{
  int width = 0;
  int len = strlen(whitespace);
  int i;
  for (i = 0; i < len; ++i)
    {
      char c = whitespace[i];
      if (c == '\t')
	width = width / 8 + 8;
      else
	++width;
    }
  return width;
}


int wsp (char* whitespace)
{
  int w = wslen(whitespace);
  if (w > 1)
    {
      int i;
      for (i = 0; i < w; ++i)
	printf("&nbsp;");
    }
  else
    printf (" ");
}


int main(int argc, char** argv)
{
  printf ("<html><head>\n");
  printf ("<link REL='stylesheet' href='cppcode.css' type='text/css'>\n");
  printf ("</head><body>\n");
  printf ("<div class='cppcode'><nobr>\n");
  yylex();
  printf ("</nobr></div></body></html>\n");
  return 0;
}

