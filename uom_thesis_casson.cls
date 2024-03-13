%% Alex Casson - alex.casson@manchester.ac.uk
%
% Aim
% A LaTeX class file for submitting University of Manchester thesis, particularly PhD ones
%
% Versions
% 15.10.22 - v3 - removed axessibility package for accessibility as too many bugs with texlive 2022. Added in PDF/A support instead. Otherwise, minor tidy up updates and checked for 2022 regulations
% 25.05.21 - v2 - updates for 2021: COVID impact statement, now a single list of references at the end, and a few minor cosmetic changes
% 07.06.17 - v1 - initial script
%
% Notes
% - Based upon June 2022 submission guidelines (http://documents.manchester.ac.uk/DocuInfo.aspx?DocID=7420)
% - Assumes build with XeLaTeX or LuaLaTeX. Font setting is different for LaTeX or PDFLaTeX
% - On Linux systems requires ttf-mscorefonts-installer to be installed to have access to the correct fonts. If compling via Overleaf not all of the fonts allows allowed by the University (particularly Calibri) are installed. You'll need to manually upload the font files for your project for this option to work. 
% - Font options are: 10pt Arial, Verdana, Tahoma, Trebuchet OR 12pt Calibri, Times, Times New Roman, Palatino and Garamond. Calibri is preferred here.
% - TODO: Font size is changed via a \AtBeginDocument. Ideally would be done at \LoadClass, but get a loop as fontspec needs to know the font size to change the font. The current methods works, except that the main title, and the figure/table captions, are always the same size regardless of the asked for font size. As choices are only 10pt or 12pt this doesn't make a big difference. It would be nice to fix!
% - TODO: It would be good to have the copyright statement etc, automatically added to the document meta-data. This is to-do.
% - TODO: There is a requirement of blank pages to say "Blank page". This is not done automatically.
% - TODO: Fix the axessibility package
% - TODO: Add support for double sided layouts. This is allowed under the regulations, but only single sided is supported here
% - TODO: There are now quite a lot of preface pages,taking up a lot of space in the table of contents (nearly half a page!). It might be good to group these under a 'Front matter' heading, which would mean they take up less space. The electronic TOC already does this, but not the printed one
% - TODO: Add blank page text
% - Adds a UoM logo. No requirement for this, but is nice. Note sizes are hand calculated. Won't be correct if change paper size
% - Assumes title page is only one page long!
% - Assumes not using subfigure. Tocloft has (easily fixed) issues if do.
% - Note that for the references font size it is set here to be one larger than that actually wanted. Not clear why, but then gives the correct size! Have to do this in main .tex
% -----------------------------------------------------------------------------

%% Class definition - based upon report class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uom_thesis_casson}[2022/10/15 - Alex Casson - University of Manchester thesis format]
\LoadClass[a4paper, oneside]{report}

%% Load packages
\RequirePackage[a-3u]{pdfx}
%\RequirePackage{hyperref}                % create internal hyperlinks, must be specified before cite package to work. Is loaded automatically by pdfx
  \hypersetup{hidelinks,colorlinks=false,breaklinks=true,bookmarksdepth=2}  % have no highlighting on links and break lines in the LOF and LOT
\RequirePackage[explicit]{titlesec}      % re-format section titles
\RequirePackage{geometry}                % set paper margins
\RequirePackage{setspace}                % set line spacing
%\RequirePackage[document]{ragged2e}      % comment this out so text isn't ragged on the RHS
\RequirePackage{pgfcore}                 % for logo positioning in fixed location
\RequirePackage{fontspec}                % for font setting
\RequirePackage{tocloft} % allows precise control over the table of contents and deals with subfigures properly
  \renewcommand{\listfigurename}{List of figures} 
  \renewcommand{\listtablename}{List of tables} 
  \renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}} % add dots 
  \renewcommand{\cftsubsecleader}{\cftdotfill{\cftdotsep}}
  \setlength{\cftfignumwidth}{3em}  % modify number width in LoF
  \setlength{\cfttabnumwidth}{3em}  % modify number width in LoT
  \setlength{\cftfigindent}{0em}    % no indents in LoF
  \setlength{\cfttabindent}{0em}    % no indents in LoT
