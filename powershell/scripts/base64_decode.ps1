<#
.SYNOPSIS
This script allows you to encode or decode content and save it to a file.

.DESCRIPTION
This script provides the ability to encode or decode content using Base64 encoding and save the result to a file with the specified encoding.

.PARAMETER --encoding
Specifies the encoding for the output file. Default is UTF8. Supported encodings are: UTF8, UTF7, UTF32, ASCII, Unicode, Default.

.PARAMETER --output
Specifies the path and filename for the output file.

.PARAMETER --decode
Use this flag to decode the content from the input file and save it to the output file.

.PARAMETER --encode
Use this flag to encode the content from the input file and save it to the output file.

.EXAMPLE
To encode the content of input.txt and save it to encoded.txt:
.\script.ps1 --encode --output encoded.txt input.txt

.EXAMPLE
To decode the content of encoded.txt and save it to decoded.txt:
.\script.ps1 --decode --output decoded.txt encoded.txt

#>

param (
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$arguments
)

# Rest of the script...


param (
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$arguments
)

# Define default values
$encoding = "UTF8"
$outputFile = $null
$decode = $true

# Parse arguments
foreach ($arg in $arguments) {
    if ($arg -match "^--encoding$") {
        # Check for an encoding flag (--encoding)
        $encoding = $arguments[($arguments.IndexOf($arg) + 1)]
    } elseif ($arg -match "^--output$") {
        # Check for an output file flag (--output)
        $outputFile = $arguments[($arguments.IndexOf($arg) + 1)]
    } elseif ($arg -match "^--decode$") {
        # Check for a decode flag (--decode)
        $decode = $true
    } else {
        # Assume this is the content
        $content = $arg
    }
}

    # Check if decoding is requested
if ($decode) {
    $decodedContentBytes = [Convert]::FromBase64String($content)
    $decodedContent = [Text.Encoding]::UTF8.GetString($decodedContentBytes)
    Write-Host "Decoded content: $decodedContent"
    
    # Check if an output file is provided
    if ($outputFile) {
        # Validate the encoding parameter
        $supportedEncodings = @("UTF8", "UTF7", "UTF32", "ASCII", "Unicode", "Default")
        if ($supportedEncodings -notcontains $encoding) {
            Write-Host "Invalid encoding specified. Supported encodings are: $($supportedEncodings -join ', ')"
            exit 1
        }

        # Save the content to the file with the specified encoding
        $decodedContent | Out-File -FilePath $outputFile -Encoding $encoding

        Write-Host "Content saved to $outputFile with $encoding encoding."
        }

}