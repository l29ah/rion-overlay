# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils eutils flag-o-matic multilib-minimal toolchain-funcs

DESCRIPTION="C Unit Test Framework from Belledonne Comminications"
STABLE_REV=fe7c9c5bd32b72542dd96d772b9b5f70adc53117
SRC_URI="https://github.com/BelledonneCommunications/bcunit/archive/${STABLE_REV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="https://github.com/BelledonneCommunications/bcunit"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ncurses static-libs"

RDEPEND="ncurses? ( >=sys-libs/ncurses-5.9-r3:0=[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${STABLE_REV}

DOCS=( AUTHORS NEWS README ChangeLog )

multilib_src_configure() {
	local mycmakeargs=( "-DENABLE_CURSES=$(usex ncurses)" )
	cmake-utils_src_configure
}

multilib_src_install() {
	cmake-utils_src_install
}
