class HuginAgent < Formula
  desc "Thin local agent for Hugin — scans LAN, talks Modbus, runs Lua drivers"
  homepage "https://github.com/srcfl/hugin-agent"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.2.0/hugin-agent_Darwin_arm64.tar.gz"
      sha256 "8cdf6d37a16e3d117d885ffd48685de6320092d26146094856d79e405615c202"
    end
    on_intel do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.2.0/hugin-agent_Darwin_x86_64.tar.gz"
      sha256 "9655da9fe2000243557c4a330813063eaf559e40e99ae7d119cee9b96dd4ac63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.2.0/hugin-agent_Linux_arm64.tar.gz"
      sha256 "f64861528eba79de110b8cab304f26f3858a11431dfe6258efb3320b321ac10d"
    end
    on_intel do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.2.0/hugin-agent_Linux_x86_64.tar.gz"
      sha256 "a45e9053cd03e3424e4bc0d1262658198f2e5566f051b2eb63dd9b5e1ca4e5bc"
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
