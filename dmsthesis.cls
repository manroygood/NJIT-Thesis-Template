%%%% DOCUMENT HISTORY %%%%%
% Over the years, many NJIT DMS PhD students have contributed to this document. Based solely on reading the comments, these include:
% 2001: Adrienne C. N. James, First Edition
% 2001: Jerry Jen-Sou Chen, Contributor, First Edition
% 2001: Eliana Antoniou, revisions
% 2002: Stephen A. Kunec, revisions
% 2003: Hoa Kien Tran, revisions
% 2014: Shoubhik Mondal, revisions
% 2022: Jimmie Adriazola, Prof. Roy Goodman, & Prof. Christina Frederick, revisions
% Thanks to anyone else who contributed
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Specify the required LaTeX format and provide class information
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dmsthesis}[2000/03/22 NJIT DMS Dissertation LaTeX class]

% Load the base 'report' class with a 12pt default font size
\LoadClass[12pt]{report}

% Load required packages for landscape pages, appendices, spacing, and bibliography
\RequirePackage{lscape}
\RequirePackage{setspace} % For controlling text spacing
\RequirePackage[backend=biber,doi=false,url=false,defernums=true,sortcites=true,style=trad-abbrv]{biblatex}

% Pass unrecognized options to the 'report' class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

%%%%%%%%%% PAGE FORMATTING %%%%%%%%%%%
% Page layout settings tailored for a specific document style
\topmargin=-.375in % Top margin setting
\oddsidemargin=0.505in % Left margin for odd pages.
\textheight=9.0in % Total height of the text on the page
\textwidth=6in % The width of the text on the page
\parindent=0.4in % Paragraph indentation
\headsep=0.3in % Space between the header and the text
\itemindent=0.8in % Indentation for list items
\footskip=0.5in % Space from the bottom of the text to the baseline of the footer

% Enable double spacing throughout the document
\doublespacing

% Penalties to prevent widows and orphans
\widowpenalty=10000 % Discourage widow lines at the bottom of pages
\clubpenalty=10000 % Discourage orphan lines at the top of pages

% Spacing around equations
\setlength\belowdisplayskip{20pt} % Space after equations
\setlength\belowdisplayshortskip{20pt} % Shorter space after equations

% Redefine standard font size commands to use a 12pt size, ignoring their conventional meanings
\renewcommand{\large}{\normalsize}
\renewcommand{\Large}{\normalsize}
\renewcommand{\LARGE}{\normalsize}
\renewcommand{\huge}{\normalsize}
\renewcommand{\Huge}{\normalsize}

% Define commands for different line spacings, potentially for use in various parts of the document
% Note: The use of \large before \normalsize in these definitions is redundant due to the redefinitions above
\def\ssp{\def\baselinestretch{1.0}\normalsize} % Single spacing
\def\msp{\def\baselinestretch{1.2}\normalsize} % One-and-a-half spacing
\def\dsp{\def\baselinestretch{1.66}\normalsize} % Double spacing

% Define a command to convert numbers to Roman numerals in bold
\def\@roman#1{{\bf\romannumeral #1}}

% Customize the 'plain' page style for consistent footer-based page numbering
\def\ps@plain{%
      \let\@oddhead\@empty % Clear the header
      \def\@oddfoot{\normalfont\hfil{\bf\thepage}\hfil} % Center the page number in bold in the footer for odd pages
      \def\@evenfoot{\normalfont\hfil{\bf\thepage}\hfil} % Center the page number in bold in the footer for even pages
}

% Increases the penalty for hyphenating words at line breaks, discouraging hyphenation
\hyphenpenalty=1000  
% Increases the tolerance for line stretching, allowing for more flexibility in line breaking without hyphenation
\tolerance=1000  
% Increases the penalty for hyphenating compound words, discouraging breaking compound words at their hyphen
\exhyphenpenalty=1000  
% Disallows hyphenation of words that contain capital letters, preventing proper nouns and acronyms from being hyphenated
\uchyph=0  
% Adjusts the looseness of paragraph formatting, allowing for slightly looser or tighter blocks of text to improve appearance or fit
\looseness=2  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% HEADINGS %%%%%%%%%%
\renewcommand{\chaptername}{CHAPTER}

% Redefine the \chapter command to ensure a page break before each chapter and set the page style to 'plain'
\def\chapter{\clearpage \thispagestyle{plain} \global\@topnum\z@
\@afterindentfalse \secdef\@chapter\@schapter}

