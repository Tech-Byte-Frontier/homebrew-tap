class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.31.0/jevgate-0.31.0-aarch64-apple-darwin.tar.gz"
      sha256 "869f68127dd555f81040af4d06591ee0d07b22c499f6c91fb352131c2e217786"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.31.0/jevgate-0.31.0-x86_64-apple-darwin.tar.gz"
      sha256 "5f08046001a34e4bd3eae1d9320a877b7e8b76c8f7e1177c5a49e8a2a8c9a450"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.31.0/jevgate-0.31.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "15e76a3107fff1d527e1406c8e377aec1e76aa7b3e03a8979573784fd6a9c139"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.31.0/jevgate-0.31.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6370d563ef6680c7006b0e1ffebe1328385b4778ca4bb306b5f4ddb7726c1539"
    end
  end

  def install
    bin.install "jevgate"
    generate_completions_from_executable(bin/"jevgate", "completions")
    man1.mkpath
    (man1/"jevgate.1").write Utils.safe_popen_read(bin/"jevgate", "man")
    %w[auth check baseline rules init serve mcp hook completions man].each do |command|
      (man1/"jevgate-#{command}.1").write Utils.safe_popen_read(bin/"jevgate", "man", command)
    end
  end

  test do
    assert_match "jevgate #{version}", shell_output("#{bin}/jevgate --version")
    system bin/"jevgate", "rules"
  end
end
