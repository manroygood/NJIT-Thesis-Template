%%%% DOCUMENT HISTORY %%%%%
% Over the years, many NJIT DMS PhD students and faculty have contributed to this document:
% 2001: Adrienne C. N. James, First Edition
% 2001: Jerry Jen-Sou Chen, Contributor, First Edition
% 2001: Eliana Antoniou, revisions
% 2002: Stephen A. Kunec, revisions
% 2003: Hoa Kien Tran, revisions
% 2014: Shoubhik Mondal, revisions
% 2022: Jimmie Adriazola, Prof. Roy Goodman, & Prof. Christina Frederick, revisions
% 2026: Prof. Roy Goodman, with help from Claude: rewrite for the GSO's
%       current rules, master's theses, and a sample that teaches
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This file may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3c of this license or (at
% your option) any later version: https://www.latex-project.org/lppl.txt
% Current Maintainer: Roy Goodman (goodman@njit.edu). See LICENSE.
%
% CONTENTS OF THIS FILE
%    1. Class options and base class
%    2. Packages
%    3. Page layout, spacing, and page numbers
%    4. Lists and bibliography spacing
%    5. Chapter and section headings
%    6. Table of Contents, List of Figures, and List of Tables
%    7. Front matter: data commands
%    8. Front matter: page generators
%    9. List of Symbols and Glossary of Terms
%   10. Main body and appendices
%   11. Footnotes and utility macros
%   12. Compatibility with older versions of this class
%
% Internal macros start with \njit@ so they cannot clash with packages.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{njit_thesis}[2026/10/15 NJIT Dissertation LaTeX class]

