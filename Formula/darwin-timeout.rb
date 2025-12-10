# typed: false
# frozen_string_literal: true

class DarwinTimeout < Formula
  desc "Run a command with a time limit (GNU timeout clone for Darwin/Apple platforms)"
  homepage "https://github.com/denispol/darwin-timeout"
  version "1.3.0"
  license "MIT"

  url "https://github.com/denispol/darwin-timeout/releases/download/v1.3.0/timeout-macos-universal.tar.gz"
  sha256 "a605b28824e89192b0860f703a0d560321ce57126f93f67b27a48c3828ec4216"

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
