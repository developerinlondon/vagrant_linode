require 'colorize'

task :default => :init

task :init do
  puts "==> configuring submodules:".green
  sh "git submodule foreach -q --recursive 'branch=\"$(git config -f ../.gitmodules submodule.$name.branch)\"; git checkout $branch; pre-commit install'"
  puts "==> unlocking git crypt:".green
  sh "git crypt unlock"
  puts "==> installing pre-commits:".green
  sh "pre-commit install"
end