% =============================================================
% 1. Class options and base class
% =============================================================
% Document type: "dissertation" (Ph.D., default) or "thesis" (master's)
\newif\ifnjit@thesis
\DeclareOption{thesis}{\njit@thesistrue}
\DeclareOption{dissertation}{\njit@thesisfalse}

% Pass any other options to the underlying report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

% Base report class with 12pt default
\LoadClass[12pt]{report}

% Number headings down to level 5 (X.x.x.x.x); the TOC lists chapters,
% sections (X.x) and subsections (X.x.x) only (GSO heading levels)
\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{2}

% =============================================================
% 2. Packages
% =============================================================
% Standard NJIT Thesis Margins:
% 1.5 in left margin (for binding), 1.0 in right, top, and bottom margins
\RequirePackage[
  letterpaper,
  top=1.0in,
  bottom=1.0in,
  left=1.5in,
  right=1.0in,
  headheight=15pt,
  headsep=0.3in,
  footskip=0.5in
]{geometry}
\RequirePackage{setspace}   % double and single spacing
\RequirePackage{pdflscape}  % landscape pages, rotated in the PDF viewer
\RequirePackage{etoolbox}   % \AtEndPreamble, \ifblank, \AtBeginEnvironment
\RequirePackage{xcolor}     % red titles of unnumbered headings
\RequirePackage{caption}    % caption layout
\RequirePackage{array}      % column types of the symbol and glossary tables
\RequirePackage{longtable}  % symbol and glossary tables that break across pages

% =============================================================
% 3. Page layout, spacing, and page numbers
% =============================================================
\doublespacing

% Paragraph indent: 0.5 in (GSO)
\setlength{\parindent}{0.5in}

% Captions: bold label ("Figure 2.1") followed by two spaces, no colon (GSO)
\DeclareCaptionLabelSeparator{njit}{\ \ }
\captionsetup{
  font={singlespacing,normalsize},
  labelfont=bf,
  labelsep=njit,
  justification=justified,
  singlelinecheck=false
}
\captionsetup[table]{position=above, skip=6pt}
\captionsetup[figure]{position=below, skip=6pt}

% Source of a figure or table that you did not create: \floatsource{...}
% after the \caption of a figure, or after the tabular of a table. It prints
% "Source: ..." in 10 pt below the figure description, and it is not
% copied into the List of Figures or List of Tables (GSO).
\newcommand{\floatsource}[1]{%
  \par\vskip 4\p@
  {\footnotesize\singlespacing\raggedright\parindent\z@ Source: #1\par}}

% No widow or orphan lines. Hyphenation uses the LaTeX defaults;
% \emergencystretch lets TeX loosen a line slightly instead of letting
% it run into the margin.
\widowpenalty=10000
\clubpenalty=10000
\setlength{\emergencystretch}{1.5em}

% A page holding only floats starts them at the top of the page instead of
% centering them vertically (GSO).
\setlength\@fptop{0\p@}
\setlength\@fpsep{20\p@ \@plus 4\p@}
\setlength\@fpbot{0\p@ \@plus 1fil}
% Let a large figure or table share a page with text, at the top or bottom,
% instead of getting a page to itself that interrupts the text around it.
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.7}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.8}

% NJIT plain pagestyle: page numbers centered in footer in bold
\def\ps@plain{%
  \let\@oddhead\@empty
  \let\@evenhead\@empty
  \def\@oddfoot{\normalfont\hfil{\bfseries\thepage}\hfil}%
  \def\@evenfoot{\normalfont\hfil{\bfseries\thepage}\hfil}%
}
\pagestyle{plain}

% =============================================================
% 4. Lists and bibliography spacing
% =============================================================
% Lists and references: single-spaced within an entry, one blank
% (single-spaced) line between entries (GSO). The same gap separates
% entries in the TOC and lists and rows of the symbol and glossary tables.
\newlength{\njit@entrysep}
% One single-spaced line at 12pt (14.5pt)
{\normalsize\singlespacing\global\njit@entrysep\baselineskip}
\def\njit@listspacing{%
  \itemsep\njit@entrysep \parsep\z@ \partopsep\z@}
\def\njit@listi{\leftmargin\leftmargini \njit@listspacing \topsep\njit@entrysep}
\def\njit@listii{\leftmargin\leftmarginii
  \labelwidth\leftmarginii \advance\labelwidth-\labelsep
  \njit@listspacing \topsep\z@}
\def\njit@listiii{\leftmargin\leftmarginiii
  \labelwidth\leftmarginiii \advance\labelwidth-\labelsep
  \njit@listspacing \topsep\z@}
\def\njit@liststyle{%
  \par % end the lead-in paragraph first, so it keeps double spacing
  \singlespacing
  \let\@listi\njit@listi \let\@listI\njit@listi
  \let\@listii\njit@listii \let\@listiii\njit@listiii}
\AtBeginEnvironment{itemize}{\njit@liststyle}
\AtBeginEnvironment{enumerate}{\njit@liststyle}

\AtEndPreamble{%
  \@ifpackageloaded{biblatex}{%
    \AtBeginBibliography{\singlespacing\emergencystretch=2em\relax}%
    \setlength{\bibitemsep}{\njit@entrysep}%
    \setlength{\bibparsep}{\z@}%
    % Unnumbered list for the Biographical Sketch publications
    \defbibenvironment{njitpubs}
      {\list{}{\setlength{\leftmargin}{\bibhang}%
               \setlength{\itemindent}{-\leftmargin}%
               \setlength{\itemsep}{\bibitemsep}%
               \setlength{\parsep}{\bibparsep}}}
      {\endlist}
      {\item}%
  }{}%
}

% =============================================================
% 5. Chapter and section headings
% =============================================================
\renewcommand{\contentsname}{TABLE OF CONTENTS}
\renewcommand{\listfigurename}{LIST OF FIGURES}
\renewcommand{\listtablename}{LIST OF TABLES}
\renewcommand{\chaptername}{CHAPTER}
\renewcommand{\appendixname}{APPENDIX}
\renewcommand{\bibname}{REFERENCES}
\renewcommand{\indexname}{INDEX}

% Every heading must have a title (GSO). An empty or blank title stops the
% build with an error that names the offending heading.
\newcommand{\njit@checktitle}[2]{%
  \ifblank{#2}{%
    \ClassError{njit_thesis}%
      {Untitled \@backslashchar#1 on input line \the\inputlineno}%
      {NJIT does not allow untitled chapters, sections, or subsections.^^J%
       Give this \@backslashchar#1 a title. Press Enter to continue anyway.}%
  }{}%
}

% Chapters start a new page with the plain pagestyle (centered page number)
\def\chapter{\clearpage \thispagestyle{plain} \global\@topnum\z@
  \@afterindentfalse \secdef\@chapter\@schapter}

% Numbered chapters, and lettered appendices after \appendix
\def\@chapter[#1]#2{%
  \njit@checktitle{chapter}{#2}%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \ifnjit@appendix
      \addcontentsline{toc}{appendix}{\protect\numberline{\appendixname~\thechapter}\protect\MakeUppercase{#1}}%
    \else
      \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}\protect\MakeUppercase{#1}}%
    \fi
  \else
    \addcontentsline{toc}{chapter}{\protect\MakeUppercase{#1}}%
  \fi
  \chaptermark{#1}%
  \@makechapterhead{#2}%
  \@afterheading}

% Unnumbered chapters (\chapter*, used for References)
\def\@schapter#1{%
  \njit@checktitle{chapter*}{#1}%
  \@makeschapterhead{#1}%
  \@afterheading}

% Heading layout for numbered chapters (centered, bold, uppercase)
\def\@makechapterhead#1{%
  {\parindent \z@ \normalfont
    \begin{center}\singlespacing
      \ifnum \c@secnumdepth >\m@ne
        \bfseries \@chapapp\space \thechapter\par
        \vskip 8\p@
      \fi
      \bfseries \MakeUppercase{#1}\par
    \end{center}
    \nobreak
    \vskip 30\p@
  }}

% Heading layout for unnumbered chapters
\def\@makeschapterhead#1{%
  {\parindent \z@ \normalfont
    \begin{center}\singlespacing
      \bfseries \MakeUppercase{#1}\par
    \end{center}
    \nobreak
    \vskip 20\p@
  }}

% Headings that run over one line are single-spaced (GSO). The before-skips
% leave four blank single-spaced lines between the preceding text and an
% X.x heading, and three before an X.x.x heading (GSO).
% A negative before-skip also keeps the first paragraph after the heading
% flush left.

% Section headings (level 2, X.x): centered, bold
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-46\p@ \@plus -4\p@ \@minus -2\p@}%
  {2.3ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries\centering\singlespacing}}

% Subsection headings (level 3, X.x.x): flush left, bold
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-32\p@ \@plus -4\p@ \@minus -2\p@}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries\singlespacing}}

% Level 4 (subsubsection, X.x.x.x): bold, sentence case, ends with a period,
% text continues on the same line after a tab (0.5 in, GSO). Not in the TOC.
\newcommand\njit@subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {-0.5in}%
  {\normalfont\normalsize\bfseries}}
% Level 5 (paragraph, X.x.x.x.x): italic, not bold, sentence case, ends with
% a period, text begins on the next line. Not in the TOC.
\newcommand\njit@paragraph{\@startsection{paragraph}{4}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\itshape\singlespacing}}
% The class adds the closing period; do not type one in the title.
\def\njit@periodhead#1#2{\@ifstar{\njit@periodhead@s{#1}{#2}}%
  {\@ifnextchar[{\njit@periodhead@o{#1}{#2}}{\njit@periodhead@n{#1}{#2}}}}
\def\njit@periodhead@s#1#2#3{\njit@checktitle{#2*}{#3}#1*{#3.}}
\def\njit@periodhead@o#1#2[#3]#4{\njit@checktitle{#2}{#4}#1[{#3}]{#4.}}
\def\njit@periodhead@n#1#2#3{\njit@checktitle{#2}{#3}#1[{#3}]{#3.}}
\renewcommand\subsubsection{\njit@periodhead\njit@subsubsection{subsubsection}}
\renewcommand\paragraph{\njit@periodhead\njit@paragraph{paragraph}}

% Check the title of every numbered heading below the chapter level
\let\njit@orig@sect\@sect
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \njit@checktitle{#1}{#8}%
  \njit@orig@sect{#1}{#2}{#3}{#4}{#5}{#6}[{#7}]{#8}}
% Unnumbered headings below the chapter level (\section*, \subsection*,
% \subsubsection*, \paragraph*) are not allowed by the GSO. Their titles are
% printed in red and a warning naming the line goes to the log, so they are
% easy to find and fix. \chapter* (used for front matter and References) is
% not affected.
\let\njit@orig@ssect\@ssect
\def\@ssect#1#2#3#4#5{%
  \njit@checktitle{section*}{#5}%
  \ClassWarning{njit_thesis}{Unnumbered heading `#5'.^^J%
    NJIT does not allow unnumbered sections; its title is printed^^J%
    in red. Remove the * to number it}%
  \njit@orig@ssect{#1}{#2}{#3}{#4}{\njit@red{#5}}}
\def\njit@red{\textcolor{red}}

% =============================================================
% 6. Table of Contents, List of Figures, and List of Tables
% =============================================================
% Column header line ("Chapter ... Page"), typeset when used so that it
% picks up whatever text font the preamble selects.
\newcommand{\njit@colhead}[2]{\hbox to\textwidth{\bfseries #1\hfil #2}}

% Multi-page continuation headers, "(Continued)" in bold (GSO).
% The kernel inserts \@texttop at the top of each page's text after the page
% has already been broken, so a header added there would overflow a full
% page. From the second page on, \textheight shrinks by the header's height
% and the text block moves down by the same amount (via \headsep), so the
% header fills that space and the footer does not move.
\newbox\njit@contbox
\newdimen\njit@contht
\newif\ifnjit@contsqueezed
\newif\ifnjit@contshifted
% #1 = list name, #2 = column header (may be empty)
\newcommand{\njit@begincontinued}[2]{%
  % No center environment or \singlespacing here: both add space above the
  % header, which would push it below the 1 in top margin.
  \global\setbox\njit@contbox\vbox{%
    \hsize\textwidth \linewidth\textwidth \parindent\z@ \normalfont
    \setstretch{1}\bfseries\centering
    \vbox to\topskip{\vfil\hbox to\hsize{\hfil #1\hfil}}%
    \vskip 2pt
    (Continued)\par
    \ifx\relax#2\relax\else \vskip 8pt \noindent #2\par\fi
    \vspace{2ex}}%
  \global\njit@contht\ht\njit@contbox
  \global\let\@texttop\njit@contfirst}
\def\njit@contfirst{% runs while the first page of the list is assembled
  \global\advance\textheight-\njit@contht
  \global\@colroom\textheight % longtable resets \vsize from \@colroom
  \global\njit@contsqueezedtrue
  \global\let\@texttop\njit@contnext}
\def\njit@contnext{% runs on each later page of the list
  \ifnjit@contshifted\else
    \global\advance\headsep\njit@contht
    \global\njit@contshiftedtrue
  \fi
  \vskip-\njit@contht \copy\njit@contbox}
\newcommand{\njit@endcontinued}{%
  \clearpage
  \global\let\@texttop\relax
  \ifnjit@contsqueezed
    \global\advance\textheight\njit@contht
    \global\njit@contsqueezedfalse
  \fi
  \ifnjit@contshifted
    \global\advance\headsep-\njit@contht
    \global\njit@contshiftedfalse
  \fi
  \global\@colht\textheight
  \global\@colroom\textheight
  \global\vsize\textheight}

% [#1] = space after the heading block (default 2ex), #2 = heading,
% #3 = material below the heading, #4 = column header repeated on
% continuation pages (may be empty). Front matter is not listed in the TOC.
\newcommand{\njit@listheading}[4][2ex]{%
  \clearpage
  \thispagestyle{plain}%
  \begin{center}
    \bfseries #2\par
    #3%
  \end{center}
  \par\vspace{#1}%
  \njit@begincontinued{#2}{#4}}

\renewcommand\tableofcontents{%
  \njit@listheading{\contentsname}{\vskip 10pt\njit@colhead{Chapter}{Page}}{\njit@colhead{Chapter}{Page}}%
  {\singlespacing\emergencystretch=2.5em \@starttoc{toc}}%
  \njit@endcontinued
}

\renewcommand\listoffigures{%
  \njit@listheading{\listfigurename}{\vskip 10pt\njit@colhead{Figure}{Page}}{\njit@colhead{Figure}{Page}}%
  {\singlespacing\emergencystretch=2.5em \@starttoc{lof}}%
  \njit@endcontinued
}

\renewcommand\listoftables{%
  \njit@listheading{\listtablename}{\vskip 10pt\njit@colhead{Table}{Page}}{\njit@colhead{Table}{Page}}%
  {\singlespacing\emergencystretch=2.5em \@starttoc{lot}}%
  \njit@endcontinued
}

\renewcommand{\@pnumwidth}{2.5em}
\renewcommand{\@tocrmarg}{3.5em}

% Entries: dot leaders, plain page numbers, one blank line between entries
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ plus .2pt
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax \advance\leftskip \@tempdima
     \advance\leftskip 1em \hbox{}\hskip -\leftskip
     {#4}\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfill \nobreak
     \hbox to\@pnumwidth{\hfil\normalfont #5}\par\vskip\njit@entrysep}%
  \fi}

\def\l@chapter{\@dottedtocline{1}{0pt}{1.8em}}
\def\l@section{\@dottedtocline{1}{1.8em}{2.4em}}
\def\l@subsection{\@dottedtocline{2}{4.2em}{3.2em}}
\def\l@subsubsection{\@dottedtocline{3}{7.4em}{4.2em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\def\l@figure{\@dottedtocline{1}{0pt}{2.8em}}
\let\l@table\l@figure
\def\l@appendix{\@dottedtocline{1}{0pt}{7.5em}}
\def\toclevel@appendix{0}% bookmark level for hyperref

% =============================================================
% 7. Front matter: data commands
% =============================================================
% Used in biography.tex, approval.tex, and main.tex. Each command stores
% its argument; section 8 prints the pages.

% Graduation month and year (May, August, or December), shown on the title
% page, copyright page, and biographical sketch; not the defense date.
\newcommand{\graduationdate}[2]{\gdef\njit@gradmonth{#1}\gdef\njit@gradyear{#2}}
\def\njit@gradmonth{May}
\def\njit@gradyear{2026}

\newcommand{\department}[1]{\def\njit@department{#1}}
\newcommand{\thisdegree}[1]{\def\njit@thisdegree{#1}}
\newcommand{\institute}[1]{\def\njit@institute{#1}}
\newcommand{\major}[1]{\def\njit@major{#1}}
% Degree level printed after "Degree:" in the biographical sketch
\newcommand{\degreelevel}[1]{\def\njit@degreelevel{#1}}
\ifnjit@thesis
  \def\njit@doctype{Thesis}
  \def\njit@degreelevel{Master of Science}
\else
  \def\njit@doctype{Dissertation}
  \def\njit@degreelevel{Doctor of Philosophy}
\fi

% Defaults
\def\njit@department{Department of Mathematical Sciences}
\def\njit@thisdegree{Doctor of Philosophy in Mathematical Sciences}
\def\njit@institute{New Jersey Institute of Technology and \par Rutgers, The State University of New Jersey---Newark}
\def\njit@major{Mathematical Sciences}

% Advisor: \advisor{Name}{Title, Institution}
\def\advisor#1#2{\gdef\njit@advisorname{#1}\gdef\njit@advisortitle{#2}}
\def\njit@advisorname{\@latex@warning@no@line{No advisor given}}
\def\njit@advisortitle{\@latex@warning@no@line{No advisor title given}}

% Optional co-advisor(s): \coadvisor{Name}{Title, Institution}. When one is
% given, the advisor's line also reads "Co-Advisor", and the co-advisors are
% listed right after the advisor, before the committee members.
\newif\ifnjit@coadvisors
\def\njit@coadvisors{}
\newcommand{\coadvisor}[2]{%
  \ifnjit@coadvisors
    \g@addto@macro\njit@coadvisors{,{{#1}{#2}}}%
  \else
    \gdef\njit@coadvisors{{{#1}{#2}}}%
    \global\njit@coadvisorstrue
  \fi
}

% Committee members: \member{Name}{Title, Institution}
\newif\ifnjit@members
\def\njit@committee{}
\newcommand{\member}[2]{%
  \ifnjit@members
    \g@addto@macro\njit@committee{,{{#1}{#2}}}%
  \else
    \gdef\njit@committee{{{#1}{#2}}}%
    \global\njit@memberstrue
  \fi
}

% Degrees for the biographical sketch: \degreeearned{Degree}{University, City, State, Year}
\newif\ifnjit@degrees
\def\njit@degrees{}
\newcommand{\degreeearned}[2]{%
  \ifnjit@degrees
    \g@addto@macro\njit@degrees{,{{#1}{#2}}}%
  \else
    \gdef\njit@degrees{{{#1}{#2}}}%
    \global\njit@degreestrue
  \fi
}

% Abstract: \abstract{...} in main.tex. This replaces the abstract
% environment of the report class; using \begin{abstract} stops the build
% with an explanation instead of silently losing the text.
\long\def\njit@setabstract#1{\gdef\njit@abstract{#1}}
\def\abstract{\@ifnextchar\bgroup\njit@setabstract\njit@abstractenv}
\def\njit@abstractenv{%
  \ClassError{njit_thesis}%
    {Use \string\abstract{...}, not \string\begin{abstract}}%
    {Put your abstract in abstract.tex. main.tex includes it with^^J%
     \string\abstract{\string\input{abstract}}, and \string\initthesis\space prints it.}}
\let\endabstract\relax
\def\njit@abstract{\@latex@warning@no@line{No abstract given}}

% Dedication, acknowledgment, and glossary text (each optional)
\long\def\dedication#1{\gdef\njit@dedication{#1}}
\long\def\acknowledgment#1{\gdef\njit@acknowledgment{#1}}
\long\def\glossaryofterms#1{\gdef\njit@glossaryofterms{#1}}

% =============================================================
% 8. Front matter: page generators
% =============================================================
% Initialize all standard front matter in NJIT prescribed order
\newcommand{\initthesis}{%
  \njit@pdfinfo
  \makeabstract
  \maketitle
  \makecopyright
  \makeapproval
  \makebiography
  \makededication
  \makeacknowledgment
}

% Copy the title and author into the PDF's document properties (used by
% ProQuest, library catalogs, and screen readers) when hyperref is loaded.
% Done here, not in the preamble, because \title and \author are set in
% biography.tex, after \begin{document}.
\newcommand{\njit@pdfinfo}{%
  \ifdefined\hypersetup
    \hypersetup{pdftitle={\@title},pdfauthor={\@author}}%
  \fi}

% 1. Abstract Page
\newcommand{\makeabstract}{%
  \clearpage
  \pagestyle{empty}%
  \pagenumbering{Alph}%
  \begin{center}
    \singlespacing\bfseries
    ABSTRACT\par
    \vskip 15pt
    \MakeUppercase{\@title}\par
    \vskip 15pt
    by \par \@author\par
    \vskip 15pt
  \end{center}
  \par\@afterindentfalse\@afterheading
  \njit@abstract
  \clearpage
  \pagestyle{plain}%
}

% 2. Title Page
\renewcommand{\maketitle}{%
  \clearpage
  \thispagestyle{empty}%
  \pagenumbering{roman}%
  \setcounter{page}{1}%
  \begin{center}
    \singlespacing\bfseries
    \MakeUppercase{\@title}\par
    \vskip 2.5in
    by\par
    \@author\par
    \vfill
    A \njit@doctype\par
    Submitted to the Faculty of\par
    \njit@institute\par
    in Partial Fulfillment of the Requirements for the Degree of\par
    \njit@thisdegree\par
    \vskip 18pt
    \njit@department\par
    \vskip 18pt
    \njit@gradmonth~\njit@gradyear
  \end{center}%
  \clearpage
}

% 3. Copyright Page (dissertations only; a master's thesis has a blank page)
\newcommand{\makecopyright}{%
  \clearpage
  \thispagestyle{empty}%
  \ifnjit@thesis
    \null
  \else
  \begin{center}
    \vspace*{3.0in}
    Copyright \copyright\ \njit@gradyear\ by \@author\par
    ALL RIGHTS RESERVED
  \end{center}%
  \fi
  \clearpage
}

% 4. Approval Page
\newcommand{\makeapproval}{%
  \clearpage
  \thispagestyle{empty}%
  \begin{center}
    \singlespacing\bfseries
    APPROVAL PAGE\par
    \vskip 15pt
    \MakeUppercase{\@title}\par
    \vskip 15pt
    \@author
  \end{center}
  \vskip 0.4in
  {\singlespacing\raggedright\parindent\z@
    \rule{\textwidth}{1.5pt}\par
    \njit@advisorname, \njit@doctype\ \ifnjit@coadvisors Co-\fi Advisor \hfill Date\par
    \njit@advisortitle\par
    \ifnjit@coadvisors
      \@for \njit@mem:=\njit@coadvisors \do{%
        \vfill
        \rule{\textwidth}{1.5pt}\par
        \expandafter\njit@printonecoadvisor\njit@mem
      }%
    \fi
    \ifnjit@members
      \@for \njit@mem:=\njit@committee \do{%
        \vfill
        \rule{\textwidth}{1.5pt}\par
        \expandafter\njit@printonemember\njit@mem
      }%
    \fi
    \vskip 0.8in
  }%
  \clearpage
}
\def\njit@printonecoadvisor#1#2{%
  #1, \njit@doctype\ Co-Advisor \hfill Date\par
  #2\par
}
\def\njit@printonemember#1#2{%
  #1, Committee Member \hfill Date\par
  #2\par
}

% 5. Biographical Sketch
\newcommand{\makebiography}{%
  \clearpage
  \thispagestyle{plain}%
  \begin{center}
    \bfseries BIOGRAPHICAL SKETCH
  \end{center}
  \vspace{10pt}
  \begin{tabbing}
    \hskip 1.5in \= \kill
    \par\noindent {\bfseries Author:} \> \@author \\
    \par\noindent {\bfseries Degree:} \> \njit@degreelevel \\
    \par\noindent {\bfseries Date:} \> \njit@gradmonth~\njit@gradyear \\
  \end{tabbing}
  \par\noindent {\bfseries Undergraduate and Graduate Education:}
  \printdegrees
  \begin{tabbing}
    \hskip 1.5in \= \kill
    \par\noindent {\bfseries Major:} \> \njit@major
  \end{tabbing}
  \printmypublications
  \clearpage
}

\def\printdegrees{%
  \begin{itemize}
    \singlespacing
    \@for \njit@deg:=\njit@degrees \do{%
      \expandafter\njit@printonedegree\njit@deg
    }%
  \end{itemize}%
}
\def\njit@printonedegree#1#2{%
  \item #1\par
  #2
}

% Presentations and publications: entries of references.bib with
% keywords = {me}, newest first (biblatex refsection)
\newcommand{\printmypublications}{%
  \par\bigskip\noindent {\bfseries Presentations and Publications:}\par
  \ifdefined\printbibliography
    \begin{refsection}
      \nocite{*}
      \newrefcontext[sorting=ydnt]% most recent first
      \printbibliography[keyword={me},heading=subbibliography,title={},
                         env=njitpubs]
    \end{refsection}
  \fi
}

% 6. Dedication Page
\newcommand{\makededication}{%
  \ifdefined\njit@dedication
    \clearpage
    \thispagestyle{plain}%
    \begingroup
    \singlespacing
    \begin{center}
      \vspace*{3.0in}
      \begin{minipage}{4.5in}
        \njit@dedication
      \end{minipage}
    \end{center}%
    \clearpage
    \endgroup
  \fi
}

% 7. Acknowledgments Page
\newcommand{\makeacknowledgment}{%
  \ifdefined\njit@acknowledgment
    \clearpage
    \thispagestyle{plain}%
    \begin{center}
      \bfseries ACKNOWLEDGMENTS\par
      \vskip 20\p@
    \end{center}
    \par\@afterindentfalse\@afterheading
    \njit@acknowledgment
    \clearpage
  \fi
}

% =============================================================
% 9. List of Symbols and Glossary of Terms
% =============================================================
% Both are optional and print after the List of Figures. Each prints
% nothing if its text was never given.
\newcommand{\symheadingname}{LIST OF SYMBOLS}
\long\def\symbols#1{\gdef\njit@symbols{#1}}

\newcommand{\makelistofsymbols}{%
  \ifdefined\njit@symbols
    \njit@listheading{\symheadingname}{\vskip 10pt}{}%
    {\singlespacing \njit@symbols}%
    \njit@endcontinued
  \fi
}

\newcommand{\makeglossaryofterms}{%
  \ifdefined\njit@glossaryofterms
    \njit@listheading[0pt]{GLOSSARY OF TERMS}{\vskip 20\p@}{}%
    {\singlespacing \njit@glossaryofterms}%
    \njit@endcontinued
  \fi
}

% Two-column table for the List of Symbols and Glossary of Terms (GSO: "a simple table with two
% columns"). Usage, in listofsymbols.tex:
%   \begin{symboltable}
%   \sym{$E$}{Energy of a physical system}
%   \end{symboltable}
% Rows are single-spaced, with one blank line between rows, and the table
% breaks across pages. Optional argument: width of the symbol column.
\newlength{\njit@symcolwidth}
\newenvironment{symboltable}[1][1.25in]{%
  \setlength{\njit@symcolwidth}{#1}%
  \singlespacing
  \setlength{\LTpre}{\z@}\setlength{\LTpost}{\z@}%
  \def\sym##1##2{##1 & ##2 \\ \noalign{\vskip\njit@entrysep}}%
  \longtable{@{}>{\raggedright\arraybackslash}p{\njit@symcolwidth}
    >{\raggedright\arraybackslash}p{\dimexpr\textwidth-\njit@symcolwidth-2\tabcolsep\relax}@{}}%
}{%
  \endlongtable
}

% Same layout for the Glossary of Terms, with \term{term}{definition} rows
% and a wider first column (default 1.5in).
\newenvironment{glossarytable}[1][1.5in]{%
  \def\term##1##2{\sym{##1}{##2}}%
  \symboltable[#1]%
}{%
  \endsymboltable
}

% =============================================================
% 10. Main body and appendices
% =============================================================
% Arabic page numbering starts at Chapter 1
\newcommand{\startbody}{%
  \clearpage
  \pagestyle{plain}%
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
}

\newif\ifnjit@appendix

% For multiple appendices: \appendix then \chapter{Title}, lettered A, B, ...
\renewcommand\appendix{%
  \par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \njit@appendixtrue
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}%
}

% For a single appendix: \oneappendix{Title}
% NJIT requires that a single appendix has no letter label (not "Appendix A", just "APPENDIX").
\newcommand{\oneappendix}[1]{%
  \par
  \njit@checktitle{oneappendix}{#1}%
  \njit@appendixtrue
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}%
  \clearpage
  \thispagestyle{plain}%
  \setcounter{chapter}{0}%
  \refstepcounter{chapter}% chapter A: resets per-chapter counters, sets \label target
  \chaptermark{#1}%
  \addcontentsline{toc}{chapter}{APPENDIX: \protect\MakeUppercase{#1}}%
  \begin{center}\singlespacing
    \bfseries APPENDIX\par
    \vskip 12pt
    \MakeUppercase{#1}
  \end{center}
  \par\nobreak\vskip 30\p@
  \@afterindentfalse\@afterheading
}

% =============================================================
% 11. Footnotes and utility macros
% =============================================================
\renewcommand\footnoterule{%
  \kern-3\p@
  \vskip 10pt
  \hrule \@width .4\columnwidth
  \kern 2.6\p@}

\renewcommand\@makefntext[1]{%
  \parindent 1em%
  \noindent
  \hb@xt@0.4em{\hss\@makefnmark}#1}

% =============================================================
% 12. Compatibility with older versions of this class
% =============================================================
% Nothing in the current template uses these. They are kept so documents
% written with earlier versions still compile; new documents should not
% need them.

% \bm and \trademark used to be defined here. The sample now loads the bm
% package in packages.tex and defines \trademark in macros.tex; these
% fallbacks apply only if neither is done.
\AtBeginDocument{%
  \providecommand{\bm}[1]{\boldsymbol{#1}}%
  \providecommand{\trademark}{\textsuperscript{\texttrademark}}}

% Spacing shortcuts and caption font
\newcommand{\ssp}{\singlespacing}
\newcommand{\msp}{\onehalfspacing}
\newcommand{\dsp}{\doublespacing}
\newcommand{\normalsizeADIE}{\normalsize}

% \defensedate{Month}{Day}{Year}: replaced by \graduationdate{Month}{Year}
\def\defensedate#1#2#3{\graduationdate{#1}{#3}}

% \degree: old name of \degreeearned. Defined at \begin{document} so it
% does not collide with packages such as gensymb that define \degree (the
% degree sign); in that case use \degreeearned.
\AtBeginDocument{\ifdefined\degree\else\let\degree\degreeearned\fi}

% Old names of the list generators
\let\listofsymbols\makelistofsymbols
\let\makelistofdefinitions\makeglossaryofterms

% Old List of Symbols environment and symbol-definition macros
\newenvironment{symbolslist}{%
  \njit@listheading{\symheadingname}{\vskip 10pt}{}%
  \begin{singlespace}
}{%
  \end{singlespace}
  \njit@endcontinued
}
\ifdefined\opensymdef\else
  \newcommand{\opensymdef}{}
  \newcommand{\closesymdef}{}
  \newcommand{\newsym}[3][]{\expandafter\gdef\csname #2\endcsname{#3}}
\fi

% Index (with makeidx): listed in the TOC, plain page style
\renewenvironment{theindex}{%
  \clearpage
  \if@twocolumn \@restonecolfalse \else \@restonecoltrue \fi
  \columnseprule \z@
  \columnsep 35\p@
  \twocolumn[\@makeschapterhead{\indexname}\vskip 20pt]%
  \addcontentsline{toc}{chapter}{\indexname}%
  \singlespacing
  \thispagestyle{plain}\parindent\z@
  \parskip\z@ \@plus .3\p@\relax
  \let\item\@idxitem
}{%
  \if@restonecol\onecolumn\else\clearpage\fi
}

\endinput
