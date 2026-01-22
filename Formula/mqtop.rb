# typed: false
# frozen_string_literal: true

class Mqtop < Formula
  desc "High-performance MQTT explorer TUI - like htop for your broker"
  homepage "https://github.com/srcfl/mqtop"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-arm64"
      sha256 "8ace0727b012ec2e4c5441caf82391afe85ccaa5fd6805ca0f7ee404987358e2"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-macos-x64"
      sha256 "decbe2d089e4eb19efcc5ba595738a421497d787e4ea9c485b66d5d881166bb8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-arm64"
      sha256 "179e3d46db72b26c35c61a70f1edcf196c5c8973bc07811767ee98f625ba39d5"
    end
    on_intel do
      url "https://github.com/srcfl/mqtop/releases/download/v#{version}/mqtop-linux-x64"
      sha256 "dd72d4229dd6a7252404e2867c5385809c8546cb197c25bdc04aa7f4dd610510"
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
