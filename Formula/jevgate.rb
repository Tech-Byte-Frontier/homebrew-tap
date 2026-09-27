class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.24.1/jevgate-0.24.1-aarch64-apple-darwin.tar.gz"
      sha256 "96507f9d37f898ac5ad406b8e3f68d76d99c812b7b8bfc5554de94289393a884"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.24.1/jevgate-0.24.1-x86_64-apple-darwin.tar.gz"
      sha256 "823031dcf7e48f25005b372fcdafb532698f0dd41f600665f77bd0ce4f6c477c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.24.1/jevgate-0.24.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "333e0c33910b6a169587f2724f714acefb36a908952e7ce7605d58ab3b65de5a"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.24.1/jevgate-0.24.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b1bb7b959d2400872de8524e6eca3f29015c6e1a27b28742de4c22d2a05a9852"
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
