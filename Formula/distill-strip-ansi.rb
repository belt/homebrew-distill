class DistillStripAnsi < Formula
  desc "Strip/mutate/distill ANSI escape sequences, echoback/other mitigation"
  homepage "https://github.com/belt/distill-strip-ansi"
  url "https://github.com/belt/distill-strip-ansi/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "b02b76e044d33f946c838642dde983d82a5505c157f33d58899fd8a6cb2ad5ff"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/belt/distill-strip-ansi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # SGR (bold, green) + all 5 echoback threats (CSI 21t, CSI 6n,
    # DCS DECRQSS, OSC 50, OSC 52) + OSC hyperlink + OSC title +
    # Fe (Index, Reverse Index).  Dumb preset strips everything.
    input = "\e[1mBuild\e[0m \e[32m✓\e[0m " \
            "\e[21t\e[6n\eP$q\"p\e\\\e]50;?\a\e]52;c;Cg==\a" \
            "\e]8;;https://ci.dev\alog\e]8;;\a" \
            "\e]0;title\a\eD\eM done"
    output = pipe_output(bin/"strip-ansi", input)
    assert_equal "Build ✓ log done", output.strip

    assert_match version.to_s,
                 shell_output("#{bin}/strip-ansi --version")
  end
end
