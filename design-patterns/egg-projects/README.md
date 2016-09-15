![Egg projects](/design-patterns/egg-projects/egg-projects.png)

An **egg project** is a design pattern for data science projects in R. An egg project is a data project directory that contains an R pkg (the "egg"). Data is collected and put into the egg. All analyses related to the project start by loading the data via the package, and not by loading plaintext data files.

## Description

* **Intent**. Confidently recreate stats and plots as projects change.
* **Scenario**. An experiment has been conducted and the results are ready to
  analyze. The results might be presented in lab talks, conference talks, and
  journal articles, all while more results are in and newer analyses run. What's
  the best way to ensure that stats and plots can always be recreated in all of
  these different contexts?
* **Solution**. Load the results of an experiment through an R pkg (the "egg")
  rather than through plaintext data files.

## Creating a new egg project

To create a new data project called `my-proj`, first create the `my-proj`
directory:

```bash
mkdir my-proj && cd my-proj
```

Then create a basic R project config file. You can do this from
RStudio, but a quick command line hack is to create an Rproj
file with the line "Version: 1.0" in it. When you open the file
with RStudio, it will fill in the remaining defaults:

```bash
echo "Version: 1.0" > analysis.Rproj
```

This R project "analysis.Rproj" is the entry point to the data project. Every time you work on this project you start by opening up "analysis.Rproj" in RStudio.

After opening our R project, one of the first things you need to do is load the data you will be analyzing and visualizing. Usually we'd do this with a call to `read.csv` or equivalent:

```R
read.csv("data/experiment.csv")
# ... describe data, fit models, make plots
```

For this design pattern, however, we will replace the reading of raw data files with the loading of an R package:

```R
library(projdata)  # load the egg
data("experiment")
# ... describe data, fit models, make plots
```

The goal of egg projects is to make any analyses that use these data to be portable, to be able to be run from anywhere without hardcoding paths to specific csvs, by using R's package loading system.

At the beginning these R packages are nothing more than wrappers around raw data files. But the benefit to bundling your data in an R package to start is that it is makes it easy to bundle in helper functions for recoding certain variables and formatting functions for presenting the results of statistical tests in a consistent way down the road.

**Notice that there are two things that need to be named**: the data project (`my-proj`) and the R pkg (`projdata`). These can be the same name, but keep in mind that R packages have a strict naming scheme: one word, all lower case, no separators like dashes or underscores.

To do this, the next step is to create the R pkg that we will use to store
the data for this project. The devtools package makes it very easy to make
the simplest possible R pkg from a template with the `create` function.

```R
devtools::create("projdata")
```

The end result has a directory structure like so:

    .
    └── my-proj
        ├── analysis.Rproj
        └── projdata
            ├── DESCRIPTION
            ├── NAMESPACE
            ├── R
            └── projdata.Rproj

    3 directories, 5 files

## Optional automation: newegg

