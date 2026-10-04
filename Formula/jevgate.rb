class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.34.0/jevgate-0.34.0-aarch64-apple-darwin.tar.gz"
      sha256 "840315c8b67540e0772ba3d07e753c537eebaeee14c4a2f2edaebc05f21a3c86"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.34.0/jevgate-0.34.0-x86_64-apple-darwin.tar.gz"
      sha256 "a60d214c4a5643563bcc2adb775b1b8721264676c57350b1a2cb62a5c5dfab0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.34.0/jevgate-0.34.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3d7ec988339b75f7f33d8edbda812f78df70fb833930a71fbcd85e5bdba417f4"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.34.0/jevgate-0.34.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9c24e7b928f6992350ed04a02aab8e3f26d1c11d60beb5d7913f76e1de399e0f"
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
