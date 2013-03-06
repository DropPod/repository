# The `repository` Type #

This module provides a basic type for managing source control checkouts.

## Example ##

``` puppet
repository { "Rails":
  source   => "https://github.com/rails/rails.git",
}
```

## Caveats ##

This type is currently *incredibly* primitive, and does not yet support any SCM
besides Git.
