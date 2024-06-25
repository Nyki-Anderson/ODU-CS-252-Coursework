%option stack
%{

   int saved_state;
   void keyword (char* word);
   int wslen (char* whitespace);
   
%}

/* regular definitions */

delim		[ \t\r]
eol		[\r]?[\n]
return		[\r]
whitespace	{delim}
digit		[0-9]
alpha		[a-zA-Z]
alphanum	[a-zA-Z0-9]


%x COMMENT
%x LINECOMMENT
%x STRING
%x PREPROC
%x PASSTHRU
%x LINEPASSTHRU
%x TEX
%x TEXX
%%
<INITIAL>^{whitespace}*"#"       {wsp(yytext);
                                  printf ("<span class='directive'>#"); 
                                  BEGIN(PREPROC);}
<INITIAL>"&"                     {printf ("&amp;");}
<INITIAL>"\^"                    {printf ("&#94;");}
<INITIAL>"<"                     {printf ("&lt;");}
<INITIAL>">"                     {printf ("&gt;");}
<INITIAL>"\\vdots"               {printf ("<B>.&nbsp;.&nbsp;.</B>");}
<INITIAL>"\\ldots"               {printf ("&#133;");}

<PREPROC>"&"                     {printf ("&amp;");}
<PREPROC>"\^"                    {printf ("&#94;");}
<PREPROC>"<"                     {printf ("&lt;");}
<PREPROC>">"                     {printf ("&gt;");}
<PREPROC>"\\vdots"               {printf ("<B>.&nbsp;.&nbsp;.</B>");}
<PREPROC>"\\ldots"               {printf ("&#133;");}

<COMMENT>"&"                     {printf ("&amp;");}
<COMMENT>"\^"                    {printf ("&#94;");}
<COMMENT>"<"                     {printf ("&lt;");}
<COMMENT>">"                     {printf ("&gt;");}
<COMMENT>"\\vdots"               {printf ("<B>.&nbsp;.&nbsp;.</B>");}
<COMMENT>"\\ldots"               {printf ("&#133;");}

<LINECOMMENT>"&"                     {printf ("&amp;");}
<LINECOMMENT>"\^"                    {printf ("&#94;");}
<LINECOMMENT>"<"                     {printf ("&lt;");}
<LINECOMMENT>">"                     {printf ("&gt;");}
<LINECOMMENT>"\\vdots"               {printf ("<B>.&nbsp;.&nbsp;.</B>");}
<LINECOMMENT>"\\ldots"               {printf ("&#133;");}

<STRING>"&"                     {printf ("&amp;");}
<STRING>"\^"                    {printf ("&#94;");}
<STRING>"<"                     {printf ("&lt;");}
<STRING>">"                     {printf ("&gt;");}
<STRING>"\\vdots"               {printf ("<B>.&nbsp;.&nbsp;.</B>");}
<STRING>"\\ldots"               {printf ("&#133;");}

<PASSTHRU>"\\vdots"               {printf ("<B>.&nbsp;.&nbsp;.</B>");}
<PASSTHRU>"\\ldots"               {printf ("&#133;");}

<LINEPASSTHRU>"\\vdots"               {printf ("<B>.&nbsp;.&nbsp;.</B>");}
<LINEPASSTHRU>"\\ldots"               {printf ("&#133;");}


