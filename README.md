# py_dep_summary

Tiny project that holds scripts for analyzing the dependencies of a Python project. This shell script will generate a CSV with the name, version, license, and URL of all recursive dependencies of a given Python package.

This can be useful for checking whether a project has taken on any licenses that you want to avoid.

## Requirements

This was built super fast and probably has too many dependencies. It assumes you have:

* Anaconda distribution of Python 3 + `conda` command line utilities
* Python package `pip-licenses`
* R (with packages `argaparse`, `data.table`, and `jsonlite`)

## Usage Example

Let's say you want to run this check on the project [doppel-cli](https://github.com/jameslamb/doppel-cli). To clone it to your laptop, run

```
mkdir -p ${HOME}/tmp/
pushd ${HOME}/tmp
    git clone git@github.com:jameslamb/doppel-cli.git
popd
```

`cd` over to wherever you've cloned the `py_dep_summary` repo, then run:

```
# Path to a project with a setup.py file
PKG=${HOME}/tmp/doppel-cli

# Path to write output to
OUT_FILE=$(pwd)/licenses.json

./check_licenses.sh ${PKG} ${OUT_FILE}
```

This will generate the file `licenses.json`. To turn it into a CSV, run

```
Rscript make_csv.R --file ${OUT_FILE}
open dependencies.csv
```

This will generate a file `dependencies.csv` and open it with your default viewer.
