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