% Define the formatting for unnumbered chapters (e.g., Acknowledgments, Abstract)
\def\@schapter#1{
    \if@twocolumn
        \@topnewpage[\@makeschapterhead{#1}] % Start a new page in two-column mode
    \else
        \@makeschapterhead{#1} % Apply chapter heading format
    \fi
    \@afterheading % Prevent page break immediately after the heading
}

% Redefine the \@chapter command for numbered chapters to include the chapter title in the TOC with uppercase letters
\def\@chapter[#1]#2{
    \ifnum \c@secnumdepth >\m@ne % Check if the chapter number should be displayed
        \refstepcounter{chapter} % Increase the chapter counter
        \typeout{\@chapapp \space\thechapter.} % Console output for debugging
        \if@appendix % Check if in appendix
            % Add the chapter to the TOC with 'Appendix' prefix and uppercase title
            \addcontentsline{toc}{chapter}{\protect\numberline{\appendixname~\thechapter}\hspace*{0.95in}\MakeUppercase{#1}}
        \else
            % Add the chapter to the TOC with uppercase title
            \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}\MakeUppercase{#1}}
        \fi
    \else
        % For chapters without numbers, add only the title in uppercase to the TOC
        \addcontentsline{toc}{chapter}{\MakeUppercase{#1}}
    \fi
    \chaptermark{#1} % Set the chapter mark for headers
    \if@twocolumn
        \@topnewpage[\@makechapterhead{#2}] % Apply chapter head format in two-column mode
    \else
        \@makechapterhead{#2} % Apply chapter head format
    \fi
    \@afterheading % Prevent page break immediately after the heading
}

% Define the formatting for the heading of numbered chapters
\def\@makechapterhead#1{
    {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \center \bfseries \@chapapp\space \thechapter % Center and bold the 'Chapter N'
        \par\nobreak
        \vskip 5\p@ % Vertical space after the chapter number
    \fi
    \interlinepenalty\@M
    \center \bfseries \MakeUppercase{#1} % Center and bold the chapter title in uppercase
    \par\nobreak
    \vskip 35\p@ % Vertical space after the chapter title
    }
}

% Define the formatting for the heading of unnumbered chapters
\def\@makeschapterhead#1{
    {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \center \bfseries \MakeUppercase{#1} % Center and bold the chapter title in uppercase
    \par\nobreak
    }
}

% Redefine the \section command to customize section headings
\def\section{\@startsection {section}{1}{\z@}
            {-4ex}{0.01ex plus 0.01ex} % Space above and below the heading
            {\ssp\bf\center}} % Bold and centered heading text

% Redefine the \subsection command to customize subsection headings
\def\subsection{\@startsection{subsection}{2}{\z@}
            {-4ex}{0.01ex plus 0.01ex} % Space above and below the heading
            {\ssp\bf}} % Bold heading text, aligned left (default)

% Redefine the \subsubsection command to customize subsubsection headings
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}
            {3.25ex \@plus1ex \@minus.2ex} % Space above the heading
            {-1em} % Space below the heading
            {\bf}} % Bold heading text, aligned left (default)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% FOOTNOTE %%%%%%%%%%
% Ensure footnotes use a small font size
\let\footnotesize\small

% Redefines the horizontal rule that appears above footnotes
\renewcommand\footnoterule{
  \kern-3\p@  % Adjusts the vertical space before the rule
  \vskip 10pt  % Adds vertical space before the rule
  \hrule\@width.4\columnwidth  % Creates a horizontal rule with width 40% of the column width
  \kern2.6\p@  % Adjusts the vertical space after the rule
}

% Redefines how footnote text is formatted
\renewcommand\@makefntext[1]{
    \parindent 1em  % Sets the paragraph indentation for footnotes
    \noindent  % Prevents indentation of the first line
    \hb@xt@0.4em{\hss\@makefnmark}#1  % Formats the footnote marker and text
}

% Defines the detailed formatting of footnote text
\long\def\@footnotetext#1{\insert\footins{
    \def\baselinestretch{1}\footnotesize  % Sets single spacing and footnotesize font for the footnote text
    \interlinepenalty\interfootnotelinepenalty  % Controls line breaking within footnotes
    \splittopskip\footnotesep  % Sets the top skip distance for split footnotes
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM  % Controls the maximum depth for splitting footnotes
    \hsize\columnwidth  % Sets the horizontal size of footnotes to the column width
    \@parboxrestore  % Restores the settings of the parbox
	\edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}  % Defines the current label for the footnote
	\@makefntext{  % Calls the custom footnote text formatting command
        {\rule{\z@}{\footnotesep}\ignorespaces  % Adds space above the footnote text and removes any leading spaces
          #1\strut}  % Inserts the actual footnote text
    }
}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% VERBATIM %%%%%%%%%%
% Redefines the internal command for the verbatim environment setup
\def\@verbatim{
    \trivlist  % Starts an environment similar to a list but without any list markers
    \vskip\topskip  % Adds vertical space equivalent to the normal top skip for a new paragraph
    \def\baselinestretch{1}  % Ensures single line spacing within the verbatim environment
    % Checks if the current font size is the normal size and applies it; otherwise, uses the current size
    \ifx\@currsize\normalsize\@normalsize\else\@currsize\fi  
    \vskip-\topskip  % Negates the initial vertical space added
    \item[]  % Starts a new item in the trivlist without any marker
    % Applies additional spacing adjustments and sets paragraph indentations to zero
    \if@minipage\else\vskip\parskip\fi
    \leftskip\@totalleftmargin \rightskip\z@
    \parindent\z@ \parfillskip\@flushglue \parskip\z@
    % Temporarily disables LaTeX's paragraph indentation mechanism
    \@tempswafalse \def\par{\if@tempswa\hbox{}\fi\@tempswatrue\@@par}
    % Ensures that line breaks are obeyed and sets the font to typewriter style
    \obeylines \tt \catcode``=13 \@noligs \let\do\@makeother \dospecials
}

% Starts the verbatim environment, applying non-breaking spaces and enabling French spacing
\def\verbatim{\@verbatim \frenchspacing\@vobeyspaces \@xverbatim}

% Ends the verbatim environment, returning to the list-like environment's end
\let\endverbatim=\endtrivlist
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% CAPTIONS %%%%%%%%%%
% Configure caption formatting to meet specific requirements
\AtBeginDocument{
    \captionsetup{
        labelfont=bf, % Make the label (e.g., "Figure 1.1") bold
        textfont=normalfont, % Keep the caption text in the normal font
        justification=raggedright, % Align the caption text to the left, not justified
        font=singlespacing, % Use single spacing within captions
        labelsep=space % Use a space separator instead of a colon after the label
    }
}

\lefthyphenmin=5
\righthyphenmin=6

% Space above captions
\setlength\abovecaptionskip{5pt} % Space above figure and table captions

% Command to set the normal font size for ADIE, to change figure caption font if needed
\newcommand{\normalsizeADIE}{\normalsize}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% ABSTRACT %%%%%%%%%%
% Defines a command to store the abstract text
\def\abstract#1{\gdef\@abstract{#1}}  % Stores the abstract text in \@abstract using global definition

% Provides a warning if the \abstract command is used without providing any text
\def\@abstract{\@latex@warning@no@line{No \noexpand\abstract given}}

% Defines the command \makeabstract to format and display the abstract page
\newcommand{\makeabstract}{
    \newpage  % Starts a new page for the abstract
    \pagestyle{empty}  % Sets the page style to 'empty' to remove headers and footers

    % Centered title block
    \begin{center}
        \bfseries  % Applies bold formatting to the text
        \singlespace  % Applies single line spacing
        ABSTRACT  % The word 'ABSTRACT' at the top of the page
        \vskip 15pt  % Adds vertical space after 'ABSTRACT'
        \MakeUppercase{\@title}  % The title of the thesis in uppercase
        \vskip 15pt  % Adds vertical space after the title
        by  
        \par \@author  % The author's name
        \vskip 5pt  % Adds vertical space after the author's name
    \end{center}

    \@abstract  % Inserts the abstract text defined by the \abstract command

    % Starts a new page and sets the page style back to 'plain' for the subsequent pages
    % This ensures that if the abstract spans more than one page, the following pages will have a standard page style
    \newpage
    \pagestyle{plain}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% TITLE PAGE %%%%%%%%%%
% Redefines the \maketitle command for custom title page formatting
\renewcommand{\maketitle}{%
    \newpage  % Starts a new page for the title
    \thispagestyle{empty}  % Removes header and footer from the title page
    \pagenumbering{roman}  % Sets page numbering to roman numerals, starting from this page

    % Central alignment for all title page content
    \begin{center}
        \bfseries  % Bold font for the entire title page content
        \singlespace  % Applies single line spacing, overriding document-wide settings if any
        \MakeUppercase{\@title}  % Converts the title to uppercase for emphasis

        % Vertical space of 3 inches before displaying 'by' and the author's name
        \vskip 3.0in by
        \par \@author  % Displays the author's name

        % The rest of the title page content, each separated by vertical fills or fixed spaces
        \vfill  % Adds a flexible vertical space
        A Dissertation
        \par Submitted to the Faculty of
        \par \institute \\  % Displays the institute name, fetched from the \institute command
        \par in Partial Fulfillment of the Requirements for the Degree of
        \par \thisdegree  % Displays the degree, fetched from the \thisdegree command
        \vskip 20pt  % Fixed vertical space before displaying the department
        \par \department  % Displays the department, fetched from the \department command
        \vskip 20pt  % Fixed vertical space before displaying the defense date
        \par \defensemonth~\defenseyear  % Displays the defense month and year
    \end{center}  % Ends the central alignment
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% COPYRIGHT %%%%%%%%%%
% Defines a new command to create a copyright page
\newcommand{\makecopyright}{%
    \newpage  % Starts a new page for the copyright notice
    \thispagestyle{empty}  % Ensures the page has no headers or footers

    % Centers the copyright text block
    \begin{center}
        \topskip 3.5in  % Sets the top margin before the copyright text starts
        Copyright \copyright ~\defenseyear~ by \@author  % Copyright notice including the year and author's name
        \par ALL RIGHTS RESERVED  % Additional statement indicating all rights are reserved
    \end{center}

    \newpage  % Ends the copyright page and starts a new page
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% APPROVAL %%%%%%%%%%
% Initialize the dissertation advisor's name and title with empty values
\def\@advisorname{}
\def\@advisortitle{}

% Defines commands for setting the dissertation advisor's name and title
\def\advisor#1#2{
    \gdef\@advisorname{#1}  % Globally defines the advisor's name
    \gdef\@advisortitle{#2}  % Globally defines the advisor's title
}
% Provides a warning if the advisor's name or title is not set
% \def\@advisorname{\@latex@warning@no@line{No \noexpand\advisorname given}}
% \def\@advisortitle{\@latex@warning@no@line{No \noexpand\advisortitle given}}

\newif\if@coad
\@coadfalse
\def\@advisors{}
% Define a command to add a dissertation co-advisor to the list of advisors
\def\coad#1#2{
	% Check if at least one co-advisor has already been added
	\if@coad
		% If true, append the new co-advisor to the existing list
		\edef\@advisors{
			\@advisors, % Existing co-advisors
			{#1, Dissertation Co-Advisor \hfill Date \par #2} % New co-advisor
		}
	\else
		% If no co-advisors have been added yet, initialize the list with the first co-advisor
		\def\@advisors{
			{#1, Dissertation Co-Advisor \hfill Date \par #2} % First co-advisor
		}
		% Set the flag to true indicating that a co-advisor has been added
		\@coadtrue
	\fi
}

% Initializes a flag to track if committee members have been added
\newif\if@members
\@membersfalse

% Defines a command to add committee members to the approval page
\def\member#1#2{
    \if@members
        % Appends additional committee members
        \edef\@committee{
            \@committee,
            {#1, Committee Member \hfill Date \par #2}
        }
    \else
        % Defines the first committee member
        \def\@committee{
            {#1, Committee Member \hfill Date \par #2}
        }
        \@memberstrue  % Sets the flag indicating that a committee member has been added
    \fi
}

% Defines the command to create an approval page
\newcommand{\makeapproval}{
    \newpage  % Starts a new page
    \thispagestyle{empty}  % Sets the page style to empty (no headers/footers)

    % Creates the title block for the approval page
    \begin{center}
        \bfseries  % Bold font
        \singlespace  % Single line spacing
        APPROVAL PAGE  % Title of the approval page
        \vskip 15pt  % Vertical space after the title
        \MakeUppercase{\@title}  % The document title in uppercase
        \vskip 15pt  % Vertical space after the document title
        \@author  % Author's name
    \end{center}

    % Formatting for the advisor and committee members' approval signatures
    {\singlespace  % Ensures single spacing
        \vskip .5in  % Vertical space before the signature lines
        \flushleft  % Left aligns the signature lines

        % Conditionally add the advisor's signature line if \advisor is set in approval.tex
        \ifx\@advisorname\@empty\else
            \rule{\textwidth}{1.5pt}  % Creates a thick horizontal line
            \@advisorname, Dissertation Advisor \hfill Date  % Advisor's name and space for date
            \par \@advisortitle  % Advisor's title
        \fi
        % Conditionally add coadvisor if \coad set in approval.tex
        \if@coad
        	{\@for \advisors:=\@advisors \do{
                \vfill  % Fills the vertical space evenly between signature lines
                \flushleft{}
                \rule{\textwidth}{1.5pt}
                \advisors
        	}}
        \fi
        % Loops through each committee member to create their signature lines
        {\@for \committee:=\@committee \do{
            \vfill  % Fills the vertical space evenly between signature lines
            \flushleft
            \rule{\textwidth}{1.5pt}  % Creates a thick horizontal line for each committee member
            \committee
        }}
        \vskip 1.3in  % Controls spacing to the bottom of the page
    }
    \newpage  % Starts a new page after the approval page
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% BIOGRAPHY %%%%%%%%%%
% Initialize the date of birth and place of birth with empty values
\def\birthmonth{}
\def\birthday{}
\def\birthyear{}
\def\birthcity{}
\def\birthstate{}

% Command to set the defense date of the thesis or dissertation
\newcommand{\defensedate}[3]{ % Accepts three arguments: Month, Day, Year
	\def\defensemonth{#1} % Defines the month of defense
	\def\defenseday{#2} % Defines the day of defense
	\def\defenseyear{#3} % Defines the year of defense
}

% Command to set the author's date of birth
\newcommand{\dateofbirth}[3]{ % Accepts three arguments: Month, Day, Year
	\def\birthmonth{#1} % Defines the birth month
	\def\birthday{#2} % Defines the birth day
	\def\birthyear{#3} % Defines the birth year
}

% Command to set the author's place of birth
\newcommand{\placeofbirth}[2]{ % Accepts two arguments: City, State
	\def\birthcity{#1} % Defines the city of birth
	\def\birthstate{#2} % Defines the state of birth
}

% Command to set the academic department of the author
\newcommand{\department}[1]{ % Accepts one argument: Department
	\def\department{#1} % Defines the department
}

% Command to set the degree the author is pursuing
\newcommand{\thisdegree}[1]{ % Accepts one argument: Degree
	\def\thisdegree{#1} % Defines the degree
}

% Command to set the institute where the degree is being pursued
\newcommand{\institute}[1]{ % Accepts one argument: Institute
	\def\institute{#1} % Defines the institute
}

% Customize the bibliography environment for sub-bibliographies (e.g., chapters or sections)
\defbibenvironment{subbibliography}
  {
    \list
       {}
       {
         \setlength{\leftmargin}{\bibhang*2} % Double the hanging indent for sub-bibliography entries
         \setlength{\itemindent}{-\leftmargin} % Align subsequent lines in sub-bibliography entries
         \setlength{\itemsep}{\bibitemsep} % Set the space between sub-bibliography entries
         \setlength{\parsep}{\bibparsep} % Set the paragraph separation within a sub-bibliography entry
         \singlespacing % Ensure single spacing within each sub-bibliography entry
       }
  }
  {\endlist} % End of the sub-bibliography list
  {\item} % Each sub-bibliography entry is treated as an item

% Define a custom heading for sub-bibliographies
\defbibheading{subbibliography}[\refname]{%
    {\Large \bfseries } % The heading format for sub-bibliographies
}

% Defines a new command to print a section for the author's presentations and publications
\newcommand{\printmypublications}{%
    \par\noindent {\bf Presentations and Publications:} % Inserts the section title in bold
    \begin{refsection} % Starts a reference section to limit the scope of bibliographic entries
        \nocite{*} % Includes all entries from the bibliography database without explicit citation in the text
        % Generates the bibliography; filters entries tagged with 'me', uses a custom heading and bibliography environment
        \printbibliography[keyword={me},heading=subbibliography,env=subbibliography,title={}]
    \end{refsection} % Ends the reference section
}

% Defines a command to set the author's major field of study
\def\major#1{\gdef\@major{#1}}  % Globally defines the major
\def\@major{\@latex@warning@no@line{No \noexpand\major given}}  % Warning if no major is set

% Initializes a boolean flag to check if degrees are listed
\newif\if@degrees
\@degreesfalse  % Sets the initial state to false

% Defines a command to add degree information
\def\degree#1#2{
    \if@degrees
        % Appends additional degrees to the list
        \edef\@degrees{
            \@degrees,
            {#1\vskip -2.5pt #2}  % Degree and the institution with a small vertical skip
        }
    \else
        % Sets the first degree if none were previously added
        \def\@degrees{
            {#1\vskip -2.5pt #2}
        }
        \@degreestrue  % Changes the state to indicate that at least one degree is listed
    \fi
}

% Command to print the list of degrees within the biography section
\def\printdegrees{
    \begin{itemize}  % Starts an itemized list to enumerate degrees
        % Loops through each degree defined by the \degree command and stored in \@degrees
        {\@for \onedegree:=\@degrees \do{
            \singlespace  % Applies single line spacing for the list to maintain consistency
            \item \onedegree  % Creates a list item for each degree
            \vskip -10pt  % Reduces the vertical space after each list item
        }}
    \end{itemize}  % Ends the itemized list
}

% Defines the command to create a biography page
\newcommand{\makebiography}{%
    \newpage  % Starts a new page for the biography
    \begin{center}
        \bfseries BIOGRAPHICAL SKETCH  % Section title in bold
    \end{center}
    % Sets up a tabbing environment for structured information
    \begin{tabbing}
        \hskip 1.5in \= \kill  % Sets a horizontal space for alignment
        % Author's name and other personal information
        \par\noindent {\bf Author:} \> \@author \\
        \par\noindent {\bf Degree:} \> Doctor of Philosophy \\
        \par\noindent {\bf Date:} \> \defensemonth~\defenseyear
        % Conditionally include date of birth if set
        \ifx\birthmonth\@empty\else
            \\\par\noindent {\bf Date of Birth:} \> \birthmonth~\birthday,~\birthyear \\
        \fi
        % Conditionally include the place of birth if set
        \ifx\birthcity\@empty\else
            \par\noindent {\bf Place of Birth:} \> \birthcity,~\birthstate
        \fi
    \end{tabbing}
    % Section for education background
    \par\noindent {\bf Undergraduate and Graduate Education:}
    \vskip -20pt\printdegrees  % Inserts the degrees, adjusting vertical space
    \begin{tabbing}
        \hskip 1.5in \= \kill
        \par\noindent {\bf Major:} \> \@major  % Lists the major field of study
    \end{tabbing}
    \printmypublications  % Assumes a command to print publications exists
    \newpage  % Ends the biography page and starts a new page
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% DEDICATION %%%%%%%%%%
% Defines a command to store the dedication text
\def\dedication#1{\gdef\@dedication{#1}}  % Globally defines the dedication text

% Provides a warning if the \dedication command is used without providing any text
\def\@dedication{\@latex@warning@no@line{No \noexpand\dedication given}}

% Defines the command to create the dedication page
\newcommand{\makededication}{
    \newpage  % Starts a new page for the dedication
    {\singlespace  % Applies single line spacing within the dedication
        \begin{center}  % Centers the dedication text block
            \topskip 4in  % Adds a top skip of 4 inches to vertically position the dedication text
            \begin{minipage}{4in}  % Creates a minipage of 4 inches width to contain the dedication text
                \@dedication  % Inserts the dedication text
            \end{minipage}
        \end{center}
    }
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% ACKNOWLEDGEMENTS %%%%%%%%%%
% Defines a command to store the acknowledgment text
\def\acknowledgment#1{\gdef\@acknowledgment{#1}}  % Stores the acknowledgment text globally

% Provides a warning if the \acknowledgment command is used without providing any text
\def\@acknowledgment{\@latex@warning@no@line{No \noexpand\acknowledgment given}}

% Defines the command to create the acknowledgment page
\newcommand{\makeacknowledgment}{
    \newpage  % Starts a new page for the acknowledgment
    \begin{center}  % Centers the acknowledgment title
        \bfseries ACKNOWLEDGMENTS  % Bold acknowledgment title
        \vskip 20\p@  % Adds vertical space (20pt) after the title to reduce the gap
    \end{center}
    \@acknowledgment  % Inserts the acknowledgment text defined by the \acknowledgment command
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% FRONT MATTER %%%%%%%%%%
% Command to compile introductory pages in a specific order
\def\initthesis{
    \makeabstract     % Inserts the abstract page
    \maketitle        % Inserts the title page
    \makecopyright    % Inserts the copyright page
    \makeapproval     % Inserts the approval page
    \makebiography    % Inserts the biography page
    \makededication   % Inserts the dedication page
    \makeacknowledgment % Inserts the acknowledgment page
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Table of Contents (TOC) %%%%%%%%%%
\renewcommand{\contentsname}{TABLE OF CONTENTS}

% Customization for the Table of Contents (TOC)
\renewcommand\tableofcontents{%
    \chapter*{\contentsname} % Print the TOC title as an unnumbered chapter
    \vskip 10pt
    \usebox{\toctopbox}\par \vspace{2ex} % Use a predefined box for TOC header formatting
    \gdef\@texttop{\toc1} % Define a macro for additional TOC formatting
    {\onehalfspacing \@starttoc{toc}} % Start the actual TOC content with one-and-half spacing
    \newpage % Start a new page after the TOC
    \gdef\@texttop{} % Reset the macro for further use
}

% Redefines the command to create entries in the TOC and similar lists (List of Figures, List of Tables)
\def\@dottedtocline#1#2#3#4#5{
    % Check if the current section depth is within the allowed TOC depth
    \ifnum #1>\c@tocdepth \else
        % Skip vertical space at the beginning of the entry
        \vskip \z@ plus .2pt
        % Set the left and right indents, and ensure the paragraph fills the available space
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
        % Set the paragraph indent and ensure indentation after line breaks
        \parindent #2\relax\@afterindenttrue
        % Set penalty to discourage line breaks within entries
        \interlinepenalty\@M
        % Start horizontal mode to prevent page breaks
        \leavevmode
        % Temporary dimension for adjusting the left skip
        \@tempdima #3\relax \advance\leftskip \@tempdima
        % Increase left skip to create space for the entry text
        \advance\leftskip 1em \hbox{}\hskip -\leftskip
        % Insert the entry text with a non-breaking space
        #4\nobreak
        % Create the dotted line leader filling the space to the page number
        \leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfill \nobreak
        % Align the page number to the right within the predefined width
        \hbox to\@pnumwidth{\hfil\rm #5}
        % Skip vertical space at the end of the entry
        \par\vskip 1.8ex}\fi
}

% Define the pattern for dot leaders used in TOC, LOF, and LOT
\def\thedots{\cleaders\hbox{$\m@th \mkern4.5mu . \mkern4.5mu$}\hfill}
% Define TOC entry format for chapters with minimal left indentation
\def\l@chapter{\@dottedtocline{1}{0.000001mm}{1.4em}}
% Define TOC entry format for sections with increased indentation
\def\l@section{\@dottedtocline{1}{1.4em}{2.3em}}
% Define TOC entry format for subsections with further increased indentation
\def\l@subsection{\@dottedtocline{2}{3.7em}{3em}}
% Define TOC entry format for subsubsections with even greater indentation
\def\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}

% Start the specified list (TOC, LOF, LOT) by reading the corresponding file and setting up the output stream if file writing is enabled
\def\@starttoc#1{%
  {\begingroup
    \topskip .7in % Set the top margin space for the first page of the list
    \makeatletter
    \@input{\jobname.#1}% Read the corresponding .toc, .lof, or .lot file
    \if@filesw % If file writing is enabled
      \expandafter\newwrite\csname tf@#1\endcsname % Create a new write stream
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax % Open the corresponding file for writing
    \fi
    \@nobreakfalse
  \endgroup}}

% Define a box for the TOC header with 'Chapter' on the left and 'Page' on the right, both in bold
\newsavebox{\toctopbox}
\savebox{\toctopbox}[\textwidth]{\bf Chapter \hfill Page}
% Apply the TOC header formatting and center the 'TABLE OF CONTENTS' title
\def\toc1{%
\gdef\@texttop{
\parindent 0pt % Disable paragraph indentation
{\onehalfspacing % Use one-half line spacing
\begin{center}
	\bf \contentsname % Bold 'TABLE OF CONTENTS'
	\vskip -1pt(Continued) % Add '(Continued)' text with a small vertical skip
	\usebox{\toctopbox} % Use the previously defined TOC header box
\end{center}
}
\vskip -.5in % Add vertical space after the header
}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% List of Figures (LOF) %%%%%%%%%%
% Customization for the List of Figures (LOF)
\renewcommand{\listfigurename}{LIST OF FIGURES}

\renewcommand\listoffigures{%
    \chapter*{\listfigurename} % Create an unnumbered chapter for the list of figures
    \vskip 10pt % Add vertical space
    \usebox{\loftopbox}\par \vspace{2ex} % Use a predefined box for consistent formatting
    \gdef\@texttop{\lof1} % Define formatting for the content
    {\onehalfspacing \@starttoc{lof}} % Use one-half spacing and start the list of figures
    \newpage % Start a new page after the list of figures
    \gdef\@texttop{} % Reset the formatting
}

% Define the format for figure entries in the LOF with specific indentation and space for the entry number
\def\l@figure{\@dottedtocline{1}{0.001em}{2.5em}}

% Create a new save box to hold the header for the List of Figures
\newsavebox{\loftopbox}
% Define the content of the LOF header, aligning 'Figure' to the left and 'Page' to the right, both in bold
\savebox{\loftopbox}[\textwidth]{\bf Figure \hfill Page}

% Define the LOF title and header format
\def\lof1{%
\gdef\@texttop{ % Global definition to ensure the header format is used throughout the document
\parindent 0pt % Remove paragraph indentation for this section
{\onehalfspacing % Apply one-half line spacing for a slightly more open layout
\begin{center}
	\bf \listfigurename % Bold 'List of Figures' title, centered
	\vskip -1pt(Continued) % Add a small vertical space and '(Continued)' text for subsequent pages
	\usebox{\loftopbox} % Insert the predefined LOF header
\end{center}
}
\vskip -.5in % Add some vertical space after the header
}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% List of Tables (LOT) %%%%%%%%%%
\renewcommand{\listtablename}{LIST OF TABLES}

% Customization for the List of Tables (LOT)
\renewcommand\listoftables{%
    \chapter*{\listtablename} % Create an unnumbered chapter for the list of tables
    \vskip 10pt % Add vertical space
    \usebox{\lottopbox}\par \vspace{2ex} % Use a predefined box for consistent formatting
    \gdef\@texttop{\lot1} % Define formatting for the content
    {\onehalfspacing \@starttoc{lot}} % Use one-half spacing and start the list of tables
    \newpage % Start a new page after the list of tables
    \gdef\@texttop{} % Reset the formatting
}

% Alias table entries format to be the same as figure entries, avoiding redundancy
\let\l@table\l@figure

% Create a new save box for the List of Tables header
\newsavebox{\lottopbox}
% Define the content of the LOT header, similar to the LOF header
\savebox{\lottopbox}[\textwidth]{\bf Table \hfill Page}

% Define the LOT title and header format, similar to the LOF definition
\def\lot1{%
\gdef\@texttop{
\parindent 0pt
{\onehalfspacing
\begin{center}
	\bf \listtablename % Bold 'List of Tables' title, centered
	\vskip -1pt(Continued) % Consistency with LOF for continued sections
	\usebox{\lottopbox} % Insert the predefined LOT header
\end{center}
}
\vskip -.5in % Consistent vertical spacing after the header, as with LOF
}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% LIST OF SYMBOLS %%%%%%%%%%
% There are two ways to create the list of symbols. You can call \listofsymbols or you can input the file listofsymbols.tex

% Includes the 'listofsymbols' package with specific options
\RequirePackage[final,pageno,noxspace]{listofsymbols}

% Redefines the heading name for the list of symbols to include additional vertical space after it
\renewcommand{\symheadingname}{{LIST OF SYMBOLS} \vskip 10pt}

% Redefines how each symbol entry is formatted in the list
\renewcommand{\symheading} {
    \section*{\symheadingname}  % Creates a non-numbered section for the list of symbols
    \makebox[\symwidth+\symindent][l]{\bf Symbol}  % Formats the 'Symbol' column header
    {\bf Description}  % Formats the 'Description' column header
    \ifthenelse{\boolean{b@pageno}}{  % Conditional to include page numbers
        \hfill{\bf Defined on page}  % Formats and positions the 'Defined on page' column header
    }{}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% GLOSSARY OF TERMS %%%%%%%%%%
% You can create a glossary of terms by calling \makeglossaryofterms. I don't think this is used anymore. Instead a new tex file named listofdefinitions.tex is input in main.tex.

% Defines a command to store the glossary content
\def\glossaryofterms#1{\gdef\@glossaryofterms{#1}}  % Globally defines the content for the glossary

% Provides a warning if the \glossaryofterms command is used without content
\def\@glossaryofterms{\@latex@warning@no@line{No \noexpand\glossaryofterms given}}

% Defines formatting for the glossary continuation header
\def\gloss1{%
    \gdef\@texttop{  % Globally defines the top text for glossary pages
        \parindent 0pt \raggedleft  % No paragraph indentation, aligns text to the right
        {\onehalfspacing  % Applies one-half line spacing
            \begin{center}
                \bf GLOSSARY OF TERMS  % Bold title for the glossary section
                \vskip -1pt (Continued)  % Adds "Continued" with slight vertical space adjustment
            \end{center}
        }
        \vskip -.1in  % Adjusts vertical space after the header
    }
}

% Defines the command to create the glossary section
\newcommand{\makeglossaryofterms}{
    \chapter*{GLOSSARY OF TERMS}  % Creates an unnumbered chapter for the glossary
    \vskip 10pt  % Adds vertical space after the glossary title
    \gdef\@texttop{\gloss1}  % Uses the defined glossary header formatting
    {\onehalfspacing \@glossaryofterms}  % Applies one-half line spacing to the glossary content
    \newpage  % Starts a new page after the glossary section
    \gdef\@texttop{}  % Resets the top text formatting
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% PREFACE %%%%%%%%%%
% Command to start the preface section
\def\preface{
    \pagestyle{plain}  % Sets the page style to 'plain', typically meaning no header and a centered page number footer
    \newpage  % Starts a new page for the preface
    \addcontentsline{toc}{chapter}{PREFACE}  % Adds the preface to the Table of Contents (TOC) as a chapter entry
    {\bf \centerline {PREFACE}}  % Centers and boldfaces the word 'PREFACE' as the title
    \vskip 1em  % Adds vertical space after the title
    \noindent  % Prevents the first paragraph from being indented
    \hspace{-0.7em}  % Adjusts horizontal space, slightly shifting the following text to the left
}

% Command to end the preface section
\def\endpreface{
    \newpage  % Starts a new page after the preface, signaling its end
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% DOCUMENT BODY %%%%%%%%%%
% Command to start the main body of the thesis
\def\startbody{
    \newpage           % Starts a new page
    \pagestyle{empty}  % Initially sets the page style to empty
    \pagestyle{plain}  % Sets the page style to plain for the main body
    \pagenumbering{arabic} % Uses Arabic numerals for page numbering
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% APENDIX %%%%%%%%%%
\RequirePackage[page,toc,titletoc,title]{appendix}
\renewcommand{\appendixname}{APPENDIX}

% Flag to track if the document is in the appendix section
\newif\if@appendix
\@appendixfalse
\let\originalAppendix\appendix % Save the original \appendix command for later use
\renewcommand{\appendix}{%
    \@appendixtrue % Flag that we are now in the appendix section
    \originalAppendix % Call the original \appendix command
}

% Defines a new command for a single appendix entry
\newcommand{\oneappendix}[1]{
    % Starts a new unnumbered chapter with the word 'APPENDIX' and the custom title provided as #1
    % The title is separated from 'APPENDIX' by one line (baselineskip) and followed by two lines (2\baselineskip) of space
    \chapter*{APPENDIX\\[\baselineskip]#1\\[2\baselineskip]}
    
    % Adds an entry to the TOC under 'chapter', formatted as 'APPENDIX: TITLE', with 'TITLE' converted to uppercase
    \addcontentsline{toc}{chapter}{APPENDIX: \MakeUppercase{#1}}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% BIBLIOGRAPHY %%%%%%%%%%
\renewcommand{\bibname}{BIBLIOGRAPHY}

% Set the spacing between bibliography entries to the current baseline skip (for double spacing)
\setlength{\bibitemsep}{0.5\baselineskip}

% Customize the bibliography environment for a standard bibliography
\defbibenvironment{bibliography}
  {
    \vskip 15pt % Add vertical space before the bibliography starts
    \list
       {\printfield[labelnumberwidth]{labelnumber}} % Print the label number for each entry
       {
         \setlength{\leftmargin}{\bibhang*2} % Double the hanging indent for each entry
         \setlength{\itemindent}{-\leftmargin} % Align subsequent lines in each entry
         \setlength{\itemsep}{\bibitemsep} % Set the space between entries
         \setlength{\parsep}{\bibparsep} % Set the paragraph separation within an entry
         \singlespacing % Ensure single spacing within each entry
       }
  }
  {\endlist} % End of the bibliography list
  {\item} % Each bibliography entry is treated as an item
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%