Project templates naturally lend themselves to automation. Here's one using [cookiecutter](https://drivendata.github.io/cookiecutter-data-science/). Here's one built in R: [ProjectTemplate](http://projecttemplate.net/index.html). I've found it's often much simpler to just write a bash script:

```bash
touch newegg     # create an empty file "newegg"
chmod +x newegg  # make it executable
```

```bash
#!/usr/bin/env bash
# newegg [projname] [pkgname] -- create a new egg project.
projname=$1
pkgname=$2
mkdir $projname
cd $projname
echo "Version: 1.0" > analysis.Rproj
Rscript -e "devtools::create('$pkgname')"
cd ..
```

Use it like this:

```bash
newegg my-proj projdata
```

    $ tree my-proj
    .
    └── my-proj
        ├── analysis.Rproj
        └── projdata
            ├── DESCRIPTION
            ├── NAMESPACE
            ├── R
            └── projdata.Rproj

    3 directories, 5 files

## Getting the data

**A data project is not a dataset.** One implication of this is that getting the data should be automated as much as possible. Even if getting the data is as simple as downloading it with a URL, it's best practice to script it. One reason for this is that it allows you to create egg projects around data that is too big to store in the repository. Instead what is stored is the code to get the data.

Here's a simple bash script for downloading a dataset from the [Data is Plural](https://tinyletter.com/data-is-plural) newsletter.

```bash
#!/usr/bin/env bash
# usage: getdata
curl http://www.faa.gov/about/initiatives/lasers/laws/media/laser_incidents_2010-2014.xls -o projdata/data-raw/laser_incidents_2010-2014.xls
```

After running the `getdata` script, here is what the project looks like:

    my-proj/$ ./getdata
    my-proj/$ tree
    .
    ├── analysis.Rproj
    ├── getdata
    └── projdata
        ├── DESCRIPTION
        ├── NAMESPACE
        ├── R
        ├── data-raw
        │   └── laser_incidents_2010-2014.xls
        └── projdata.Rproj

    2 directories, 5 files

## Using the data

The way to share data in an R pkg is through .rda files stored in the package's data directory. I like to create an .R script that reads the raw data files and uses the devtools function ``use_data`` to save the data in the correct format:

```R
# data-raw/save-as.R
library(readxl)
library(devtools)
laser_incidents <- read_excel("data-raw/laser_incidents_2010-2014.xls")
use_data(laser_incidents)
```

After running this script, the raw data was compiled to .rda format and is ready
to be loaded with the `data(...)` function.

    my-proj/$ tree
    .
    ├── analysis.Rproj
    ├── getdata
    └── projdata
        ├── DESCRIPTION
        ├── NAMESPACE
        ├── data
        │   └── laser_incidents.rda
        ├── data-raw
        |   ├── laser_incidents_2010-2014.xls
        │   └── save-as.R
        └── projdata.Rproj

To load the data, first load the package `projdata`, which makes all .rda files
in the project's "data/" directory available for loading. Since we haven't installed the package yet, we can't use `library(projdata)`, but devtools has a function `load_all(...)` for loading packages into the current session without installing them for future use.

```R
devtools::load_all("projdata")
data("laser_incidents")
```

Now you can create reports that use the data in the root directory:

    my-proj/$ tree -L 1
    .
    ├── analysis.Rproj
    ├── getdata
    ├── projdata
    └── report.Rmd      # in same directory as R project and R pkg

At some point, the number of reports usually increases, and keeping reports in the root project directory is not always feasible. I usually end up keeping reports in a separate directory, like in this sample project:

    data-design-patterns/$ tree sample-projects/property-verification/reports/ -L 1
    sample-projects/property-verification/reports/
    ├── amount_of_knowledge
    ├── confounds
    ├── knowledge_type
    ├── norms
    ├── outliers
    ├── rts
    └── supplemental

    7 directories, 0 files

The problem with storing reports in nested directories is that the `devtools::load_all` function uses a relative path, which causes problems when compiling knitr reports from within RStudio. To fix this problem, we have to switch from loading the package using a relative path to installing the package and loading the package in the standard way:

```R
devtools::install("projdata")
library(projdata)
data("laser_incidents")
```

## Automation

At this point, there are a few commands run from the command line that are undocumented **and thus unrepeatable**. One solution is to create your own bin of bash scripts:

    my-proj/$ tree
    .
    ├── analysis.Rproj
    ├── bin
    │   ├── getdata  # download data to data-raw
    │   ├── usedata  # read the data and save as .rda
    │   └── install  # install the package with the data
    ├── ...

    my-proj/$ bin/getdata && bin/usedata && bin/install  # reproducible!

If simple bash scripts start getting out of hand, there are a number of other solutions:

- [make](https://www.gnu.org/software/make/). The original.
- [rake](http://docs.seattlerb.org/rake/). make for Ruby.
- [invoke](http://pyinvoke.org). make for python.

## Sharing the data

If you are sharing your data project, its essential that you
use version control to avoid profound headaches down the road.
Luckily we only need to know a few `git` commands to get started:

```bash
pwd  # my-proj/
git init
git add .
git commit -m "Initial commit for my-proj"
```

The only manual step is to create a destination repo on github,
bitbucket, gitlab, etc. Here I've created a repo on github, and
am adding a remote branch for my project:

```bash
git remote add origin https://github.com/pedmiston/my-proj.git
git push -u origin master
```

Now anyone can clone the whole data project with git:

```bash
colleague/$ git clone https://github.com/pedmiston/my-proj.git
```

In order to use the data in R, they could load the projdata
package locally:

```R
# in my-proj/
devtools::load_all("projdata")
```

If they just want the data, assuming the data is included in the git repository, they can install the projdata package
within the github repo using `devtools::install_github` with the subdir argument:

```R
devtools::install_github("pedmiston/my-proj", subdir = "projdata")
library(projdata)
```
