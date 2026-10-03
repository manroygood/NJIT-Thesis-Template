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
\ProvidesClass{dmsthesis}[2026/10/03 NJIT DMS Dissertation LaTeX class (Overhauled)]

% Pass any options to the underlying report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

% Base report class with 12pt default
\LoadClass[12pt]{report}

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

% Caption formatting conforming to NJIT guidelines
\RequirePackage{caption}
\captionsetup{
  font={singlespacing,normalsize},
  labelfont=bf,
  labelsep=colon,
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

% Roman numeral formatting macro
\def\@roman#1{{\bfseries\romannumeral #1}}

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
  \if@twocolumn
    \@topnewpage[\@makeschapterhead{#1}]%
  \else
    \@makeschapterhead{#1}%
    \@afterheading
  \fi}

% Numbered chapters
\def\@chapter[#1]#2{%
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
    \begin{center}
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
    \begin{center}
      \bfseries \MakeUppercase{#1}\par
    \end{center}
    \nobreak
    \vskip 20\p@
  }}

% Section headings: Centered, Bold
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries\centering}}

% Subsection headings: Flush left, Bold
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}

% Subsubsection headings: Flush left, Bold
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}

% Paragraph headings: Run-in, Bold
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\normalfont\normalsize\bfseries}}

% -------------------------------------------------------------
% Table of Contents, List of Figures, and List of Tables
% -------------------------------------------------------------
\newsavebox{\toctopbox}
\savebox{\toctopbox}[\textwidth]{\bfseries Chapter \hfill Page}

\newsavebox{\loftopbox}
\savebox{\loftopbox}[\textwidth]{\bfseries Figure \hfill Page}

\newsavebox{\lottopbox}
\savebox{\lottopbox}[\textwidth]{\bfseries Table \hfill Page}

% Safe continuation headers for multi-page TOC, LOF, LOT
\newcommand{\toc@continued}{%
  \parindent\z@
  \begin{center}
    \singlespacing\bfseries
    \contentsname\par
    \vskip 2pt
    \mdseries(Continued)\par
    \vskip 8pt
    \usebox{\toctopbox}
  \end{center}
  \par\vspace{2ex}%
}

\newcommand{\lof@continued}{%
  \parindent\z@
  \begin{center}
    \singlespacing\bfseries
    \listfigurename\par
    \vskip 2pt
    \mdseries(Continued)\par
    \vskip 8pt
    \usebox{\loftopbox}
  \end{center}
  \par\vspace{2ex}%
}

\newcommand{\lot@continued}{%
  \parindent\z@
  \begin{center}
    \singlespacing\bfseries
    \listtablename\par
    \vskip 2pt
    \mdseries(Continued)\par
    \vskip 8pt
    \usebox{\lottopbox}
  \end{center}
  \par\vspace{2ex}%
}

\newcommand{\toc@firstpage}{\gdef\@texttop{\toc@continued}}
\newcommand{\lof@firstpage}{\gdef\@texttop{\lof@continued}}
\newcommand{\lot@firstpage}{\gdef\@texttop{\lot@continued}}

\renewcommand\tableofcontents{%
  \clearpage
  \thispagestyle{plain}%
  \begin{center}
    \bfseries \contentsname\par
    \vskip 10pt
    \usebox{\toctopbox}
  \end{center}
  \par\vspace{2ex}%
  \gdef\@texttop{\toc@firstpage}%
  {\singlespacing\emergencystretch=2.5em \@starttoc{toc}}%
  \clearpage
  \gdef\@texttop{}%
}

\renewcommand\listoffigures{%
  \clearpage
  \thispagestyle{plain}%
  \addcontentsline{toc}{chapter}{\listfigurename}%
  \begin{center}
    \bfseries \listfigurename\par
    \vskip 10pt
    \usebox{\loftopbox}
  \end{center}
  \par\vspace{2ex}%
  \gdef\@texttop{\lof@firstpage}%
  {\singlespacing\emergencystretch=2.5em \@starttoc{lof}}%
  \clearpage
  \gdef\@texttop{}%
}

