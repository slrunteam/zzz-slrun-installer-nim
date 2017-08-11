import httpclient, os, strutils
import miniz
import config

# Initialize
var homeDir = expandTilde("~" / "." & config.appName)
var version = "latest"
stdout.write("Installation path [" & homeDir & "]: ")
let homeDirInput = stdin.readline()
if homeDirInput != "":
  homeDir = homeDirInput
stdout.write("Version [" & version & "]: ")
let versionInput = stdin.readline()
if versionInput != "":
  version = versionInput
var downloadUrl = config.downloadUrl.replace("{version}", version)
downloadUrl = downloadUrl.replace("{env}", hostOS)

# Install
const zipFile = getTempDir() & "slrun.zip"
let client = newHttpClient()
echo("Installing...")
client.downloadFile(downloadUrl, zipFile)
miniz.unzip(zipFile, homeDir)
removeFile(zipFile)
echo("Finished")