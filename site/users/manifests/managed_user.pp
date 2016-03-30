define users::managed_user (
    $user,
    $gid              = undef,
    $home             = undef,
    $password         = undef,
    $password_max_age = undef,
    $password_min_age = undef,
    $shell            = undef,
    $uid              = undef,
 ) {
    File {
        owner   => $uid,
        group   => $gid,
        mode    => '0644',
    }
    file { [$home, "${home}/.ssh"]:
        ensure => directory
    }
    if $gid {
        group { $gid:
            ensure => 'present',
        }
    }
    user { $title:
        ensure           => 'present',
        gid              => $gid,
        home             => $home,
        password         => $password,
        password_max_age => $password_max_age,
        password_min_age => $password_min_age,
        shell            => $shell,
        uid              => $uid
    }
}