\renewcommand\listoftables{%
  \clearpage
  \thispagestyle{plain}%
  \addcontentsline{toc}{chapter}{\listtablename}%
  \begin{center}
    \bfseries \listtablename\par
    \vskip 10pt
    \usebox{\lottopbox}
  \end{center}
  \par\vspace{2ex}%
  \gdef\@texttop{\lot@firstpage}%
  {\singlespacing\emergencystretch=2.5em \@starttoc{lot}}%
  \clearpage
  \gdef\@texttop{}%
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
     \hbox to\@pnumwidth{\hfil\normalfont\bfseries #5}\par\vskip 1.5ex}%
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
  \setcounter{chapter}{1}%
  \setcounter{section}{0}%
  \@appendixtrue
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}%
  \clearpage
  \thispagestyle{plain}%
  \begin{center}
    \bfseries APPENDIX\par
    \vskip 12pt
    \MakeUppercase{#1}
  \end{center}
  \par\nobreak\vskip 30\p@
  \@afterheading
  \addcontentsline{toc}{chapter}{APPENDIX: \protect\MakeUppercase{#1}}%
}

% -------------------------------------------------------------
% Front Matter Definitions & Metadata
% -------------------------------------------------------------
\def\defensedate#1#2#3{%
  \gdef\defensemonth{#1}%
  \gdef\defenseday{#2}%
  \gdef\defenseyear{#3}%
}
\def\defensemonth{May}
\def\defenseday{1}
\def\defenseyear{2026}

\newcommand{\department}[1]{\def\@department{#1}}
\newcommand{\thisdegree}[1]{\def\@thisdegree{#1}}
\newcommand{\institute}[1]{\def\@institute{#1}}
\newcommand{\major}[1]{\def\@major{#1}}

% Defaults
\def\@department{Department of Mathematical Sciences}
\def\@thisdegree{Doctor of Philosophy in Mathematical Sciences}
\def\@institute{New Jersey Institute of Technology and \par Rutgers, The State University of New Jersey---Newark}
\def\@major{Mathematical Sciences}

\def\advisor#1#2{\gdef\@advisorname{#1}\gdef\@advisortitle{#2}}
\def\@advisorname{\@latex@warning@no@line{No advisor given}}
\def\@advisortitle{\@latex@warning@no@line{No advisor title given}}

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

\newcommand{\degree}[2]{%
  \if@degrees
    \g@addto@macro\@degrees{,{{#1}{#2}}}%
  \else
    \gdef\@degrees{{{#1}{#2}}}%
    \@degreestrue
  \fi
}

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
  \vskip -2.5pt
  #2\vskip -4pt
}

% Abstract
\def\abstract#1{\gdef\@abstract{#1}}
\def\@abstract{\@latex@warning@no@line{No abstract given}}

% Dedication
\def\dedication#1{\gdef\@dedication{#1}}

% Acknowledgment
\def\acknowledgment#1{\gdef\@acknowledgment{#1}}

% Glossary / List of Definitions
\def\glossaryofterms#1{\gdef\@glossaryofterms{#1}}

% -------------------------------------------------------------
% Front Matter Page Generators
% -------------------------------------------------------------

% 1. Abstract Page
\newcommand{\makeabstract}{%
  \clearpage
  \pagestyle{empty}%
  \begin{center}
    \singlespacing\bfseries
    ABSTRACT\par
    \vskip 15pt
    \MakeUppercase{\@title}\par
    \vskip 15pt
    by \par \@author\par
    \vskip 15pt
  \end{center}
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
    A Dissertation\par
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

% 3. Copyright Page
\newcommand{\makecopyright}{%
  \clearpage
  \thispagestyle{empty}%
  \begin{center}
    \vspace*{3.0in}
    Copyright \copyright\ \defenseyear\ by \@author\par
    ALL RIGHTS RESERVED
  \end{center}%
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
    \@advisorname, Dissertation Advisor \hfill Date\par
    \@advisortitle\par
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
    \par\noindent {\bfseries Degree:} \> Doctor of Philosophy \\
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
      \printbibliography[keyword={me},heading=subbibliography,title={}]
    \end{refsection}
  \fi
}

% 6. Dedication Page
\newcommand{\makededication}{%
  \ifdefined\@dedication
    \clearpage
    \thispagestyle{plain}%
    \singlespacing
    \begin{center}
      \vspace*{3.0in}
      \begin{minipage}{4.5in}
        \@dedication
      \end{minipage}
    \end{center}%
    \clearpage
  \fi
}

% 7. Acknowledgment Page
\newcommand{\makeacknowledgment}{%
  \ifdefined\@acknowledgment
    \clearpage
    \thispagestyle{plain}%
    \begin{center}
      \bfseries ACKNOWLEDGMENT\par
      \vskip 20\p@
    \end{center}
    \@acknowledgment
    \clearpage
  \fi
}

% 8. Glossary of Terms Page
\newcommand{\gloss@continued}{%
  \parindent\z@
  \begin{center}
    \singlespacing\bfseries
    GLOSSARY OF TERMS\par
    \vskip 2pt
    \mdseries(Continued)
  \end{center}
  \par\vspace{2ex}%
}

\newcommand{\gloss@firstpage}{\gdef\@texttop{\gloss@continued}}

\newcommand{\makeglossaryofterms}{%
  \ifdefined\@glossaryofterms
    \clearpage
    \thispagestyle{plain}%
    \addcontentsline{toc}{chapter}{GLOSSARY OF TERMS}%
    \begin{center}
      \bfseries GLOSSARY OF TERMS\par
      \vskip 20\p@
    \end{center}
    \gdef\@texttop{\gloss@firstpage}%
    {\singlespacing \@glossaryofterms}%
    \clearpage
    \gdef\@texttop{}%
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
% Preface Environment
% -------------------------------------------------------------
\def\preface{%
  \clearpage
  \thispagestyle{plain}%
  \addcontentsline{toc}{chapter}{PREFACE}%
  \begin{center}
    \bfseries PREFACE
  \end{center}
  \par\vspace{2ex}%
}
\def\endpreface{%
  \clearpage
}

% -------------------------------------------------------------
% List of Symbols Environment & Helpers
% -------------------------------------------------------------
\newcommand{\symheadingname}{LIST OF SYMBOLS}

% Continuation header for multi-page List of Symbols
\newcommand{\sym@continued}{%
  \parindent\z@
  \begin{center}
    \singlespacing\bfseries
    LIST OF SYMBOLS\par
    \vskip 2pt
    \mdseries(Continued)
  \end{center}
  \par\vspace{2ex}%
}

\newcommand{\sym@firstpage}{\gdef\@texttop{\sym@continued}}

% Dedicated symbols macro to store input
\def\symbols#1{\gdef\@symbols{#1}}

% Generator for List of Symbols
\newcommand{\makelistofsymbols}{%
  \clearpage
  \thispagestyle{plain}%
  \addcontentsline{toc}{chapter}{LIST OF SYMBOLS}%
  \begin{center}
    \bfseries LIST OF SYMBOLS\par
    \vskip 10pt
  \end{center}
  \par\vspace{2ex}%
  \ifdefined\@symbols
    \gdef\@texttop{\sym@firstpage}%
    {\singlespacing \@symbols}%
    \clearpage
    \gdef\@texttop{}%
  \fi
}
% Provide \listofsymbols as alias/generator
\let\listofsymbols\makelistofsymbols

% Dedicated List of Symbols environment
\newenvironment{symbolslist}{%
  \clearpage
  \thispagestyle{plain}%
  \addcontentsline{toc}{chapter}{LIST OF SYMBOLS}%
  \begin{center}
    \bfseries LIST OF SYMBOLS\par
    \vskip 10pt
  \end{center}
  \par\vspace{2ex}%
  \gdef\@texttop{\sym@firstpage}%
  \begin{singlespace}
}{%
  \end{singlespace}
  \clearpage
  \gdef\@texttop{}%
}

% Fallback support for symbol macros (\opensymdef, \newsym, etc.)
\ifdefined\opensymdef\else
  \newcommand{\opensymdef}{}
  \newcommand{\closesymdef}{}
  \newcommand{\newsym}[3][]{\expandafter\gdef\csname #2\endcsname{#3}}
\fi

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