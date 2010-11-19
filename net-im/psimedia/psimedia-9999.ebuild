# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit qt4-r2 subversion

DESCRIPTION="Psi plugin for voice/video calls"
HOMEPAGE="http://delta.affinix.com/"
ESVN_REPO_URI="https://delta.affinix.com/svn/trunk/psimedia"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-devel/qconf"
RDEPEND="media-plugins/gst-plugins-speex
	>=media-plugins/gst-plugins-v4l-0.10.22
	>=media-plugins/gst-plugins-theora-0.10.22
	>=media-plugins/gst-plugins-ogg-0.10.22
	>=media-plugins/gst-plugins-alsa-0.10.22
	>=media-plugins/gst-plugins-vorbis-0.10.22
	media-plugins/gst-plugins-v4l2
	media-plugins/gst-plugins-jpeg
	media-libs/gst-plugins-good
	>=dev-libs/glib-2.20.0
	x11-libs/qt-core
	x11-libs/qt-gui"

src_unpack() {
	subversion_src_unpack
	S="$WORKDIR/patches" ESVN_PROJECT="psimedia/patches" subversion_fetch \
		"http://psi-dev.googlecode.com/svn/trunk/patches/psimedia"
}

src_prepare() {
	epatch "$WORKDIR/patches"/*
	subversion_src_prepare
}

src_configure() {
	qconf
	./configure
	eqmake4
}

src_install() {
	insinto /usr/$(get_libdir)/psi/plugins
	doins gstprovider/libgstprovider.so
}
