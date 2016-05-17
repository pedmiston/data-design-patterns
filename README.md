# Design patterns for data projects

When starting new data projects, what's the best way to design your project to minimize growing pains and maximize reuse? This project highlights a few design patterns I've found useful and more importantly reusable across very different sorts of data projects.

Design patterns in traditional software development are configurations of system components that solve problems that may not be immediately relevant to the system designers. Design patterns involve some upfront cost but they make development easier and more sustainable in the long run. This project does not contain form design patterns but the term captures my philosophy in approaching data projects: that all data projects should be built to change.

Data projects are somewhere between once-off data sets and continuous data pipelines. Data projects are extremely important for scientific experiments. All experiments can and should be implemented as data projects to facilitate reproducibility and replicability. The more practical benefit to data design patterns is that they allow data projects to grow gracefully from hypothesis to final reports.

## Outline

1. **Egg Projects**: A useful configuration of R packages and RStudio projects
   to facilitate reproducible and reusable data projects.
2. **Parallel Reports**: The parallelization of code and report writing for
   improved interactive development.
3. **Plot Skins**: A small pattern for getting the most out of ggplot.
