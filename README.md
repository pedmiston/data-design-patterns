# Design patterns for data projects

When starting new data projects, what's the best way to design your project to minimize growing pains and maximize reuse? This project highlights a few design patterns I've found useful and reusable across a variety of data projects.

Design patterns in the traditional software development sense are configurations of program components that solve problems that will likely crop up in the future but may not be immediately obvious at the beginning of a project. Design patterns involve some upfront cost but they make development easier and more sustainable in the long run by outsourcing design decisions to the design pattern itself. This repo does not contain formal design patterns but the term captures my philosophy in approaching data projects: that data projects should be structured in a way that makes them reproducible and reusable while allowing them to grow smoothly from initial hypotheses to publication-ready results.

Data projects lie somewhere between the analysis of a single data set and continuous analytics pipelines (big data). Data projects are extremely important for scientific experiments and empirical analysis. I believe that all experiments can and should be implemented as data projects to facilitate reproducibility and replicability. A developer perspective on data projects and data design patterns is that they allow for agile data science where iteration and incremental development is key.

I will be introducing these data design patterns, including the motivations for them and some example projects that implement them, at the MadR - Madison R Programming UseRs Group MeetUp on July 20, 2016 <http://www.meetup.com/MadR-Madison-R-Programming-UseRs-Group/events/230575960/>.

## Design patterns

1. **Egg Projects**: A useful configuration of R packages and RStudio projects
   to facilitate reproducible and reusable data projects.
2. **Parallel Reports**: The parallelization of code and report writing for
   improved interactive development.
3. **Plot Skins**: A small pattern for getting the most out of ggplot.
