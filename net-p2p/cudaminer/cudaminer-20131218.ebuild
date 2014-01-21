EAPI=4
inherit autotools

DESCRIPTION="A CUDA accelerated litecoin mining application based on pooler's CPU miner"
HOMEPAGE="http://github.com/cbuchner1/CudaMiner"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-util/nvidia-cuda-toolkit-5.5.0"
DEPEND="${RDEPEND}
		>=dev-util/nvidia-cuda-sdk-5.5.0
		>=dev-libs/jansson-2.4"

DOCS=( README.txt LICENSE.txt )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-nvcc-flags.patch
	eautoreconf
}

src_configure() {
	econf --with-cuda=/opt/cuda
}
