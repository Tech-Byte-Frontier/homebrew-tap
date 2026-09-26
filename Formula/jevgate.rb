class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.21.0/jevgate-0.21.0-aarch64-apple-darwin.tar.gz"
      sha256 "fb22dfa23c6f4d431a36520223d39f92deed663146edbae2775cce24b8ae34f6"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.21.0/jevgate-0.21.0-x86_64-apple-darwin.tar.gz"
      sha256 "61bb9e339b407b074a607dfa231f4279c656f88a5211d3ef3ee7e33a9baa82ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.21.0/jevgate-0.21.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ee8dfb168de28b8f6035e60c4ac876f28c3f59a5f5cad1b0bd4d036f3a0832b3"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.21.0/jevgate-0.21.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "07c19312c008dfded3cb0e2fc3ee13c70b48275b4c580759bfa7638675f3be1f"
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
