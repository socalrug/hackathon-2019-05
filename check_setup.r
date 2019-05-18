# Install needed packages
package <- c('rstudioapi', 'tidyverse', 'caret')
lapply(package, FUN = function(pkg) {
  if (!require(pkg, quietly=TRUE, warn.conflicts=FALSE, character.only = TRUE)){
    install.packages(pkg, dependencies = TRUE)
  }
})

# check the version of R
if (as.numeric(R.Version()$major) < 3 ||
    (as.numeric(R.Version()$major) == 3 &
     as.numeric(stringr::str_split(R.Version()$minor, "[.]")[[1]][[1]]) < 4)) {
  warning('Your version of R is quite old, consider upgrading')
}

# Check the version of R Studio
if ( rstudioapi::versionInfo()$version < "1.1") {
  warning('Using an old version of RStudio, consider upgrading')
}


# Update all packages
# This may take a while
update.packages(ask = FALSE)
