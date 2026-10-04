class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.35.0/jevgate-0.35.0-aarch64-apple-darwin.tar.gz"
      sha256 "d75e15f55e168b0f8af56de819940ece072e34bc34932590aaaa7ca943563eb0"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.35.0/jevgate-0.35.0-x86_64-apple-darwin.tar.gz"
      sha256 "96f51a3b5b82e5987b0c5684940671e93dc09727a636a690799fa6c57ba93e2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.35.0/jevgate-0.35.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7e5c95485e4563417f902721fcd7cca902aba185e6ce7695808bad551f39c899"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.35.0/jevgate-0.35.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e9171c4b15245bcb48a674c42526c70ec1f3d97a163eb9870f670f7cea918423"
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