<INITIAL>"asm"                   {keyword(yytext);}
<INITIAL>"auto"                  {keyword(yytext);}
<INITIAL>"break"                  {keyword(yytext);}
<INITIAL>"case"                  {keyword(yytext);}
<INITIAL>"catch"                  {keyword(yytext);}
<INITIAL>"char"                  {keyword(yytext);}
<INITIAL>"class"                  {keyword(yytext);}
<INITIAL>"const"                  {keyword(yytext);}
<INITIAL>"continue"                  {keyword(yytext);}
<INITIAL>"default"                  {keyword(yytext);}
<INITIAL>"delete"                  {keyword(yytext);}
<INITIAL>"do"                  {keyword(yytext);}
<INITIAL>"double"                  {keyword(yytext);}
<INITIAL>"else"                  {keyword(yytext);}
<INITIAL>"enum"                  {keyword(yytext);}
<INITIAL>"extern"                  {keyword(yytext);}
<INITIAL>"float"                  {keyword(yytext);}
<INITIAL>"for"                  {keyword(yytext);}
<INITIAL>"friend"                  {keyword(yytext);}
<INITIAL>"if"                  {keyword(yytext);}
<INITIAL>"inline"                  {keyword(yytext);}
<INITIAL>"int"                  {keyword(yytext);}
<INITIAL>"long"                  {keyword(yytext);}
<INITIAL>"new"                  {keyword(yytext);}
<INITIAL>"operator"                  {keyword(yytext);}
<INITIAL>"private"                  {keyword(yytext);}
<INITIAL>"public"                  {keyword(yytext);}
<INITIAL>"register"                  {keyword(yytext);}
<INITIAL>"return"                  {keyword(yytext);}
<INITIAL>"short"                  {keyword(yytext);}
<INITIAL>"signed"                  {keyword(yytext);}
<INITIAL>"sizeof"                  {keyword(yytext);}
<INITIAL>"static"                  {keyword(yytext);}
<INITIAL>"struct"                  {keyword(yytext);}
<INITIAL>"switch"                  {keyword(yytext);}
<INITIAL>"template"                  {keyword(yytext);}
<INITIAL>"this"                  {keyword(yytext);}
<INITIAL>"throw"                  {keyword(yytext);}
<INITIAL>"try"                  {keyword(yytext);}
<INITIAL>"typedef"                  {keyword(yytext);}
<INITIAL>"typename"                  {keyword(yytext);}
<INITIAL>"union"                  {keyword(yytext);}
<INITIAL>"unsigned"                  {keyword(yytext);}
<INITIAL>"virtual"                  {keyword(yytext);}
<INITIAL>"void"                  {keyword(yytext);}
<INITIAL>"volatile"                  {keyword(yytext);}
<INITIAL>"while"                  {keyword(yytext);}
<INITIAL>{alphanum}+               {printf ("%s", yytext);}
{whitespace}+                    {wsp(yytext);}
<INITIAL>{eol}                   {printf ("<br>\n");}

<INITIAL>"\""                    {printf ("<span class='quote'>&quot;"); 
                                  BEGIN(STRING);}
<INITIAL>"/\*{"                  {saved_state = INITIAL; BEGIN(PASSTHRU);}
<INITIAL>"//\\"                  {saved_state = INITIAL; BEGIN(LINEPASSTHRU);}
<INITIAL>"/\*"                   {printf ("<span class='comment'>/*"); 
                                  BEGIN(COMMENT);}
<INITIAL>"//"                    {printf ("<span class='comment'>//"); 
                                  BEGIN(LINECOMMENT);}

"/*+*/"                          {printf("<span class='highlighted'>");}
"/*-*/"                          {printf("</span>");}
"`fxh\^"                          {printf("<span class='highlighted'>");}
"@"                          {printf("</span>");}

<COMMENT>{eol}                   {printf ("\\cppeol\n");}
<COMMENT>"\""                    {printf ("&quot;");}
<COMMENT>"/\*{"                  {saved_state = COMMENT; BEGIN(PASSTHRU);}
<COMMENT>"//\\"                  {saved_state = COMMENT; BEGIN(LINEPASSTHRU);}
<COMMENT>"\*/"                   {printf ("</span>");
                                  BEGIN(INITIAL);}

<LINECOMMENT>"/\*{"                  {saved_state = LINECOMMENT; BEGIN(PASSTHRU);}
<LINECOMMENT>"//\\"                  {saved_state = LINECOMMENT; BEGIN(LINEPASSTHRU);}
<LINECOMMENT>"\""                    {printf ("&quot;");}
<LINECOMMENT>{eol}                   {printf ("</span><br>\n");
                                      BEGIN(INITIAL);}

<PREPROC>"/\*{"                  {saved_state = PREPROC; BEGIN(PASSTHRU);}
<PREPROC>"//\\"                  {saved_state = PREPROC; BEGIN(LINEPASSTHRU);}
<PREPROC>"\""                    {printf ("&quot;");}
<PREPROC>{eol}                   {printf ("</span><br>\n");
                                      BEGIN(INITIAL);}

<STRING>{eol}                   {printf ("<br>\n");}
<STRING>"/\*{"                  {saved_state = STRING; BEGIN(PASSTHRU);}
<STRING>"//\\"                  {saved_state = STRING; BEGIN(LINEPASSTHRU);}
<STRING>"\""                   {printf ("&quot;</span>");
                                  BEGIN(INITIAL);}

<PASSTHRU>{eol}                   {printf ("\n");}
<PASSTHRU>"}\*/"                  {BEGIN(saved_state);}

<LINEPASSTHRU>{eol}               {printf ("\\cppeol\n"); BEGIN(saved_state);}

.                                 {printf ("%s", yytext);}
 
%%


#undef yywrap()
int yywrap() {return 1; /* No more files after this one is exhausted.*/}



