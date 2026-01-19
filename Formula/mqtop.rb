# typed: false
# frozen_string_literal: true

class Mqtop < Formula
  desc "High-performance MQTT explorer TUI - like htop for your broker"
  homepage "https://github.com/srcfl/mqtop"
  version "0.2.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-arm64"
      sha256 "37c5271fad3e7be81bca09daa7ce2770c6c3096710a8b70b6ba98f0025d34c1b"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-x64"
      sha256 "85de7dfb9baf8b7cae86d72f3b3aa0b127791af28d9ebb97556991ff49f1883f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-arm64"
      sha256 "7c6512f1e80aae884ef4c84e1422713050479a986e43f2c1d83a854e6d1ce101"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-x64"
      sha256 "5a368d211088ba88ede2dedae90e4d96b16424f0d88162d15b7c3ff4bc8a0c92"
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
