# Maintainer: Petr Kracik <petrkr@petrkr.net>

pkgname=freedata-server
pkgver=0.16.9
pkgrel=1
pkgdesc="FreeDATA is a versatile, open-source platform designed specifically for HF communications, leveraging Codec2 data modes for robust global digital communication. It features a network-based server-client architecture, a REST API, multi-platform compatibility, and a messaging system."
arch=('x86_64')
url="https://wiki.freedata.app"
license=('GPL-3.0')
depends=('uvicorn'
	'python-pyserial'
	'python-numpy'
	'python-psutil'
	'python-sqlalchemy'
	'python-requests'
	'python-websocket-client'
	'python-fastapi'
	'python-structlog'
	'python-sounddevice')

install=freedata.install
makedepends=('cmake'
	'make'
	'gcc')

_codec2_commit="ff00a6e2489f870abb10117ff5bf4b0a64bf05d4"
source=("freedata.install"
	"FreeDATA.desktop"
	"freedata.sh"
	"https://github.com/DJ2LS/FreeDATA/archive/refs/tags/v${pkgver}.tar.gz"
	"https://github.com/drowe67/codec2/archive/${_codec2_commit}.zip")

sha256sums=('0c2a75baa39459fa56159e982d9f28c966837561bd52dffd24bac87b8d65555f'
            '3fe415e43c909c21af1128cf2b5892d9ee3c2f39557644b228432f5d6e62da8a'
            'b15822316d9f80d2c1da64f48c7f01cec9c5ea126141cc3159d6d59aa325961c'
            '962b393492fd158acf7d41d9211aa24409b98fe1fb0b96ae89e9b919d583d711'
            '40ede4f9240d6082c49483ccfa6a7f616c09d52a3715bd837f30563301c45e42')

build() {
	cd "${srcdir}"
	
	# Build codec2
	cd codec2-${_codec2_commit}
	[ -d build ] && rm -r build
	mkdir build
	cd build
	cmake ..
	make codec2 -j4
	cd ../../
	cd FreeDATA-${pkgver}/freedata_server
	python3 -m compileall .
	rm -r lib/codec2
	cd ../freedata_gui

}

package() {
	cd ${pkgdir}
	mkdir -p "usr/bin"
	mkdir -p "opt/FreeDATA"
	mkdir -p "usr/share/doc"
	mkdir -p "usr/share/licenses/${pkgname}"
	mkdir -p "usr/share/applications"
	mkdir -p "usr/share/icons/hicolor/192x192/apps"

	cd ${pkgdir}/opt/FreeDATA
	
	# Copy server
	cp -a ${srcdir}/FreeDATA-${pkgver}/freedata_server ./
	
	# Copy own codec2
	cp ${srcdir}/codec2-${_codec2_commit}/build/src/libcodec2.so* ./freedata_server/lib/

	# Copy desktop icon
	cp ${srcdir}/FreeDATA-${pkgver}/freedata_gui/public/android-chrome-192x192.png ${pkgdir}/usr/share/icons/hicolor/192x192/apps/FreeDATA.png

	# Copy desktop link
	cp ${srcdir}/FreeDATA.desktop ${pkgdir}/usr/share/applications/

	# Copy License and documentation
	cp ${srcdir}/FreeDATA-${pkgver}/LICENSE ${pkgdir}/usr/share/licenses/${pkgname}/
	cp -a ${srcdir}/FreeDATA-${pkgver}/documentation ${pkgdir}/usr/share/doc/${pkgname}

	install -m 755 ${srcdir}/freedata.sh ${pkgdir}/usr/bin/freedata
}
