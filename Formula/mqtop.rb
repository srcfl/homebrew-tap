# typed: false
# frozen_string_literal: true

class Mqtop < Formula
  desc "High-performance MQTT explorer TUI - like htop for your broker"
  homepage "https://github.com/srcfl/mqtop"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-arm64"
      sha256 "d2999b7d3a3dd47785e96d31f5c65da3345f2ea32d6d8a80e730709b6e62eec4"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-x64"
      sha256 "d3f485ecec36f6338926b371e7ac1f2641bb9770034aba519869dc60bdb61140"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-arm64"
      sha256 "f741c995dcf7129bd073406f3c0c42afbc05c5fa6fd15059a124ed0ab5fb0782"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-x64"
      sha256 "c7eccb7029e0a5c5110375df1dbf50c9367e259d566f98d698af97647d6ca5f4"
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
