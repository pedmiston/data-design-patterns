<img src="https://github.com/pedmiston/data-design-patterns/raw/master/img/platypus.jpg" align="left" width="100">

# Design patterns for data projects

When starting new data projects, what's the best way to design your project to minimize growing pains and maximize reuse? This project highlights a few design patterns I've found useful and reusable across a variety of data projects.

## Getting started

* **For an overview**, compile the presentation by opening "overview.Rpres"
  in RStudio.
* **To learn more about specific design patterns**, check out the READMEs in
  each design pattern directory.

## Design patterns

1. **Egg projects**. A useful configuration of R packages and RStudio
   projects.
2. **Parallel reports**. The parallelization of code and report writing for
   improved interactive development.
3. **Green stats**. Result sections in knitr. Could save your life!
4. **Merge recode**. Authoritative recoder functions.
5. **DRY plots**. A small pattern for not repeating yourself when making
   plots using ggplot.

## Example data projects

The sample projects are stored in git submodules, i.e., they
link to other repos. After cloning the repo, they must be
initialized and updated:

```bash
git submodule init && git submodule update
```

1. **github-pulse** is a project I made up mainly to demonstrates each of the design patterns in action. The project pulls freely available Github event data from [githubarchive](https://githubarchive.org) and analyzes it in R. This sample project demonstrates the value of data design patterns in facilitating the growth of a data project from exploratory analyses to final reports.
2. **property-verification** is a cognitive psychology experiment set up as a data project. The data in this project can be used to demonstrate how to write **parallel reports** and **DRY plots** that grow gracefully from exploratory analyses to final reports.
3. **wikischolar** is an ongoing research project interested in measuring changes in Wikipedia article quality over time. The process of obtaining the data is more elaborate and is contained in a python library, yet the benefits to using the data design patterns is the same.

## Description

Design patterns in the traditional software development sense are configurations of program components that solve problems that will likely crop up in the future but may not be immediately obvious at the beginning of a project. Design patterns involve some upfront cost but they make development easier and more sustainable in the long run by outsourcing design decisions to the design pattern itself. This repo does not contain formal design patterns but the term captures my philosophy in approaching data projects: that data projects should be structured in a way that makes them reproducible and reusable while allowing them to grow smoothly from initial hypotheses to publication-ready results.

Data projects lie somewhere between the analysis of a single data set and continuous analytics pipelines (big data). Data projects are extremely important for scientific experiments and empirical analysis. I believe that all experiments can and should be implemented as data projects to facilitate reproducibility and replicability. A developer perspective on data projects and data design patterns is that they allow for agile data science where iteration and incremental development is key.

## History

- July 20, 2016: Madison R Users Group <http://www.meetup.com/MadR-Madison-R-Programming-UseRs-Group/events/230575960/>.
- Sept. 16, 2016: Curtin Addiction Research Lab
