cask "openemu-arm" do
  version "2.4.1-ARM"
  sha256 '176d081952949fd11b483ae5515ca04436fea85bdfe6516ca9bcf4a420975b72'

  url "https://github.com/Azyzraissi/OpenEmu/releases/download/2.4.1-ARM/OpenEmu-2.4.1-ARM64.zip"
  name "OpenEmu ARM"
  desc "Retro video game emulation for macOS (ARM build)"
  homepage "https://github.com/Azyzraissi/OpenEmu"

  app "OpenEmu.app"

  # Download and extract cores
  postflight do
    cores_path = "#{Dir.home}/Library/Application Support/OpenEmu"
    cores_zip_path = "#{staged_path}/Cores.zip"
    
    # Create the Cores directory if it doesn't exist
    system_command "/bin/mkdir", args: ["-p", cores_path]
    
    # Download Cores.zip
    system_command "/usr/bin/curl", args: [
      "-L", 
      "https://github.com/Azyzraissi/OpenEmu/releases/download/2.4.1-ARM/Cores.zip",
      "-o", cores_zip_path
    ]
    
    # Extract Cores.zip to the Cores directory
    system_command "/usr/bin/unzip", args: [
      "-o",
      cores_zip_path,
      "-d", cores_path
    ]
    
    # Clean up the downloaded zip file
    system_command "/bin/rm", args: [cores_zip_path]
  end

  zap trash: [
    "~/Library/Application Support/OpenEmu",
    "~/Library/Caches/org.openemu.OpenEmu",
    "~/Library/Preferences/org.openemu.OpenEmu.plist",
    "~/Library/Saved Application State/org.openemu.OpenEmu.savedState"
  ]
end
