\documentclass[a4paper,9pt]{article}
\usepackage{enumitem}
\usepackage{geometry}
\geometry{top=0.5in, bottom=0.5in, left=0.5in, right=0.5in} % Reduced margins for more space
\setlength{\parskip}{0pt} % Removes space between paragraphs
\setlength{\parindent}{0pt} % Removes indentation for paragraphs
\usepackage{titlesec} % for customizing section titles
\usepackage{tabularx} % for making tables with fixed width columns
\usepackage{array} % tabularx requires this
\usepackage[dvipsnames]{xcolor} % for coloring text
\usepackage{fontawesome5} % for using icons
\usepackage{amsmath} % for math
\usepackage{eso-pic} % for floating text on the page
\usepackage{calc} % for calculating lengths
\usepackage{bookmark} % for bookmarks
\usepackage{lastpage} % for getting the total number of pages
\usepackage{changepage} % for one column entries (adjustwidth environment)
\usepackage{paracol} % for two and three column entries
\usepackage{ifthen} % for conditional statements
\usepackage{needspace} % for avoiding page break right after the section title
\usepackage{iftex} % check if engine is pdflatex, xetex or luatex

% Ensure that generate pdf is machine readable/ATS parsable:
\ifPDFTeX
    \input{glyphtounicode}
    \pdfgentounicode=1
    \usepackage[T1]{fontenc}
    \usepackage[utf8]{inputenc}
    \usepackage{lmodern}
\fi

\begin{document} % Ensure this line is present

% Some settings:
\AtBeginEnvironment{adjustwidth}{\partopsep0pt} % remove space before adjustwidth environment
\setcounter{secnumdepth}{0} % no section numbering
\setlength{\topskip}{0pt} % no top skip
\setlength{\columnsep}{0.5cm} % set column separation
\makeatletter
\let\ps@customFooterStyle\ps@plain % Copy the plain style to customFooterStyle
\patchcmd{\ps@customFooterStyle}{\thepage}{
    \color{gray}\textit{\small Daniel Makana Raini - Page \thepage{} of \pageref*{LastPage}}
}{}{} % replace number by desired string
\makeatother

