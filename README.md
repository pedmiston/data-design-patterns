# Design patterns for data projects

When starting new data projects, what's the best way to design your project to minimize growing pains and maximize reuse? This project highlights a few design patterns I've found useful and reusable across a variety of data projects.

## Getting started

* **For an overview**, see "overview.html" or compile the presentation yourself
  from markdown by opening "overview.Pres" in RStudio.
* **To learn more about specific design patterns**, check out the READMEs in
  the directory for each design pattern.

## Design patterns

1. **Egg Projects**: A useful configuration of R packages and RStudio
   projects.
2. **Parallel Reports**: The parallelization of code and report writing for
   improved interactive development.
3. **DRY Plots**: A small pattern for not repeating yourself when making plots
   using ggplot.

## Sample projects

### github-pulse

`github-pulse` is a sample project that demonstrates each of the design patterns in action. The project pulls freely available Github event data from [githubarchive](https://githubarchive.org) and analyzes it in R. This sample project demonstrates the value of data design patterns in facilitating the growth of a data project from exploratory analyses to final reports.

### property-verification

`property-verification` is a cognitive psychology experiment set up as a data project. The data in this project can be used to demonstrate how to write **parallel reports** and **DRY plots** that grow gracefully from exploratory analyses to final reports.

### wikischolar

`wikischolar` is an ongoing research project of mine interested in measuring changes in Wikipedia article quality over time. The process of obtaining the data is more elaborate and is contained in a python library, yet the benefits to using the data design patterns is the same.

## Description

Design patterns in the traditional software development sense are configurations of program components that solve problems that will likely crop up in the future but may not be immediately obvious at the beginning of a project. Design patterns involve some upfront cost but they make development easier and more sustainable in the long run by outsourcing design decisions to the design pattern itself. This repo does not contain formal design patterns but the term captures my philosophy in approaching data projects: that data projects should be structured in a way that makes them reproducible and reusable while allowing them to grow smoothly from initial hypotheses to publication-ready results.

Data projects lie somewhere between the analysis of a single data set and continuous analytics pipelines (big data). Data projects are extremely important for scientific experiments and empirical analysis. I believe that all experiments can and should be implemented as data projects to facilitate reproducibility and replicability. A developer perspective on data projects and data design patterns is that they allow for agile data science where iteration and incremental development is key.

I will be introducing these data design patterns, including the motivations for them and some example projects that implement them, at the MadR - Madison R Programming UseRs Group MeetUp on July 20, 2016 <http://www.meetup.com/MadR-Madison-R-Programming-UseRs-Group/events/230575960/>.
