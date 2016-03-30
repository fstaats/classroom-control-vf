define users::managed_user (
    $gid              = $title,
    $home             = undef,
    $password         = undef,
    $password_max_age = undef,
    $password_min_age = undef,
    $shell            = undef,
    $uid              = $title,
 ) {
    File {
        owner   => $uid,
        group   => $gid,
        mode    => '0644',
    }
    $home_dir = $home ? {
        undef   => "/home/${uid}",
        default => $home,
    }
    file { [$home_dir, "${home_dir}/.ssh"]:
        ensure => directory
    }
    group { $gid:
        ensure => 'present',
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
