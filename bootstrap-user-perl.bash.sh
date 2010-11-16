
# install a cpan config if missing
if [[ ! -f ~/.cpan/CPAN/MyConfig.pm ]]; then
    echo "Writing a new CPAN config..."
    mkdir -p ~/.cpan/CPAN
    cat <<'END_TXT' > ~/.cpan/CPAN/MyConfig.pm

$CPAN::Config = {
  'auto_commit' => q[0],
  'build_cache' => q[100],
  'build_dir' => qq[$ENV{HOME}/.cpan/build],
  'cache_metadata' => q[1],
  'commandnumber_in_prompt' => q[1],
  'cpan_home' => qq[$ENV{HOME}/.cpan],
  'ftp_passive' => q[1],
  'ftp_proxy' => q[],
  'http_proxy' => q[],
  'inactivity_timeout' => q[0],
  'index_expire' => q[1],
  'inhibit_startup_message' => q[0],
  'keep_source_where' => qq[$ENV{HOME}/.cpan/sources],
  'make_arg' => q[],
  'make_install_arg' => q[],
  'make_install_make_command' => q[],
  'makepl_arg' => q[INSTALLDIRS=site],
  'mbuild_arg' => q[],
  'mbuild_install_arg' => q[],
  'mbuild_install_build_command' => q[./Build],
  'mbuildpl_arg' => q[],
  'no_proxy' => q[],
  'prerequisites_policy' => q[follow],
  'scan_cache' => q[atstart],
  'show_upload_date' => q[0],
  'term_ornaments' => q[1],
  'urllist' => [q[http://cpan.mirror.facebook.net/], q[http://cpan.msi.umn.edu/], q[http://mirrors.servercentral.net/CPAN/], q[http://www.perl.com/CPAN/]],
  'use_sqlite' => q[0],
};
1;
__END__
END_TXT
fi

function bootstrap-local-lib () {
    echo "Installing local::lib and cpanminus..."
    wget --no-check-certificate http://cpanmin.us -q -O - \
      | perl - --local-lib=~/perl5 local::lib App::cpanminus
    eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
}

# set up local::lib & bootstrap if necessary
eval $(perl -Mlocal::lib 2>/dev/null || echo false) \
  || eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib 2>/dev/null || echo false) \
  || bootstrap-local-lib

