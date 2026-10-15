%%%% DOCUMENT HISTORY %%%%%
% Over the years, many NJIT DMS PhD students and faculty have contributed to this document:
% 2001: Adrienne C. N. James, First Edition
% 2001: Jerry Jen-Sou Chen, Contributor, First Edition
% 2001: Eliana Antoniou, revisions
% 2002: Stephen A. Kunec, revisions
% 2003: Hoa Kien Tran, revisions
% 2014: Shoubhik Mondal, revisions
% 2022: Jimmie Adriazola, Prof. Roy Goodman, & Prof. Christina Frederick, revisions
% 2026: Comprehensive overhaul for modern LaTeX compatibility, clean geometry,
%       robust appendix handling, safe continuation headers, and full feature demonstration.
%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{njit_thesis}[2026/10/03 NJIT Dissertation LaTeX class]

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

% -------------------------------------------------------------
% Core Required Packages
% -------------------------------------------------------------
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

% Spacing package for standard double/single spacing
\RequirePackage{setspace}
\doublespacing

% Landscape support (pdflscape rotates PDF view for easy reading on screen)
\RequirePackage{pdflscape}

% Hooks used below (\AtEndPreamble, \ifblank, \AtBeginEnvironment)
\RequirePackage{etoolbox}
\RequirePackage{xcolor}

% Caption formatting conforming to NJIT guidelines
\RequirePackage{caption}
% GSO: bold label ("Figure 2.1") followed by two spaces, no colon
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

% Line spacing aliases for backward compatibility
\newcommand{\ssp}{\singlespacing}
\newcommand{\msp}{\onehalfspacing}
\newcommand{\dsp}{\doublespacing}

% Caption font macro for backward compatibility
\newcommand{\normalsizeADIE}{\normalsize}

% -------------------------------------------------------------
% Hyphenation and Widow / Orphan Control
% -------------------------------------------------------------
\widowpenalty=10000
\clubpenalty=10000
\hyphenpenalty=1000
\tolerance=1000
\exhyphenpenalty=1000
\uchyph=0
\lefthyphenmin=5
\righthyphenmin=6

% A page holding only floats starts them at the top of the page instead of
% centering them vertically (GSO).
\setlength\@fptop{0\p@}
\setlength\@fpsep{20\p@ \@plus 4\p@}
\setlength\@fpbot{0\p@ \@plus 1fil}

\setlength\belowdisplayskip{20pt}
\setlength\belowdisplayshortskip{20pt}
\setlength\abovecaptionskip{5pt}

% -------------------------------------------------------------
% Page Numbering & Plain Style
% -------------------------------------------------------------
% NJIT plain pagestyle: page numbers centered in footer in bold
\def\ps@plain{%
  \let\@oddhead\@empty
  \let\@evenhead\@empty
  \def\@oddfoot{\normalfont\hfil{\bfseries\thepage}\hfil}%
  \def\@evenfoot{\normalfont\hfil{\bfseries\thepage}\hfil}%
}
\pagestyle{plain}


% -------------------------------------------------------------
% Section & Chapter Headings
% -------------------------------------------------------------
\renewcommand{\contentsname}{TABLE OF CONTENTS}
\renewcommand{\listfigurename}{LIST OF FIGURES}
\renewcommand{\listtablename}{LIST OF TABLES}
\renewcommand{\chaptername}{CHAPTER}
\renewcommand{\appendixname}{APPENDIX}
\renewcommand{\bibname}{REFERENCES}
\renewcommand{\indexname}{INDEX}

% Chapter pages: plain pagestyle with centered footer page number
\def\chapter{\clearpage \thispagestyle{plain} \global\@topnum\z@
  \@afterindentfalse \secdef\@chapter\@schapter}

