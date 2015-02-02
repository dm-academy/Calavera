# final production build

remote_file "/tmp/CalaveraMain" do
  source "http://192.168.33.13:8081/artifactory/ext-release-local/Calavera/target/CalaveraMain.jar"
  mode '0755'
  #checksum "3a7dac00b1" # A SHA256 (or portion thereof) of the file.
end