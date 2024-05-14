Name:      solvespace-qt
Version:   3.1
Summary:   A parametric 3D CAD tool
URL:       https://solvespace.com/
Source0:   https://github.com/WickedSmoke/solvespace_qt5/releases/download/v%{version}-qt/solvespace_qt-%{version}.tar.gz
Release:   %autorelease
License:   GPL-3.0-or-later
BuildRequires: g++, cmake, qt5-qtbase-devel, eigen3-devel, fontconfig-devel, freetype-devel, libpng-devel, zlib-devel, mesa-libGL-devel, mesa-libGLU-devel

%global debug_package %{nil}

%description
SOLVESPACE is a free (GPLv3) parametric 3d CAD tool. Applications include
modeling 2D/3D parts, export of STL for 3D printing, preparing CAM data,
and mechanism constraint design.

%package devel
Summary: Development files for SolveSpace
Requires: %{name}%{?_isa} = %{version}-%{release}

%description devel
This package contains the SolveSpace C++ library and header.

%prep
%setup -q -n solvespace_qt-%{version}
sed -e 's/include(GetGit/# include(GetGit/' -e 's/# set(GIT.*/set(GIT_COMMIT_HASH 01d543e6)/' -i CMakeLists.txt

%build
%cmake -DUSE_QT_GUI=ON -DENABLE_CLI=OFF -DENABLE_TESTS=OFF
%cmake_build

%install
%cmake_install

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)
%doc README.md CHANGELOG.md
%license COPYING.txt
%{_bindir}/solvespace
%{_datadir}/applications/solvespace.desktop
%{_datadir}/icons/hicolor
%{_datadir}/metainfo/com.solvespace.SolveSpace.metainfo.xml
%{_datadir}/mime/packages/solvespace-slvs.xml
%{_datadir}/solvespace

%files devel
%{_includedir}/slvs.h
%{_libdir}/libslvs.so.3.1
%{_libdir}/libslvs.so.1
%{_libdir}/libslvs.so

%changelog
* Thu Mar 07 2024 Karl Robillard <wickedsmoke@users.sourceforge.net>
- Initial Qt version 3.1
