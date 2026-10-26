# NJIT Thesis and Dissertation Template

A LaTeX template and user's guide for doctoral dissertations and master's theses at the New Jersey Institute of Technology (NJIT). It follows the formatting requirements of the NJIT Graduate Studies Office (GSO) as of October 2026: the GSO's 2025 Front Matter guide and the GSO's feedback on earlier versions of this template. The GSO's current guidelines and its reviewers have the final word; if they differ from the template, follow the GSO and please tell the maintainer (see [Contributing](#contributing)).

The sample document is itself the user's guide. A compiled copy, `main.pdf`, is attached to each release on the repository's [Releases page](https://github.com/manroygood/NJIT-Thesis-Template/releases).

---

## Start Here

1. Compile the sample without changing anything (see [How to Compile](#how-to-compile)) and check that you get the same PDF as the released copy.
2. In `biography.tex`, enter your title, name, degrees, and graduation date. In `approval.tex`, enter your advisor and committee.
3. Replace the sample text in `abstract.tex`, `acknowledgment.tex`, and `dedication.tex`.
4. Replace the text of `chapter1.tex` through `chapter5.tex` with your own chapters, and delete the sample appendices and other sample material (Section 1.2 of the sample lists what to delete).
5. Compile again after every few changes, so an error is easy to locate. Section 1.4 of the sample explains the most common errors.

For a master's thesis, use `\documentclass[12pt,thesis]{njit_thesis}` in `main.tex`.

## Requirements

- A LaTeX distribution from 2021 or later (TeX Live, MacTeX, or MiKTeX), because the template uses version 3 of `siunitx`. Overleaf works without any installation.
- A full installation includes every package the template needs. With a smaller one (BasicTeX, or `texlive-latex-base` on Linux), Appendix C.3 of the sample explains how to install missing packages.
- The `biber` program, for the bibliography. It is part of every full installation.

---

## Features

1. **GSO formatting, applied automatically**
   - 1.5-inch left margin; 1-inch top, bottom, and right margins.
   - Times font at 12 pt (`newtx`), for text and mathematics.
   - Body text double-spaced, including the abstract and acknowledgments, with 0.5-inch paragraph indents; headings, captions, tables, footnotes, lists, code, algorithms, and references single-spaced.
   - Front matter in the GSO's order: Abstract (unnumbered), Title Page (counts as i, unnumbered), Copyright Page (unnumbered; blank for a master's thesis), Approval Page (unnumbered), Biographical Sketch (first page number shown, iv), Dedication (optional), Acknowledgments, Table of Contents, List of Tables, List of Figures, List of Algorithms (optional), List of Symbols (optional), Glossary of Terms (optional).
   - Table of Contents starting at Chapter 1, with dot leaders and "(Continued)" headers on later pages.
   - References right after the last chapter, before all of the appendices, and an optional last appendix that lists supplementary files uploaded to ProQuest (`supplementary.tex`).
   - Five numbered heading levels, with one blank line above each level 2 heading and none above levels 3 to 5; untitled headings stop the build, and unnumbered ones are flagged.
   - Captions with a bold label and no colon, table titles above and figure captions below, numbered by chapter. `\floatsource{...}` puts the source of a borrowed figure, table, or algorithm on a single-spaced 10 pt line below it, where it stays out of the lists. Floats are placed with `[htbp]` by default, and `\tablecontinued` gives a table that runs over several pages a bold "Table X.x (Continued)" title on each later page.

2. **Information entered once.** The title, name, degree, and date are set in `biography.tex` and printed on the abstract, title, copyright, approval, and biography pages, so the pages cannot disagree. The title and author are also written into the PDF's document properties.

3. **Presentations and publications from your bibliography.** Tag your own entries in `references.bib` with `keywords = {me}`, and they are listed in the Biographical Sketch, newest first.

4. **Appendices labeled the GSO's way.** One appendix (`\oneappendix{Title}` in `appendix.tex`) is labeled APPENDIX with no letter; several (`\chapter{Title}` in `appendixA.tex`, `appendixB.tex`, ...) are labeled APPENDIX A, APPENDIX B, and so on.

5. **A sample that teaches.** The sample demonstrates every heading level, theorem environments, numbered equations, figures and subfigures, `booktabs` and grid tables, a landscape table, a table that runs over several pages, code listings, numbered algorithms with a List of Algorithms, units with `siunitx`, footnotes, cross-references with `cleveref`, and a two-column List of Symbols and Glossary of Terms. It also covers exporting plots from MATLAB, Mathematica, and Python, permission to reuse figures, choosing a citation style, and a checklist of the problems that most often cause the GSO to return a document.

---

## How to Compile

### `latexmk` (recommended)

```bash
latexmk -pdf main.tex
```

`latexmk` runs `pdflatex` and `biber` as many times as needed for the citations, cross-references, and page numbers to settle.

### Manual compilation

```bash
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

### Overleaf

1. Download this repository as a ZIP file and upload it to Overleaf with **New Project**, then **Upload Project**.
2. In the project's **Menu**, set the compiler to **pdfLaTeX** and the main document to `main.tex`.
3. Overleaf normally detects that the bibliography uses Biber. If the references show as "??", choose **Biber** in the bibliography setting.

### TeXShop, TeXstudio, and VS Code

Every `.tex` file starts with `% !TEX root = main.tex`, which tells TeXShop (and several other editors) to compile `main.tex` whichever file is open. Keep this line in every file, including new ones. `main.tex` also has `% !TEX TS-program = pdflatexmk`, which makes TeXShop compile with `latexmk`. In other editors, choose pdfLaTeX and Biber, or `latexmk`.

---

## Project Structure

```
├── readme.md               # This file
├── LICENSE                 # LaTeX Project Public License notice
├── njit_thesis.cls         # Class file: the NJIT formatting rules
├── main.tex                # Master file; compile this one
├── packages.tex            # Packages and citation style
├── njit-acm.bbx, .cbx      # ACM citation style (biblatex has none)
├── njit-aip.bbx, .cbx      # AIP citation style
├── njit-ama.bbx, .cbx      # AMA citation style
├── njit-asce.bbx, .cbx     # ASCE citation style (author-year)
├── njit-harvard.bbx, .cbx  # Harvard style, titles in sentence case
├── njit-trb.bbx, .cbx      # TRB citation style (author-year)
├── njit-vancouver.bbx, .cbx # Vancouver style, sentence case, commas between authors
├── macros.tex              # Your notation and theorem environments
├── references.bib          # Bibliography database
├── abstract.tex            # Abstract text
├── approval.tex            # Advisor and committee
├── biography.tex           # Title, name, degrees, and graduation date
├── dedication.tex          # Optional dedication
├── acknowledgment.tex      # Acknowledgments
├── listofsymbols.tex       # List of Symbols
├── listofdefinitions.tex   # Glossary of Terms
├── chapter1.tex            # Chapter 1: getting started
├── chapter2.tex            # Chapter 2: what the GSO requires
├── table.tex               # Sample table, \input by chapter2.tex
├── chapter3.tex            # Chapter 3: writing the text
├── chapter4.tex            # Chapter 4: figures and tables
├── chapter5.tex            # Chapter 5: references and submission
├── appendixA.tex           # Appendix A: how appendices work (several appendices)
├── appendixB.tex           # Appendix B: citation style guides
├── appendixC.tex           # Appendix C: the packages and their options
├── appendixD.tex           # Appendix D: the template's files
├── appendix.tex            # Alternative: a single appendix (see main.tex)
├── supplementary.tex       # Last appendix: list of supplementary files
├── appendix-rules.tex      # Shared text, \input by appendix.tex and appendixA.tex
├── appendix-demo.tex       # Shared equations, figures, and table, \input by the same two
├── Graphics/               # Images for the figures
└── citation-styles/        # Pages of Appendix B: every citation style on the same sources
```

---

## History

Students and faculty of the NJIT Department of Mathematical Sciences have built and revised this template:

- **2001:** Adrienne C. N. James (first edition), Jerry Jen-Sou Chen, Eliana Antoniou
- **2002–2003:** Stephen A. Kunec, Hoa Kien Tran
- **2014:** Shoubhik Mondal
- **2022:** Prof. Roy Goodman, Dr. Jimmie Adriazola, Prof. Christina Frederick
- **2026:** Prof. Roy Goodman, with help from Claude: a rewritten class file that follows the GSO's current rules, support for master's theses, and a sample document rewritten as a guide for students in every program. Ester Flaim of the Graduate Studies Office contributed to and edited this revision

## Contributing

Maintainer: Prof. Roy Goodman (goodman@njit.edu). If you find a mistake, learn that the GSO has changed a rule, or work out how to handle something the template does not cover, please send a pull request to [github.com/manroygood/NJIT-Thesis-Template](https://github.com/manroygood/NJIT-Thesis-Template) or email a suggestion. Contributors are credited in the history above and at the top of `njit_thesis.cls`.

## License

The class file `njit_thesis.cls` is distributed under the [LaTeX Project Public License](https://www.latex-project.org/lppl/), version 1.3c or later; see `LICENSE`. The sample files are meant to be copied and changed: you may use them, with or without changes, for your own thesis or dissertation without restriction.
