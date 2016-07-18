Egg projects
============

A data design pattern for data science in R.

Creating a new egg project
--------------------------

To create a new project called `my-proj`, first create the `my-proj`
directory::

    $ mkdir my-proj && cd my-proj

Then create a basic R project config file. You can do this from
RStudio, but a quick command line hack is to create an Rproj
file with the line "Version: 1.0" in it. When you open the file
with RStudio, it will fill in the remaining defaults::

    $ echo "Version: 1.0" > analysis.Rproj

The next step is to create the R pkg that we will use to store
the data for this project::

    # in R
    > devtools::create("projdata")

The end result has a directory structure like so::

    .
    └── my-proj
        ├── analysis.Rproj
        └── projdata
            ├── DESCRIPTION
            ├── NAMESPACE
            ├── R
            └── projdata.Rproj

    3 directories, 5 files

Getting the data
----------------

Remember that a data project is not a dataset. One implication of this is that getting the data is probably going to be scripted. Even if getting the data is as simple as downloading it with a URL, it's best practice to script it.

For this demo, I'll be using a simple bash script::

    #!/usr/bin/env bash
    curl http://www.faa.gov/about/initiatives/lasers/laws/media/laser_incidents_2010-2014.xls -o projdata/data-raw/laser_incidents_2010-2014.xls

Using the data in the R pkg
---------------------------

The best way to share data in an R pkg is through .rda files stored in the package's data directory. I like to create an .R script that reads the raw data files and uses the devtools function ``use_data`` to save the data in the correct format::

    # data-raw/use-data.R
    library(readxl)
    library(devtools)

    laser_incidents <- read_excel("data-raw/laser_incidents_2010-2014.xls")

    use_data(laser_incidents)

Sharing the R pkg
-----------------

If you are sharing your data project, its essential that you
use version control to avoid profound headaches down the road.
Luckily we only need to know a few `git` commands to get started::

    $ pwd  # my-proj/
    $ git init
    $ git add .
    $ git commit -m "Initial commit for my-proj"

The only manual step is to create a destination repo on github,
bitbucket, gitlab, etc. Here I've created a repo on github, and
am adding a remote branch for my project::

    $ git remote add origin git@github.com:pedmiston/my-proj.git
    $ git push -u origin master

Now anyone can clone the whole data project with git::

    colleague/$ git clone git@github.com:pedmiston/my-proj.git

In order to use the data in R, they would install the projdata
package locally::

    > devtools::install("projdata")
    > library(projdata)

If they just want the data, they can install the projdata package
within the github repo using `devtools::install_github`::

    # in R
    > devtools::install_github("pedmiston/my-proj", subdir = "projdata")
    > library(projdata)