\def\@schapter#1{%
  \njit@checktitle{chapter*}{#1}%
  \if@twocolumn
    \@topnewpage[\@makeschapterhead{#1}]%
  \else
    \@makeschapterhead{#1}%
    \@afterheading
  \fi}

% Numbered chapters
\def\@chapter[#1]#2{%
  \njit@checktitle{chapter}{#2}%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \if@appendix
      \addcontentsline{toc}{appendix}{\protect\numberline{\appendixname~\thechapter}\protect\MakeUppercase{#1}}%
    \else
      \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}\protect\MakeUppercase{#1}}%
    \fi
  \else
    \addcontentsline{toc}{chapter}{\protect\MakeUppercase{#1}}%
  \fi
  \chaptermark{#1}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheading
  \fi}

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
% put an X.x heading on the 4th single-spaced line below the preceding text
% and an X.x.x heading on the 3rd (GSO "Avoiding Format Problems").
% A negative before-skip also keeps the first paragraph after the heading
% flush left.

% Section headings: Centered, Bold
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-34\p@ \@plus -4\p@ \@minus -2\p@}%
  {2.3ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries\centering\singlespacing}}

% Subsection headings: Flush left, Bold
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-20\p@ \@plus -4\p@ \@minus -2\p@}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries\singlespacing}}

% Level 4 (subsubsection, X.x.x.x): bold, sentence case, ends with a period,
% text continues on the same line. Not in the TOC.
\newcommand\njit@subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {-1em}%
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

% -------------------------------------------------------------
% Table of Contents, List of Figures, and List of Tables
% -------------------------------------------------------------
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
  \global\setbox\njit@contbox\vbox{%
    \hsize\textwidth \linewidth\textwidth \parindent\z@ \normalfont
    \begin{center}
      \singlespacing\bfseries
      #1\par
      \vskip 2pt
      (Continued)\par
      \ifx\relax#2\relax\else \vskip 8pt #2\fi
    \end{center}
    \par\vspace{2ex}}%
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

% Dotted TOC leader formatting
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

% -------------------------------------------------------------
% Appendix Implementation (Single Appendix & Multiple Appendices)
% -------------------------------------------------------------
\newif\if@appendix
\@appendixfalse

% For multiple appendices: \appendix then \chapter{Title}
\renewcommand\appendix{%
  \par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \@appendixtrue
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}%
}

% For a single appendix: \oneappendix{Title}
% NJIT requires that a single appendix has no letter label (not "Appendix A", just "APPENDIX").
\newcommand{\oneappendix}[1]{%
  \par
  \njit@checktitle{oneappendix}{#1}%
  \@appendixtrue
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

% -------------------------------------------------------------
% Front Matter Definitions & Metadata
% -------------------------------------------------------------
\def\defensedate#1#2#3{%
  \gdef\defensemonth{#1}%
  \gdef\defenseday{#2}%
  \gdef\defenseyear{#3}%
}
% The title page, copyright page and biographical sketch show the month and
% year of GRADUATION (May, August or December), not the defense date.
\newcommand{\graduationdate}[2]{\gdef\defensemonth{#1}\gdef\defenseyear{#2}}
\def\defensemonth{May}
\def\defenseday{1}
\def\defenseyear{2026}

\newcommand{\department}[1]{\def\@department{#1}}
\newcommand{\thisdegree}[1]{\def\@thisdegree{#1}}
\newcommand{\institute}[1]{\def\@institute{#1}}
\newcommand{\major}[1]{\def\@major{#1}}
% Degree level printed after "Degree:" in the biographical sketch
\newcommand{\degreelevel}[1]{\def\@degreelevel{#1}}
\ifnjit@thesis
  \def\njit@doctype{Thesis}
  \def\@degreelevel{Master of Science}
\else
  \def\njit@doctype{Dissertation}
  \def\@degreelevel{Doctor of Philosophy}
\fi

% Defaults
\def\@department{Department of Mathematical Sciences}
\def\@thisdegree{Doctor of Philosophy in Mathematical Sciences}
\def\@institute{New Jersey Institute of Technology and \par Rutgers, The State University of New Jersey---Newark}
\def\@major{Mathematical Sciences}

\def\advisor#1#2{\gdef\@advisorname{#1}\gdef\@advisortitle{#2}}
\def\@advisorname{\@latex@warning@no@line{No advisor given}}
\def\@advisortitle{\@latex@warning@no@line{No advisor title given}}

% Optional co-advisor(s): \coadvisor{Name}{Title, Institution}. When one is
% given, the advisor's line also reads "Co-Advisor", and the co-advisors are
% listed right after the advisor, before the committee members.
\newif\if@coadvisors
\@coadvisorsfalse
\def\@coadvisors{}
\newcommand{\coadvisor}[2]{%
  \if@coadvisors
    \g@addto@macro\@coadvisors{,{{#1}{#2}}}%
  \else
    \gdef\@coadvisors{{{#1}{#2}}}%
    \@coadvisorstrue
  \fi
}

% Committee member accumulation
\newif\if@members
\@membersfalse
\def\@committee{}

\newcommand{\member}[2]{%
  \if@members
    \g@addto@macro\@committee{,{{#1}{#2}}}%
  \else
    \gdef\@committee{{{#1}{#2}}}%
    \@memberstrue
  \fi
}

% Degrees accumulation for Biographical Sketch
\newif\if@degrees
\@degreesfalse
\def\@degrees{}

\newcommand{\degreeearned}[2]{%
  \if@degrees
    \g@addto@macro\@degrees{,{{#1}{#2}}}%
  \else
    \gdef\@degrees{{{#1}{#2}}}%
    \@degreestrue
  \fi
}
% Old name, kept for existing documents. Defined at \begin{document} so it
% does not collide with packages such as gensymb that define \degree (the
% degree sign); in that case use \degreeearned.
\AtBeginDocument{\ifdefined\degree\else\let\degree\degreeearned\fi}

\def\printdegrees{%
  \begin{itemize}
    \singlespacing
    \@for \@deg:=\@degrees \do{%
      \expandafter\@printonedegree\@deg
    }%
  \end{itemize}%
}
\def\@printonedegree#1#2{%
  \item #1\par
  #2
}

% Abstract
\long\def\abstract#1{\gdef\@abstract{#1}}
\def\@abstract{\@latex@warning@no@line{No abstract given}}

% Dedication
\long\def\dedication#1{\gdef\@dedication{#1}}

% Acknowledgment
\long\def\acknowledgment#1{\gdef\@acknowledgment{#1}}

% Glossary / List of Definitions
\long\def\glossaryofterms#1{\gdef\@glossaryofterms{#1}}

% -------------------------------------------------------------
% Front Matter Page Generators
% -------------------------------------------------------------

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
  \@abstract
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
    \@institute\par
    in Partial Fulfillment of the Requirements for the Degree of\par
    \@thisdegree\par
    \vskip 18pt
    \@department\par
    \vskip 18pt
    \defensemonth~\defenseyear
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
    Copyright \copyright\ \defenseyear\ by \@author\par
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
    \@advisorname, \njit@doctype\ \if@coadvisors Co-\fi Advisor \hfill Date\par
    \@advisortitle\par
    \if@coadvisors
      \@for \@mem:=\@coadvisors \do{%
        \vfill
        \rule{\textwidth}{1.5pt}\par
        \expandafter\@printonecoadvisor\@mem
      }%
    \fi
    \if@members
      \@for \@mem:=\@committee \do{%
        \vfill
        \rule{\textwidth}{1.5pt}\par
        \expandafter\@printonemember\@mem
      }%
    \fi
    \vskip 0.8in
  }%
  \clearpage
}
\def\@printonecoadvisor#1#2{%
  #1, \njit@doctype\ Co-Advisor \hfill Date\par
  #2\par
}
\def\@printonemember#1#2{%
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
    \par\noindent {\bfseries Degree:} \> \@degreelevel \\
    \par\noindent {\bfseries Date:} \> \defensemonth~\defenseyear \\
  \end{tabbing}
  \par\noindent {\bfseries Undergraduate and Graduate Education:}
  \printdegrees
  \begin{tabbing}
    \hskip 1.5in \= \kill
    \par\noindent {\bfseries Major:} \> \@major
  \end{tabbing}
  \printmypublications
  \clearpage
}

% Default publications hook (uses biblatex refsection with keyword "me")
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
  \ifdefined\@dedication
    \clearpage
    \thispagestyle{plain}%
    \begingroup
    \singlespacing
    \begin{center}
      \vspace*{3.0in}
      \begin{minipage}{4.5in}
        \@dedication
      \end{minipage}
    \end{center}%
    \clearpage
    \endgroup
  \fi
}

% 7. Acknowledgments Page
\newcommand{\makeacknowledgment}{%
  \ifdefined\@acknowledgment
    \clearpage
    \thispagestyle{plain}%
    \begin{center}
      \bfseries ACKNOWLEDGMENTS\par
      \vskip 20\p@
    \end{center}
    \par\@afterindentfalse\@afterheading
    \@acknowledgment
    \clearpage
  \fi
}

% 8. Glossary of Terms Page
\newcommand{\makeglossaryofterms}{%
  \ifdefined\@glossaryofterms
    \njit@listheading[0pt]{GLOSSARY OF TERMS}{\vskip 20\p@}{}%
    {\singlespacing \@glossaryofterms}%
    \njit@endcontinued
  \fi
}
% Alias for List of Definitions
\let\makelistofdefinitions\makeglossaryofterms

% Initialize all standard front matter in NJIT prescribed order
\newcommand{\initthesis}{%
  \makeabstract
  \maketitle
  \makecopyright
  \makeapproval
  \makebiography
  \makededication
  \makeacknowledgment
}

% -------------------------------------------------------------
% Main Body Initialization
% -------------------------------------------------------------
\newcommand{\startbody}{%
  \clearpage
  \pagestyle{plain}%
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
}

% -------------------------------------------------------------
% List of Symbols Environment & Helpers
% -------------------------------------------------------------
\newcommand{\symheadingname}{LIST OF SYMBOLS}

% Dedicated symbols macro to store input
\long\def\symbols#1{\gdef\@symbols{#1}}

% Generator for List of Symbols (prints nothing if \symbols was not used)
\newcommand{\makelistofsymbols}{%
  \ifdefined\@symbols
    \njit@listheading{\symheadingname}{\vskip 10pt}{}%
    {\singlespacing \@symbols}%
    \njit@endcontinued
  \fi
}
% Provide \listofsymbols as alias/generator
\let\listofsymbols\makelistofsymbols

% Dedicated List of Symbols environment
\newenvironment{symbolslist}{%
  \njit@listheading{\symheadingname}{\vskip 10pt}{}%
  \begin{singlespace}
}{%
  \end{singlespace}
  \njit@endcontinued
}

% Two-column table for the List of Symbols and Glossary of Terms (GSO: "a simple table with two
% columns"). Usage, in listofsymbols.tex:
%   \begin{symboltable}
%   \sym{$E$}{Energy of a physical system}
%   \end{symboltable}
% Rows are single-spaced, with one blank line between rows, and the table
% breaks across pages. Optional argument: width of the symbol column.
\RequirePackage{array}
\RequirePackage{longtable}
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

% Fallback support for symbol macros (\opensymdef, \newsym, etc.)
\ifdefined\opensymdef\else
  \newcommand{\opensymdef}{}
  \newcommand{\closesymdef}{}
  \newcommand{\newsym}[3][]{\expandafter\gdef\csname #2\endcsname{#3}}
\fi

% -------------------------------------------------------------
% Lists and References: single-spaced within an entry, one blank
% (single-spaced) line between entries (GSO)
% -------------------------------------------------------------
\newlength{\njit@entrysep}
% One single-spaced line at 12pt (14.5pt), measured while double spacing is on
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

% -------------------------------------------------------------
% Footnotes & Quotes
% -------------------------------------------------------------
\renewcommand\footnoterule{%
  \kern-3\p@
  \vskip 10pt
  \hrule \@width .4\columnwidth
  \kern 2.6\p@}

\renewcommand\@makefntext[1]{%
  \parindent 1em%
  \noindent
  \hb@xt@0.4em{\hss\@makefnmark}#1}

% -------------------------------------------------------------
% Utility Macros
% -------------------------------------------------------------
\providecommand{\bm}[1]{\boldsymbol{#1}}
\providecommand{\trademark}{\textsuperscript{\texttrademark}}

% Index environment for compatibility
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