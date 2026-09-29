class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.32.0/jevgate-0.32.0-aarch64-apple-darwin.tar.gz"
      sha256 "2dea53b024d9b207f181250488e7d8f7455963c89e60a2152ba68aeb53032d68"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.32.0/jevgate-0.32.0-x86_64-apple-darwin.tar.gz"
      sha256 "8e4b30333966d9010f2c548913a4cd3be0f3eb0348a5cf73f7bd89d1bbd49a2a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.32.0/jevgate-0.32.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "63c5a2b747b90528e5b8c0d53b690f59a2cd7db4c3953d66475d51aa80f05a1c"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.32.0/jevgate-0.32.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f829eb0596c10e87a296e4c28d221cb41a52dcb74eec3b8393bb776a49c5a694"
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
