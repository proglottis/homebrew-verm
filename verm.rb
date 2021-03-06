class Verm < Formula
  homepage "https://github.com/willbryant/verm"
  url "https://github.com/willbryant/verm/archive/0.51.tar.gz"
  sha1 "1a2b4ee099b6427758460f45db6884e243e19235"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/willbryant"
    ln_s buildpath, buildpath/"src/github.com/willbryant/verm"
    system "go", "build", "-ldflags", "-X main.compiled_version #{version} -X main.compiled_root_data_directory #{var/'verm'}", "github.com/willbryant/verm"
    bin.install "verm"
    mkdir_p var/"verm"
  end

  test do
    system "make", "test_verm"
  end

  plist_options :manual => "verm"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/verm</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>StandardErrorPath</key>
      <string>#{var}/log/verm.err</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/verm.log</string>
    </dict>
    </plist>
    EOS
  end
end
