# typed: false
# frozen_string_literal: true

class Procguard < Formula
  desc "Formally verified process supervisor for macOS with resource limits"
  homepage "https://github.com/denispol/procguard"
  version "1.5.0"
  license "MIT"

  url "https://github.com/denispol/procguard/releases/download/v1.5.0/procguard-macos-universal.tar.gz"
  sha256 "PLACEHOLDER_HASH"  # Update after release build

  depends_on :macos

  def install
    bin.install "procguard"
    bin.install "timeout"
    bash_completion.install "completions/procguard.bash" => "procguard"
    zsh_completion.install "completions/procguard.zsh" => "_procguard"
    fish_completion.install "completions/procguard.fish"
  end

  def caveats
    <<~EOS
      Both 'procguard' and 'timeout' commands are now available.

      procguard (default: wall clock, survives sleep):
        procguard 30s ./command

      timeout (default: active time, GNU-compatible):
        timeout 30s ./command

      For more information:
        https://github.com/denispol/procguard
    EOS
  end

  test do
    assert_match "procguard", shell_output("#{bin}/procguard --version")
    assert_match "timeout", shell_output("#{bin}/timeout --version")
    system bin/"procguard", "5s", "true"
    output = shell_output("#{bin}/procguard --json 5s true")
    assert_match '"status":"completed"', output
    assert_match '"schema_version":8', output
  end
end