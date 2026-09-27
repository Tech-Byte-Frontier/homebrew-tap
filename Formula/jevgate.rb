class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.23.1/jevgate-0.23.1-aarch64-apple-darwin.tar.gz"
      sha256 "d079c384c7c8dac913624e4ed9bf5d0a033b752595bfbd8950a20bb12385ac51"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.23.1/jevgate-0.23.1-x86_64-apple-darwin.tar.gz"
      sha256 "4e83026154ffbbddbcb97afd005b31c46498c41370fc35d77a8fa2fe1bc19bfd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.23.1/jevgate-0.23.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0e85afd706f1b8ef51ffb59b4a8b4bb1fe19b03a6273754f020f87b717d89ce9"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.23.1/jevgate-0.23.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "79849f3c6904616763402cf88f1cfe3dd09aa3543b10f631c9d4311a3a77e80e"
    end
  end

  def install
    bin.install "jevgate"
    generate_completions_from_executable(bin/"jevgate", "completions")
    man1.mkpath
    (man1/"jevgate.1").write Utils.safe_popen_read(bin/"jevgate", "man")
    %w[auth check baseline rules init serve mcp completions man].each do |command|
      (man1/"jevgate-#{command}.1").write Utils.safe_popen_read(bin/"jevgate", "man", command)
    end
  end

  test do
    assert_match "jevgate #{version}", shell_output("#{bin}/jevgate --version")
    system bin/"jevgate", "rules"
  end
end
