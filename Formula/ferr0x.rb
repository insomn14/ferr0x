class Ferr0x < Formula
  desc "High-performance security testing tool for analyzing HTTP requests"
  homepage "https://github.com/insomn14/ferr0x"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/insomn14/ferr0x/releases/download/v1.0.0/ferr0x-macos-arm64"
      sha256 "5a226533e5daae8bf74d48eff99a6f27b6c3b45aa98714d3834484615a24c9a8"

      def install
        bin.install "ferr0x-macos-arm64" => "ferr0x"
      end
    else
      url "https://github.com/insomn14/ferr0x/releases/download/v1.0.0/ferr0x-macos-x86_64"
      sha256 "c607475014683c7d042073a915e0d89723cf1bccb082d812a71ea0317233f4b6"

      def install
        bin.install "ferr0x-macos-x86_64" => "ferr0x"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/insomn14/ferr0x/releases/download/v1.0.0/ferr0x-linux-x86_64"
      sha256 "dab13e12c8ace032a74d29a04567a6457e7a651600998024769d9c2e7562fd02"

      def install
        bin.install "ferr0x-linux-x86_64" => "ferr0x"
      end
    end
  end

  test do
    system "#{bin}/ferr0x", "--version"
  end
end
