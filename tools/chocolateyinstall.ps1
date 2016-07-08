$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName= 'teamcity-vstest-customlogger'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.intellij.net/pub/.teamcity/vstest.console/Hajipur-9.1.x/VSTest.TeamCityLogger.zip'

$packageArgs = @{
  url           = $url
  silentArgs    = ""
  validExitCodes= @(0) 
  softwareName  = 'teamcity-vstest-customlogger*' 
  checksum      = '87D0B10B4430B59C9E0ABA8D61458A66'
  checksumType  = 'md5'
}

$programFiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]

foreach ($version in @("14.0", "12.0", "11.0")) {
    $extensionsDirectory = "{0}\Microsoft Visual Studio {1}\Common7\IDE\CommonExtensions\Microsoft\TestWindow\Extensions" -f $programFiles, $version

    if (Test-Path $extensionsDirectory) {

        $packageArgs.unzipLocation = $extensionsDirectory
        $packageArgs.packageName = "$packageName-$version"

        Install-ChocolateyZipPackage @packageArgs
    }
}
