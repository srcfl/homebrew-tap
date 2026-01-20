# typed: false
# frozen_string_literal: true

class Mqtop < Formula
  desc "High-performance MQTT explorer TUI - like htop for your broker"
  homepage "https://github.com/srcfl/mqtop"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-arm64"
      sha256 "5a2d734bd4431a55de5b5b0f903ed8eebf61aff21123000e180f7aaae80d9a6a"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-x64"
      sha256 "54d713b5845bc3b1b3a942d526cd7e56fff6788df97dcd22829ff28bf5258db1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-arm64"
      sha256 "bf18eeb58977d2826972cc6a764e7be6da2697716a29433342a2daabf14214a0"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-x64"
      sha256 "9cda8fff9e6696ba96f9fd3e1606420dfc85d5f38f1e5fccbe1476f416e5f16c"
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
