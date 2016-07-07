# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop'; # stop on all errors


$packageName= 'teamcity-vstest-customlogger' # arbitrary name for the package, used in messages
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.intellij.net/pub/.teamcity/vstest.console/Hajipur-9.1.x/VSTest.TeamCityLogger.zip' # download url

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url

  silentArgs    = ""

  validExitCodes= @(0) #please insert other valid exit codes here

  softwareName  = 'teamcity-vstest-customlogger*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = '87D0B10B4430B59C9E0ABA8D61458A66'
  checksumType  = 'md5'
}

$programFiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]

foreach ($version in @("14.0", "12.0", "11.0")) {
    $extensionsDirectory = "{0}\Microsoft Visual Studio {1}\Common7\IDE\CommonExtensions\Microsoft\TestWindow\Extensions" -f $programFiles, $version

    if (Test-Path $extensionsDirectory) {

        $packageArgs.unzipLocation = $extensionsDirectory

        Install-ChocolateyZipPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
    }
}



