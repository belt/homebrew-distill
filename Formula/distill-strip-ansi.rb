class DistillStripAnsi < Formula
  desc "Strip, mutate, distill ANSI escape sequences, echoback/other mitigation"
  homepage "https://github.com/belt/distill-strip-ansi"
  url "https://github.com/belt/distill-strip-ansi/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "039ad4b9f832a5effbd0103dfdc0cf17d9f67ac4296e1686772d0945628f12fd"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/belt/distill-strip-ansi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    # distill-ansi-cli is required to build the distill-ansi binary
    # (Cargo.toml: `[[bin]] name = "distill-ansi" required-features =
    # ["distill-ansi-cli"]`) — it is not in the crate's default feature
    # set, so cargo install needs it named explicitly. Without this,
    # `cargo install` only produces strip-ansi and the test block's
    # `distill-ansi --version` assertion fails.
    system "cargo", "install", *std_cargo_args, "--features", "distill-ansi-cli"
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

    # distill-ansi: color depth reduction (truecolor → mono strips color,
    # keeps text and styles like bold/reset).
    color_input = "\e[1m\e[38;2;255;0;0mred\e[0m plain"
    mono_output = pipe_output("#{bin}/distill-ansi --color-depth mono", color_input)
    assert_equal "\e[1mred\e[0m plain", mono_output.strip

    assert_match version.to_s,
                 shell_output("#{bin}/distill-ansi --version")
  end
end
