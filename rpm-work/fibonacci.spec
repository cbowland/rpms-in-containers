Summary: A simple program that prints portion of the fibonacci sequence
Name: fibonacci
Version: 1.0.0
Release: 1
URL: https://cbow.io
Group: System
License: best guess # https://fedoraproject.org/wiki/Licensing:Main?rd=Licensing#Software_License_List
Packager: cbow 
Requires: bash
buildroot: ~/workspace/rpms-in-containers/rpm-work # this should be replaced with your working directory where the spec is saved

%description
An simple package that prints the first N of the fibonacci sequence

%install
mkdir -p %{buildroot}/usr/bin/
echo build root is %{buildroot}
cp ~/workspace/rpms-in-containers/apps/fibonacci %{buildroot}/usr/bin/fibonacci

%files
/usr/bin/fibonacci

%changelog
* Fri Mar 1 2024 cbow <cbowland@redhat.com>
- initial example