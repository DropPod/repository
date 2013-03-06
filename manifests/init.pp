# A simple type for cloning a Git repository.
# TODO: This should really be fleshed out into a proper type and provider pair.
define repository($source = $title, $target = "/Users/${id}/Projects") {
  if $title =~ /\// {
    $dirname = regsubst("${source}", ".*/([^.]*)([.]git)?", "\\1")
  } else {
    $dirname = $title
  }

  $directory = "${target}/${dirname}"

  file { "${target}": ensure => directory }
  file { "${directory}": ensure => directory }

  $init       = "git init"
  $remote_add = "git remote add origin '${source}'"
  $fetch      = "git fetch -q origin"
  $reset      = "git reset --hard origin/master"
  exec { "git clone ${source} ${directory}":
    command => "${init} && ${remote_add} && ${fetch} && ${reset}",
    creates => "${directory}/.git",
    cwd     => "${directory}",
    path    => "/usr/local/bin",
    require => File["${directory}"],
  }
}
