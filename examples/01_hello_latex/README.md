# Example 1: hello_latex

## Example Description
Any good tutorials for a programming language starts with a Hello World example
to demonstrate how to write code that displays a `Hello World!` message.

Since we can treat TeX as essentially a computer language that gets *compiled*
into a pdf document, we can make our own Hello World example.

### File Structure
```
├── hello_latex.tex         -- this is the main TeX file that gets converted into a pdf document
├── output                  -- this directory holds all files involved in *compiling* the TeX
│   ├── hello_latex.aux     -- an intermediate file generated before the final pdf
│   ├── hello_latex.log     -- a log created during compilation
│   └── hello_latex.pdf     -- the output hello_latex pdf document that was generated
└── README.md

```
