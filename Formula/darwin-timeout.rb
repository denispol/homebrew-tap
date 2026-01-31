# typed: false
# frozen_string_literal: true

class DarwinTimeout < Formula
  desc "GNU timeout for macOS (renamed to procguard)"
  homepage "https://github.com/denispol/procguard"
  version "1.5.0"
  license "MIT"

  deprecate! date: "2026-01-31", because: "has been renamed to procguard"

  url "https://github.com/denispol/procguard/releases/download/v1.5.0/procguard-macos-universal.tar.gz"
  sha256 "PLACEHOLDER_HASH"  # Same hash as procguard.rb

  depends_on :macos

  def install
    # Install both binaries for backward compatibility
    bin.install "procguard"
    bin.install "timeout"
    bash_completion.install "completions/procguard.bash" => "procguard"
    zsh_completion.install "completions/procguard.zsh" => "_procguard"
    fish_completion.install "completions/procguard.fish"
  end

  def caveats
    <<~EOS
      ⚠️  darwin-timeout has been renamed to procguard!

      Please migrate to the new formula:
        brew uninstall darwin-timeout
        brew install denispol/tap/procguard

      Both 'procguard' and 'timeout' commands are available.
      See: https://github.com/denispol/procguard
    EOS
  end

  test do
    system bin/"timeout", "5s", "true"
    system bin/"procguard", "5s", "true"
  end
end