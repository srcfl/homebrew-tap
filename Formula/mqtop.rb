# typed: false
# frozen_string_literal: true

class Mqtop < Formula
  desc "High-performance MQTT explorer TUI - like htop for your broker"
  homepage "https://github.com/srcfl/mqtop"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-arm64"
      sha256 "255953f2e3e9a88d9291e9de92f6720efabf2ef7449b7751eb7174833e7188e4"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-x64"
      sha256 "974cbfe47626b2fdd728e159a891391e620317ec3fe0bf0fb4c1d35d44ab676d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-arm64"
      sha256 "a9f8de2965b91eb6b450a23d7a2ee28dee22f1f67abb6eb238f82636a00deef1"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-x64"
      sha256 "27bfe3e83304e3d490adcce6e8173be22becb4a267330d01e5e887bd6e2a92d6"
    end
  end

  def install
    binary_name = "mqtop"
    downloaded_file = Dir["mqtop*"].first || binary_name
    mv downloaded_file, binary_name if downloaded_file != binary_name
    bin.install binary_name
  end

  test do
    assert_match "mqtop", shell_output("#{bin}/mqtop --version 2>&1", 0)
  end
end
