class HuginAgent < Formula
  desc "Thin local agent for Hugin — scans LAN, talks Modbus, runs Lua drivers"
  homepage "https://github.com/srcfl/hugin-agent"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.1.1/hugin-agent_Darwin_arm64.tar.gz"
      sha256 "0432c456391ad7c1b79bcda5d8c4788fe3d5cbddbe06e575e5192a6149fabdde"
    end
    on_intel do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.1.1/hugin-agent_Darwin_x86_64.tar.gz"
      sha256 "70578ba7f54d07a3cfe89dbcb5c258044841591dc88b0c2227e573e99e3a0fb2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.1.1/hugin-agent_Linux_arm64.tar.gz"
      sha256 "045bb8f019cfb100bda1ed80dc597456af91b3dfc324d59fc70914a60f4ae16a"
    end
    on_intel do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.1.1/hugin-agent_Linux_x86_64.tar.gz"
      sha256 "71d7c839f4b8ed50e6f4e0976b401e98964a9c72dcedf7043bacaf9b03559ac6"
    end
  end

  def install
    bin.install "hugin-agent"
  end

  test do
    # Bind to a high port the test runner won't already have, hit /v1/info,
    # confirm we get the expected JSON shape. --no-browser so we don't
    # accidentally open a browser on the build machine.
    require "net/http"
    require "json"
    port = 19891
    pid = spawn(bin/"hugin-agent", "--port", port.to_s, "--token", "test", "--no-browser")
    sleep 1
    begin
      resp = Net::HTTP.get(URI("http://127.0.0.1:#{port}/v1/info"))
      data = JSON.parse(resp)
      assert_equal "hugin-agent", data["name"]
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
