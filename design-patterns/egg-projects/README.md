# Egg projects

A design pattern for data science in R.

![Egg projects](/design-patterns/egg-projects/egg-projects.png)

## Creating a new egg project

To create a new project called `my-proj`, first create the `my-proj`
directory:

    $ mkdir my-proj && cd my-proj

Then create a basic R project config file. You can do this from
RStudio, but a quick command line hack is to create an Rproj
file with the line "Version: 1.0" in it. When you open the file
with RStudio, it will fill in the remaining defaults:

    $ echo "Version: 1.0" > analysis.Rproj

This R project "analysis.Rproj" is the entry point to the data project. Every time you work on this project you start by opening up "analysis.Rproj" in RStudio.

After opening our R project, one of the first things you need to do is load the data you will be analyzing and visualizing. Usually we'd do this with a call to `read.csv` or equivalent:

    > read.csv("data/projdata.csv")
    > # ... describe data, fit models, make plots

For this design pattern, however, we will replace the reading of raw data files with the loading of an R package:

    > library(proj)
    > data("projdata")
    > # ... describe data, fit models, make plots

> The "egg" in "egg projects" is the R package that contains the data we are interested it. Once you have an egg, you know you can make any recipe that needs an egg. But eggs are fragile, and the boundary between the R pkg and the R project needs to be carefully maintained.

To do this, the next step is to create the R pkg that we will use to store
the data for this project.

    # in R
    > devtools::create("projdata")

_R packages have a strict naming scheme: one word, all lower case, no separators like dashes or underscores._ The end result has a directory structure like so:

    .
    └── my-proj
        ├── analysis.Rproj
        └── projdata
            ├── DESCRIPTION
            ├── NAMESPACE
            ├── R
            └── projdata.Rproj

    3 directories, 5 files

These steps can be automated by creating a simple bash script:

    $ touch newegg     # create an empty file "newegg"
    $ chmod +x newegg  # make it executable

    #!/usr/bin/env bash
    # newegg - create a new egg project.
    # usage: newegg projname pkgname
    projname=$1
    pkgname=$2
    mkdir $projname
    cd $projname
    echo "Version: 1.0" > analysis.Rproj
    Rscript -e "devtools::create('$pkgname')"
    cd ..

Use it like this:

    $ ./newegg my-proj projdata

## Getting the data

**A data project is not a dataset.** One implication of this is that getting the data should be automated as much as possible. Even if getting the data is as simple as downloading it with a URL, it's best practice to script it. One reason for this is that it allows you to create egg projects around data that is too big to store in the repository. Instead what is stored is the code to get the data.

Here's a simple bash script for downloading a dataset from the [Data is Plural](https://tinyletter.com/data-is-plural) newsletter.

    #!/usr/bin/env bash
    # usage: getdata
    curl http://www.faa.gov/about/initiatives/lasers/laws/media/laser_incidents_2010-2014.xls -o projdata/data-raw/laser_incidents_2010-2014.xls

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

The best way to share data in an R pkg is through .rda files stored in the package's data directory. I like to create an .R script that reads the raw data files and uses the devtools function ``use_data`` to save the data in the correct format:

    # data-raw/use-data.R
    library(readxl)
    library(devtools)
    laser_incidents <- read_excel("data-raw/laser_incidents_2010-2014.xls")
    use_data(laser_incidents)

After running this script, you can now load the data in your project:

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
        │   └── laser_incidents_2010-2014.xls
        └── projdata.Rproj

    # in R
    > devtools::load_all("projdata")
    > data("laser_incidents")

Now you can create reports that use the data in the root directory:

    my-proj/$ tree -L 1
    .
    ├── analysis.Rproj
    ├── getdata
    ├── projdata
    └── report.Rmd      # in same directory as R project and R pkg

    my-proj/$ cat report.Rmd
    ---
    title: "Results"
    ---

    ```{r}
    devtools::load_all("projdata")
    data("laser_incidents")
    head(laser_incidents)
    ```

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

    my-proj/$ Rscript -e "devtools::install('projdata')"

    # in R
    > library(projdata)
    > data("laser_incidents")

## Automation

At this point, there are a few commands run from the command line that are undocumented **and thus unrepeatable**. One solution is to create your own bin of bash scripts:

    my-proj/$ tree
    .
    ├── analysis.Rproj
    ├── bin
    │   ├── getdata
    │   ├── usedata
    │   └── install
    ├── ...

    my-proj/$ bin/getdata && bin/usedata && bin/install  # reproducible!

Another solution is to create a CLI for your data project. It's pretty easy to do this in python. For quick prototyping, a helpful python package to look at is [invoke](http://pyinvoke.org).

## Sharing the data

If you are sharing your data project, its essential that you
use version control to avoid profound headaches down the road.
Luckily we only need to know a few `git` commands to get started:

    $ pwd  # my-proj/
    $ git init
    $ git add .
    $ git commit -m "Initial commit for my-proj"

The only manual step is to create a destination repo on github,
bitbucket, gitlab, etc. Here I've created a repo on github, and
am adding a remote branch for my project:

    $ git remote add origin git@github.com:pedmiston/my-proj.git
    $ git push -u origin master

Now anyone can clone the whole data project with git:

    colleague/$ git clone git@github.com:pedmiston/my-proj.git

In order to use the data in R, they could load the projdata
package locally:

    > devtools::load_all("projdata")

If they just want the data, they can install the projdata package
within the github repo using `devtools::install_github`::

    # in R
    > devtools::install_github("pedmiston/my-proj", subdir = "projdata")
    > library(projdata)

## Benefits

### Documentation

Integrate function docs a
