# typed: false
# frozen_string_literal: true

class DarwinTimeout < Formula
  desc "Run a command with a time limit (GNU timeout clone for Darwin/Apple platforms)"
  homepage "https://github.com/denispol/darwin-timeout"
  version "1.1.1"
  license "MIT"

  url "https://github.com/denispol/darwin-timeout/releases/download/v1.1.1/timeout-macos-universal.tar.gz"
  sha256 "998692105842a4203bbe6d6f29684f48fe1d741b11531fc40e176235df5ec637"

  depends_on :macos

  def install
    bin.install "timeout"
    bash_completion.install "completions/timeout.bash" => "timeout"
    zsh_completion.install "completions/timeout.zsh" => "_timeout"
    fish_completion.install "completions/timeout.fish"
  end

  test do
    assert_match "timeout", shell_output("#{bin}/timeout --version")
    system bin/"timeout", "5", "true"
    output = shell_output("#{bin}/timeout --json 5 true")
    assert_match '"status":"completed"', output
  end
end
