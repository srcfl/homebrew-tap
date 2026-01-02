# typed: false
# frozen_string_literal: true

class Mqtop < Formula
  desc "High-performance MQTT explorer TUI - like htop for your broker"
  homepage "https://github.com/srcfl/mqtop"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-arm64"
      sha256 "3a5c1f5ead80da6396452cefe4425a89157ec22c4aed38b7580fab173bec29aa"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-x64"
      sha256 "35b800c23d51471f9c94863fb0acd50f0de6da899054c0b80ab1ed09d8b5f9b1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-arm64"
      sha256 "c05c3710efc874538083cf230a65a630dbd8b188a634a4b723c464d3e745c2e6"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-x64"
      sha256 "a2792c890ffa31f580fdea6dce660d1b783f2a2983f9d2377aa5fad6150d7b80"
    end
  end

  def install
    binary_name = "mqtop"

    # The downloaded file might have a platform suffix, rename it
    downloaded_file = Dir["mqtop*"].first || binary_name
    mv downloaded_file, binary_name if downloaded_file != binary_name

    bin.install binary_name
  end

  test do
    assert_match "mqtop", shell_output("#{bin}/mqtop --version 2>&1", 0)
  end
end
