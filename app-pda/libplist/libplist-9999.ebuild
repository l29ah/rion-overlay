# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils multilib python git

EGIT_REPO_URI="git://github.com/JonathanBeck/libplist.git"
DESCRIPTION="Support library to deal with Apple Property Lists (Binary & XML)"
HOMEPAGE="http://matt.colyer.name/projects/iphone-linux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/glib:2
		dev-libs/libxml2"

DEPEND="${RDEPEND}
	dev-lang/swig"

src_unpack() {
		git_src_unpack
}

src_prepare() {
	sed -e 's:-Werror::g' \
		-i swig/CMakeLists.txt || die "sed failed"
}

src_configure() {
	python_version
	mycmakeargs="-DCMAKE_SKIP_RPATH=ON
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir)
		-DPYTHON_VERSION=${PYVER}"

	cmake-utils_src_configure
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
}

pkg_postrm() {
	python_mod_cleanup
}