\RequirePackage{bookmark}                % for adding custom bookmarks
  \bookmarksetup{numbered}
\RequirePackage{enumitem}                % allow change of numbering style in enumeration
\RequirePackage{ifthen}                  % allow if then else statements
\RequirePackage{appendix}                % control over appendix
\RequirePackage{caption}                 % control figure captions

%% Handle options
\def\@@ptsize{12pt} % font size variable
\@namedef{ds@10pt}{\def\@ptsize{10}}
\newcommand{\reportyear}{thesis} % set report type
\DeclareOption{calibri}{\setmainfont[Ligatures=TeX]{Calibri} \def\@@ptsize{12pt}}  
\DeclareOption{times}{\setmainfont[Ligatures=TeX]{TeX Gyre Termes} \def\@@ptsize{12pt}}
\DeclareOption{palatino}{\setmainfont[Ligatures=TeX]{TeX Gyre Pagella} \def\@@ptsize{12pt}}
\DeclareOption{garamond}{\setmainfont[Ligatures=TeX]{Adobe Garamond Pro} \def\@@ptsize{12pt}}
\DeclareOption{arial}{\setmainfont[Ligatures=TeX]{Arial} \def\@@ptsize{10pt}}
\DeclareOption{tahoma}{\setmainfont[Ligatures=TeX]{Tahoma} \def\@@ptsize{10pt}}
\DeclareOption{verdana}{\setmainfont[Ligatures=TeX]{Verdana} \def\@@ptsize{10pt}}
\DeclareOption{trebuchet}{\setmainfont[Ligatures=TeX]{Trebuchet MS} \def\@@ptsize{10pt}}
\DeclareOption{thesis}{\renewcommand{\reportyear}{thesis}}
\DeclareOption{first}{\renewcommand{\reportyear}{first}}
\DeclareOption{second}{\renewcommand{\reportyear}{second}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

%% Accessibility options
%\RequirePackage{unicode-math} % unicode maths for accessibility
% Removed axessibility in 2022 version - 2022 version of texlive seems to have lots of bugs with this!
% Put the two lines low before decalre document class
%\RequirePackage{pdfmanagement-testphase}
%\DeclareDocumentMetadata{uncompress}
% Other lines go here
%\RequirePackage[tagpdf]{axessibility} % LaTeX readable equations for accessibility
%  \tagpdfsetup{tabsorder=structure,uncompress,activate-all,interwordspace=true}
%  \pdfextension catalog{/Lang (en-GB)} % note the language is also set on line 48, should match
% Can then use \alt command:
%\begin{figure}
%    \centering
%    \includegraphics[width=10cm]{apollo17_earth.jpg}
%    \alt{Image of the Earth from outer space}
%    \caption{Image of the Earth from the Apollo 17 mission}
%    \label{fig:earth}
%\end{figure}

%% Set lengths - sizes for A4 paper from http://www.brand.manchester.ac.uk/visual-identity/print/
\newlength{\logowidth}    \setlength{\logowidth}{40.006mm}
\newlength{\logoheight}   \setlength{\logoheight}{19.454mm}
\newlength{\logopad}      \setlength{\logopad}{14.279mm}
\newlength{\marginleft}   \setlength{\marginleft}{2cm}   % Binding page margin is reccomended at 4cm.
\newlength{\marginright}  \setlength{\marginright}{2cm} 
\newlength{\margintop}    \setlength{\margintop}{1.5cm}
\newlength{\marginbottom} \setlength{\marginbottom}{1.5cm}  

%% Set paper format
\geometry{a4paper, top=\margintop, left=\marginleft, right=\marginright, bottom=\marginbottom, nohead, nofoot, nomarginpar} 

%% Formatting options - mainly for font size
\setlength{\parskip}{2ex plus 0.5ex minus 0.2ex}
\setlength{\parindent}{0pt}
\linespread{1.5}
\pagestyle{plain} % simple page numbering
\AtBeginDocument{
  \fontsize{\@@ptsize}{\@@ptsize+1pt}\selectfont
}
\setcounter{tocdepth}{2}                % set toc depth. This is changed for the Appendix
\renewcommand{\topfraction}{0.85}       % depreciate use of full pages for images
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}
\setlength{\footskip}{26pt}

