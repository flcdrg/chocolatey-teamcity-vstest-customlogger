$ErrorActionPreference = 'Stop'; 

$packageName= 'teamcity-vstest-customlogger' 

# Borrowed from Uninstall-ChocolateyZipPackage, but because we may be installed in multiple locations we uninstall manually
$packagelibPath=$env:chocolateyPackageFolder

$zipContentFile=(join-path $packagelibPath 'VSTest.TeamCityLogger.zip') + ".txt"
if ((Test-Path -path $zipContentFile)) {
    $zipContentFile
    $zipContents=(get-content $zipContentFile)

    $programFiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]

    foreach ($version in @("14.0", "12.0", "11.0")) {
        $extensionsDirectory = "{0}\Microsoft Visual Studio {1}\Common7\IDE\CommonExtensions\Microsoft\TestWindow\Extensions\" -f $programFiles, $version

        if (Test-Path $extensionsDirectory) {

            foreach ($fileInZip in $zipContents) {
                if ($fileInZip -and $fileInZip -ne "") {
                    $filename = [IO.Path]::GetFileName($fileInZip)

                    $fullPath = [IO.Path]::Combine($extensionsDirectory, $filename)

                    Write-Debug "Deleting $fullPath"

                    remove-item -Path "$fullPath" -ErrorAction SilentlyContinue -Force
                }
            }
        }
    }
}