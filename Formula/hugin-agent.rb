class HuginAgent < Formula
  desc "Thin local agent for Hugin — scans LAN, talks Modbus, runs Lua drivers"
  homepage "https://github.com/srcfl/hugin-agent"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.1.0/hugin-agent_Darwin_arm64.tar.gz"
      sha256 "1b33f9299406f96e5583288db6a05eae170112e3f0646b4221edac0eee54af46"
    end
    on_intel do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.1.0/hugin-agent_Darwin_x86_64.tar.gz"
      sha256 "dffffa33a8ebb3406b17843afdf8a36422809659f7bd6b66beaa93c5726a8a1e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.1.0/hugin-agent_Linux_arm64.tar.gz"
      sha256 "f77a8cf24fde3daafd5b6e1eb68f3a86780b22d4fc898cc0b6f8305c8888dae2"
    end
    on_intel do
      url "https://github.com/srcfl/hugin-agent/releases/download/v0.1.0/hugin-agent_Linux_x86_64.tar.gz"
      sha256 "d74f9e773ef77fbfc90866fbf11b609a4e9587bb650ae503a0f7e8ca27d57f37"
    end
  end

  def install
    bin.install "hugin-agent"
  end

  test do
    # Bind to a high port the test runner won't already have, hit /v1/info,
    # confirm we get the expected JSON shape.
    require "net/http"
    require "json"
    port = 19891
    pid = spawn(bin/"hugin-agent", "--port", port.to_s, "--token", "test")
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