\titleformat{\section}[
    % avoid page breaking right after the section title
    \needspace{3\baselineskip}
]{
    % make the font size of the section title large and color it with the primary color
    \normalsize\color{primaryColor}
}{
    % This is the label format (empty in this case)
}{}{
    % print bold title, give 0.1 cm space and draw a line of 0.5 pt thickness
    % from the end of the title to the end of the body
    \textbf{#1}\hspace{0.1cm}\titlerule[0.5pt]\hspace{-0.1cm}
} // section title formatting

\titlespacing{\section}{
    // left space:
    -1pt
}{
    // top space:
    0.1 cm
}{
    // bottom space:
    0.05 cm
} // section title spacing

// \renewcommand\labelitemi{$\vcenter{\hbox{\small$\bullet$}}$} // custom bullet points
\newenvironment{highlights}{
    \begin{itemize}[
        topsep=0.03 cm,
        parsep=0.03 cm,
        partopsep=0pt,
        itemsep=0pt,
        leftmargin=0.2 cm + 10pt
    ]
}{
    \end{itemize}
} // new environment for highlights

\newenvironment{highlightsforbulletentries}{
    \begin{itemize}[
        topsep=0.03 cm,
        parsep=0.03 cm,
        partopsep=0pt,
        itemsep=0pt,
        leftmargin=10pt
    ]
}{
    \end{itemize}
} // new environment for highlights for bullet entries


\newenvironment{onecolentry}{
    \begin{adjustwidth}{
        0.05 cm + 0.00001 cm
    }{
        0.05 cm + 0.00001 cm
    }
}{
    \end{adjustwidth}
} // new environment for one column entries

\newenvironment{twocolentry}[2][]{
    \onecolentry
    \def\secondColumn{#2}
    \begin{paracol}{2}
}{
    \switchcolumn \raggedleft \secondColumn
    \end{paracol}
    \endonecolentry
} // new environment for two column entries

\newenvironment{threecolentry}[3][]{
    \onecolentry
    \def\thirdColumn{#3}
    \setcolumnwidth{0.6 cm, \fill, 3.5 cm}
    \begin{paracol}{3}
    {\raggedright #2} \switchcolumn
}{
    \switchcolumn \raggedleft \thirdColumn
    \end{paracol}
    \endonecolentry
} // new environment for three column entries

\newenvironment{header}{
    \setlength{\topsep}{0pt}\par\kern\topsep\centering\color{primaryColor}\linespread{1.1}
}{
    \par\kern\topsep
} // new environment for the header

\newcommand{\placelastupdatedtext}{% \placetextbox{<horizontal pos>}{<vertical pos>}{<stuff>}
  \AddToShipoutPictureFG*{% Add <stuff> to current page foreground
    \put(
        \LenToUnit{\paperwidth-1.2 cm-0.2 cm+0.05cm},
        \LenToUnit{\paperheight-0.6 cm}
    ){\vtop{{\null}\makebox[0pt][c]{
        \scriptsize\color{gray}\textit{Last updated in September 2024}\hspace{\widthof{Last updated in September 2024}}
    }}}%
  }%
}%

// save the original href command in a new command:
\let\hrefWithoutArrow\href

// new command for external links:
\renewcommand{\href}[2]{\hrefWithoutArrow{#1}{\ifthenelse{\equal{#2}{}}{ }{#2 }\raisebox{.1ex}{\scriptsize \faExternalLink*}}}

\begin{document}

\newcommand{\AND}{\unskip
    \cleaders\copy\ANDbox\hskip\wd\ANDbox
    \ignorespaces
}
\newsavebox\ANDbox
\sbox\ANDbox{}

\placelastupdatedtext
\begin{paracol}[1.5]{2}
    \begin{leftcolumn}
        \begin{header}
            \fontsize{18 pt}{18 pt}
            \textbf{Daniel Makana Raini}

            \vspace{0.1 cm}

            \small
            \mbox{{\scriptsize\faMapMarker*}\hspace*{0.08cm}Nairobi, Kenya}%
            \kern 0.15 cm%
            \AND%
            \kern 0.15 cm%
            \mbox{\hrefWithoutArrow{mailto:danielraini871@gmail.com}{{\scriptsize\faEnvelope[regular]}\hspace*{0.08cm}danielraini871@gmail.com}}%
            \kern 0.15 cm%
            \AND%
            \kern 0.15 cm%
            \mbox{\hrefWithoutArrow{tel:+254-795-888-350}{{\scriptsize\faPhone*}\hspace*{0.08cm}+254 795 888 350}}%
        \end{header}

        \vspace{0.1 cm - 0.1 cm}

        \section*{Professional Summary}
        A proactive and detail-oriented Electrical and Electronics Engineering student at the University of Nairobi, with expertise in circuit design, renewable energy systems, technical documentation, and graphical design. Demonstrated leadership as the chairperson of the SDA group and a proven ability to contribute to academic resources by rewriting class notes for enhanced learning. Knowledgeable in advanced concepts of microwaves and antennas, complemented by skills in typesetting with LaTeX, Markdown, and Pandoc. Expected to graduate in September 2025.

        \section*{Education}
        \begin{onecolentry}
            \textbf{Bachelor of Science in Electrical and Electronics Engineering} \\
            \textbf{Institution:} University of Nairobi \\
            \textbf{Expected Graduation:} September 2025 \\
            \textbf{Notable Coursework:} Circuit Theory, Power Systems, Digital Signal Processing, Microwaves and Antennas, Renewable Energy Systems \\
        \end{onecolentry}

        \section*{Skills}
        \begin{highlights}
            \item \textbf{Programming languages:} C, Python, MATLAB
            \item \textbf{Circuit design and simulation:} Proteus, LTSpice
            \item \textbf{PCB design tools:} KiCad, Altium Designer
            \item \textbf{Expertise in microwaves and antennas}
            \item \textbf{Typesetting and document preparation:} LaTeX, Markdown, Pandoc
            \item \textbf{Graphic design:} Proficient in Adobe Illustrator, Photoshop, CorelDraw
            \item \textbf{Analytical problem-solving and technical writing}
        \end{highlights}

        \section*{Projects}
        \begin{onecolentry}
            \textbf{Final Year Project: Solar Powered Low Cost Cargo Delivery Drone} \\
            Developing an innovative drone system powered by solar energy, designed for low-cost cargo delivery in remote areas. The project integrates renewable energy solutions with advanced drone technologies for sustainable transportation. \\
        \end{onecolentry}

        \begin{onecolentry}
            \textbf{Climate Resilient Agricultural Planning Tool} (IBM Call for Code Global Challenge 2024) \\
            Designed and developed a digital tool to assist farmers in adapting to climate change by integrating predictive analytics and real-time environmental data for improved planning and sustainability. \\
        \end{onecolentry}

        \begin{onecolentry}
            \textbf{Smart Home Automation System} \\
            Designed and implemented an IoT-based home automation system using sensors for energy efficiency and remote control. \\
        \end{onecolentry}

        \begin{onecolentry}
            \textbf{Solar Power Optimization} \\
            Developed a simulation model to optimize the efficiency of solar panels using MATLAB and Simulink. \\
        \end{onecolentry}

        \begin{onecolentry}
            \textbf{Power Management and Control Panel for Paper Making Machine} \\
            Developed and simulated a power management and control panel for a paper-making machine, focusing on energy efficiency, load distribution, and system monitoring. \\
        \end{onecolentry}
    \end{leftcolumn}

    \begin{rightcolumn}
        \section*{Academic Contributions}
        \begin{onecolentry}
            Rewritten the \textbf{Applied Electronics Class Notes} for the 5th-year Electrical Engineering class of 2025, using LaTeX and Pandoc to produce a clear, professional, and accessible resource for peers. \\
        \end{onecolentry}

        \section*{Leadership \& Extracurricular Activities}
        \begin{onecolentry}
            \textbf{Chairperson, SDA Group, University of Nairobi} \\
            Successfully led a vibrant group of students, organizing events, fostering community engagement, and mentoring peers. \\
        \end{onecolentry}

        \begin{onecolentry}
            \textbf{Active Member, University Chess Club} \\
            Participates in chess tournaments and contributes to team strategies, enhancing critical thinking and problem-solving skills. \\
        \end{onecolentry}

        \begin{onecolentry}
            \textbf{Choir Member, Advent Harmony Choir} \\
            Performs as part of a dynamic choral group, showcasing teamwork and commitment to artistic excellence. \\
        \end{onecolentry}

        \begin{onecolentry}
            Active member of the \textbf{IEEE Student Chapter} at the University of Nairobi. \\
            Volunteer at local STEM outreach programs, mentoring high school students interested in engineering. \\
        \end{onecolentry}

        \begin{onecolentry}
            \textbf{Participant, Company Series Program} organized by the Government of France \\
            Participates in an international professional development program, gaining exposure to global business practices and industry insights. \\
        \end{onecolentry}

        \section*{Languages}
        \begin{highlights}
            \item English (Fluent)
            \item Swahili (Fluent)
        \end{highlights}

        \section*{Interests}
        \begin{highlights}
            \item Renewable energy innovation
            \item Microwaves and antenna design
            \item Typesetting and document design
            \item Graphic design
            \item Chess and strategic games
            \item Choral and vocal music
        \end{highlights}

        \section*{Referees}
        \begin{onecolentry}
            \textbf{Eng. Nabil Mohammed, M.Sc} \\
            Assistant Projects Manager, Central Electricals International Limited (CEIL) \\
            nabil@centralelectricals.com \\
        \end{onecolentry}

        \begin{onecolentry}
            \textbf{Mr. Daniel Odhiambo} \\
            Assistant Registrar, Faculty of Arts and Social Sciences, University of Nairobi \\
            +254 722 921486 \\
        \end{onecolentry}
    \end{rightcolumn}
\end{paracol>

\end{document}