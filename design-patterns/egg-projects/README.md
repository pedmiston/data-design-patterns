# Egg projects

A design pattern for data science in R.

## Creating a new egg project

To create a new project called `my-proj`, first create the `my-proj`
directory:

    $ mkdir my-proj && cd my-proj

Then create a basic R project config file. You can do this from
RStudio, but a quick command line hack is to create an Rproj
file with the line "Version: 1.0" in it. When you open the file
with RStudio, it will fill in the remaining defaults::

    $ echo "Version: 1.0" > analysis.Rproj

The next step is to create the R pkg that we will use to store
the data for this project:

    # in R
    > devtools::create("projdata")

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

These steps can be automated by creating a simple bash script:

    $ touch newegg
    $ chmod +x newegg

    #!/usr/bin/env bash
    # newegg - create a new egg project.
    mkdir $1
    cd $1
    echo "Version: 1.0" > analysis.Rproj
    Rscript -e "devtools::create('$2')"

Use it like this:

    $ newegg my-proj projdata

## Getting the data

**A data project is not a dataset.** One implication of this is that getting the data should be automated as much as possible. Even if getting the data is as simple as downloading it with a URL, it's best practice to script it. One reason for this is that it allows you to create egg projects around data that is too big to store in the repository. Instead what is stored is the code to get the data.

Here's a simple bash script for downloading a dataset from the [Data is Plural](https://tinyletter.com/data-is-plural) newsletter.

    #!/usr/bin/env bash
    # getdata
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
    └── report.Rmd

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
    │   ├── install
    │   └── usedata
    ├── ...

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
