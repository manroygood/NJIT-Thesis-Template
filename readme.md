# NJIT DMS Dissertation / Thesis Template

This repository provides the official \LaTeX\ dissertation template and user's guide for the Department of Mathematical Sciences (DMS) at the New Jersey Institute of Technology (NJIT).

## Document History & Credits

- **2001:** Adrienne C. N. James (First Edition), Jerry Jen-Sou Chen, Eliana Antoniou
- **2002–2003:** Stephen A. Kunec, Hoa Kien Tran
- **2014:** Shoubhik Mondal
- **2022:** Prof. Roy Goodman, Dr. Jimmie Adriazola, Prof. Christina Frederick
- **2026:** Comprehensive overhaul of `dmsthesis.cls` and the sample guide to modernize the codebase for TeX Live 2024–2026+, fix local/Overleaf compilation, implement clean geometry margins and `setspace` line spacing, support both single and multiple appendices conforming to GSO guidelines, and demonstrate all class features.

---

## Features & Highlights

1. **Fully Conforming to NJIT GSO Guidelines:**
   - 1.5-inch left margin for binding; 1.0-inch top, bottom, and right margins via `geometry`.
   - Double line spacing for body text via `setspace`; automatic single spacing for footnotes, captions, tables, and front matter.
   - Standard NJIT front matter order: Abstract (unnumbered), Title page (roman i, unnumbered), Copyright (unnumbered), Approval page (unnumbered), Biographical Sketch (starts roman page numbers), Dedication, Acknowledgment.
   - Table of Contents with leader dots, correct column headers (`Chapter \hfill Page`), and safe multi-page continuation headers (`TABLE OF CONTENTS (Continued)`).
   - Dedicated List of Tables, List of Figures, List of Symbols, and Glossary of Terms.

2. **Automated Presentations and Publications in Biographical Sketch:**
   - The publications list in the **Biographical Sketch** is generated directly from `references.bib` using `biblatex` and `biber`.
   - Simply tag any of your publications with `keywords = {me}` in the `.bib` file, and they will be listed automatically in reverse chronological order.

3. **GSO-Compliant Appendix Numbering:**
   - **Single Appendix:** Use `\oneappendix{Title}` in `appendix.tex`. Formats as `APPENDIX` without a letter label, exactly as required by the GSO.
   - **Multiple Appendices:** Use `\appendix` followed by `\chapter{Title}` in `appendixA.tex`, `appendixB.tex`, etc. Formats automatically as `APPENDIX A`, `APPENDIX B`.

4. **Rich Feature Demonstrations:**
   - **Headings:** Chapters, sections, subsections, subsubsections, and run-in paragraphs.
   - **Mathematics & Theorems:** Built-in `amsmath`, `amssymb`, and `amsthm` environments (`theorem`, `lemma`, `proposition`, `corollary`, `definition`, `example`, `remark`, `proof`).
   - **Graphics & Subfigures:** Standard figures and subfigures with `subcaption`.
   - **Tables:** Standard floating tables with `tabularx` and footnotes.
   - **Landscape Pages:** Built-in `pdflscape` for wide tables and large figures that rotate the PDF page view for screen reading.
   - **List of Symbols & Glossary:** Clean environments for notation and terminology with automatic TOC integration.

---

## How to Compile

### Recommended (Local): `latexmk`
The quickest and most reliable way to compile locally:
```bash
latexmk -pdf main.tex
```
`latexmk` automatically manages dependencies, runs `biber` to resolve citations, and repeats `pdflatex` runs until all cross-references and page numbers converge.

### Manual Local Compilation
```bash
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

### Overleaf
1. Upload this repository as a ZIP archive to Overleaf.
2. In Overleaf Settings:
   - **Compiler:** `pdfLaTeX`
   - **TeX Live version:** `2024` (or latest available)
3. Set `main.tex` as the main document and click **Recompile**.

---

## Project Structure

```
├── dmsthesis.cls           # Main LaTeX document class file
├── main.tex                # Master document controller
├── packages.tex            # External package imports
├── macros.tex              # Mathematical macros and theorem environments
├── references.bib          # BibTeX citation database
├── Graphics/               # Directory for figures and illustrations
├── abstract.tex            # Abstract text
├── approval.tex            # Dissertation advisor and committee configuration
├── biography.tex           # Author details, degree titles, and degrees earned
├── dedication.tex          # Optional dedication
├── acknowledgment.tex      # Acknowledgments
├── listofsymbols.tex       # List of symbols and notation
├── listofdefinitions.tex   # Glossary of terms / technical definitions
├── preface.tex             # Optional preface
├── chapter1.tex            # Chapter 1: Document structure and guide
├── chapter2.tex            # Chapter 2: Formatting instructions and examples
├── appendix.tex            # Single appendix example (default)
├── appendixA.tex           # First appendix for multi-appendix setup
└── appendixB.tex           # Second appendix for multi-appendix setup
```

---

## Contributions & Pull Requests

Students and faculty who make improvements, add features, or update guidelines are encouraged to submit pull requests on GitHub so future students may benefit.
