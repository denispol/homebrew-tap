# typed: false
# frozen_string_literal: true

class DarwinTimeout < Formula
  desc "Run a command with a time limit (GNU timeout clone for Darwin/Apple platforms)"
  homepage "https://github.com/denispol/darwin-timeout"
  url "https://github.com/denispol/darwin-timeout/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "1d5d4d76f2ebd0a2ac253015396340a4f94cc97807501d4b68aa1ae263df33c7"
  license "MIT"
  head "https://github.com/denispol/darwin-timeout.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args

    # Install shell completions
    bash_completion.install "completions/timeout.bash" => "timeout"
    zsh_completion.install "completions/timeout.zsh" => "_timeout"
    fish_completion.install "completions/timeout.fish"
  end

  test do
    # Test basic timeout functionality
    assert_match "timeout", shell_output("#{bin}/timeout --version")

    # Test that a fast command completes successfully
    system bin/"timeout", "5", "true"

    # Test JSON output
    output = shell_output("#{bin}/timeout --json 5 true")
    assert_match '"status":"completed"', output
    assert_match '"schema_version":2', output

    # Test that timeout actually works (command times out)
    output = shell_output("#{bin}/timeout --json 0.1 sleep 10", 124)
    assert_match '"status":"timeout"', output
  end
end
