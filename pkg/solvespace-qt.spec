Name:      solvespace-qt
Version:   3.2
Release:   %autorelease
Summary:   A parametric 3D CAD tool
License:   GPL-3.0-or-later
URL:       https://solvespace.com/
Source0:   https://github.com/WickedSmoke/solvespace_qt5/releases/download/v3.2-qt/solvespace-%{version}.tar.xz
BuildRequires: g++, cmake, qt6-qtbase-devel, eigen3-devel, fontconfig-devel, freetype-devel, libpng-devel, zlib-devel, mesa-libGL-devel mesa-libGLU-devel

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
%setup -q -n solvespace-%{version}

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
%{_bindir}/solvespace-qt
%{_datadir}/applications/solvespace-qt.desktop
%{_datadir}/icons/hicolor
%{_datadir}/metainfo/com.solvespace.SolveSpace.metainfo.xml
%{_datadir}/mime/packages/solvespace-slvs.xml
%{_datadir}/solvespace

%files devel
%{_includedir}/slvs.h
%{_libdir}/libslvs.so.3.2
%{_libdir}/libslvs.so.1
%{_libdir}/libslvs.so

%changelog
* Thu Mar 07 2024 Karl Robillard <wickedsmoke@users.sourceforge.net>
- Initial Qt version 3.1