% Format captions
\DeclareCaptionFormat{myformat}{\fontsize{\ds@10pt}{\@@ptsize plus 1pt}\selectfont#1#2#3}
\captionsetup{justification=centering,labelformat=simple,labelsep=period,format=myformat}
 
%% Format titles
\titleformat{\chapter}{\bfseries\Huge\raggedright}{\thechapter}{1ex}{#1} % default formatting for non-theses
\titlespacing{\chapter}{0pt}{\@@ptsize}{\baselineskip}
\ifthenelse{\equal{\reportyear}{thesis}}{\titleformat{\chapter}[display]{\bfseries\Huge\raggedright}{\chaptername~\thechapter}{0.5ex}{#1}}{}
\renewcommand{\contentsname}{\bfseries\Huge Contents}
\renewcommand{\listfigurename}{\bfseries\Huge List of figures}
\renewcommand{\listtablename}{\bfseries\Huge List of tables}
\titleformat{\section}{\bfseries\Large}{\thesection}{1ex}{#1}
\titlespacing{\section}{0pt}{\baselineskip}{0.2\baselineskip}
\titleformat{\subsection}{\bfseries\large}{\thesubsection}{1ex}{#1}

%% COVID-19 impact statement
\newenvironment{uomcovid}{
  \phantomsection \pdfbookmark[section]{COVID-19 impact statement}{covid}
  \chapter*{COVID-19 impact statement}
  \pagenumbering{gobble}
}
{\clearpage}

%% Title page
\makeatletter
\def\faculty#1{\gdef\@faculty{#1}}
\def\department#1{\gdef\@department{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\newcommand{\titletext}[1]
{
  \ifthenelse{\equal{#1}{thesis}}{A thesis submitted to the University of Manchester for the degree of\ \linebreak Doctor of Philosophy\ \linebreak in the Faculty of \@faculty}{}
  \ifthenelse{\equal{#1}{first}}{Nine month progress report}{}
  \ifthenelse{\equal{#1}{second}}{End of second year report}{}
}
\def\maketitle{
  \begin{titlepage}
    \hypertarget{TitlePage}{}
    \bookmark[dest=TitlePage,level=-1]{Front matter}
	\phantomsection \pdfbookmark[chapter]{Title page}{title}
  
    % Add logo. No requirement for this, but is nice. Note sizes are hand calculated. Won't be correct if change paper size
    \pgfdeclareimage[width=\logowidth]{uom_logo}{uom_logo}
    \pgftext[at=\pgfpoint{-\marginleft+\logopad}{\margintop+\parskip-\logopad}, top, left]{\pgfuseimage{uom_logo}}

    \begin{center}
	  \vspace*{\fill}
      {\Large \bf \@title}
      \vskip 3cm
      \titletext{\reportyear}
      \vskip 3cm
	  \@submitdate
	  \vskip 3cm
	  \@author\ \linebreak
	  \@department
      \vspace*{\fill}
    \end{center}
	
  \end{titlepage}
  
  \pagenumbering{arabic}
  \setcounter{page}{2} % ensure no number on title page, numbers on other pages match those in the PDF
}
\makeatother  %to avoid error messages generated by "\@". Makes Latex treat "@" like a letter

%% Abstract
\renewenvironment{abstract}{%
  \clearpage\phantomsection\chapter*{Abstract}
}
{\addcontentsline{toc}{chapter}{\abstractname}\endquotation\vfil\null\clearpage}

% Word count command
\makeatletter
\newcommand{\wordcount}[1]{\newcommand{\@wordcount}{#1}}
\makeatother
\makeatletter\newcommand{\thewordcount}[0]{\@wordcount}\makeatother

%% Lists and tables of contents
\newcommand{\uomtoc}{
  \phantomsection\addcontentsline{toc}{chapter}{Contents}
  \tableofcontents
  \ifthenelse{\equal{\reportyear}{thesis}}{
    \vspace*{\fill}
    \begin{flushright}
      \textbf{Word count}: \thewordcount
    \end{flushright}
  }{}
  \clearpage
}

\newcommand{\uomlof}{
  \phantomsection\addcontentsline{toc}{chapter}{List of figures}
  \listoffigures
  \clearpage
  }  
\newcommand{\uomlot}{
  \phantomsection\addcontentsline{toc}{chapter}{List of tables}
  \listoftables
  \clearpage
  }    
\newenvironment{uomlop}{
  \phantomsection\addcontentsline{toc}{chapter}{List of publications}
  \chapter*{List of publications}
}
{\clearpage}
\newenvironment{uomterms}{
  \phantomsection\addcontentsline{toc}{chapter}{Terms and abbreviations}
  \chapter*{Terms and abbreviations}
}
{\clearpage}
\newenvironment{uomlay}{
  \phantomsection\addcontentsline{toc}{chapter}{Lay abstract}
  \chapter*{Lay abstract}
}
{\clearpage}

%% Declarations
\newcommand{\uomdeclarations}{
  \phantomsection\addcontentsline{toc}{chapter}{Declaration of originality}
  \chapter*{Declaration of originality}
  I hereby confirm that no portion of the work referred to in the thesis has been submitted in support of an application for another degree or qualification of this or any other university or other institute of learning.
  \clearpage
  
  \phantomsection\addcontentsline{toc}{chapter}{Copyright statement}
  \chapter*{Copyright statement} 
  \begin{enumerate}[label=\roman*]
    \item The author of this thesis (including any appendices and/or schedules to this thesis) owns certain copyright or related rights in it (the ``Copyright'') and s/he has given The University of Manchester certain rights to use such Copyright, including for administrative purposes.
    \item Copies of this thesis, either in full or in extracts and whether in hard or electronic copy, may be made \emph{only} in accordance with the Copyright, Designs and Patents Act 1988 (as amended) and regulations issued under it or, where appropriate, in accordance with licensing agreements which the University has from time to time. This page must form part of any such copies made.
    \item The ownership of certain Copyright, patents, designs, trademarks and other intellectual property (the ``Intellectual Property'') and any reproductions of copyright works in the thesis, for example graphs and tables (``Reproductions''), which may be described in this thesis, may not be owned by the author and may be owned by third parties. Such Intellectual Property and Reproductions cannot and must not be made available for use without the prior written permission of the owner(s) of the relevant Intellectual Property and/or Reproductions.
	\item Further information on the conditions under which disclosure, publication and commercialisation of this thesis, the Copyright and any Intellectual Property and/or Reproductions described in it may take place is available in the University IP Policy (see \url{http://documents.manchester.ac.uk/DocuInfo.aspx?DocID=24420}), in any relevant Thesis restriction declarations deposited in the University Library, The University Library’s regulations (see \url{http://www.library.manchester.ac.uk/about/regulations/}) and in The University’s policy on Presentation of Theses.
  \end{enumerate}
  \clearpage
}

%% List of thesis revisions  
\newenvironment{uomlotr}{
  \phantomsection\addcontentsline{toc}{chapter}{List of thesis revisions}
  \chapter*{List of thesis revisions}
  \bookmarksetup{startatroot}
}
{\clearpage}

%% Acknowledgements  
\newenvironment{uomacknowledgements}{
  \phantomsection\addcontentsline{toc}{chapter}{Acknowledgements}
  \chapter*{Acknowledgements}
  \bookmarksetup{startatroot}
}
{\clearpage}

%% The author  
\newenvironment{uomauthor}{
  \phantomsection\addcontentsline{toc}{chapter}{The author}
  \chapter*{The author}
  \bookmarksetup{startatroot}
}
{\clearpage}

%% Appendix
\newenvironment{uomappendix}{
  \clearpage
  \bookmarksetupnext{level=part}
  \phantomsection\addcontentsline{toc}{chapter}{Appendices}
  \addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
  \chapter*{Appendices} 
  \clearpage
  \renewcommand\chaptername{Appendix}
  \begin{appendices}
}
{\end{appendices}}