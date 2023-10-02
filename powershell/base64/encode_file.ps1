# base64 encode text from a file

$bytes = [System.IO.File]::ReadAllBytes($args[0])
$encodedText =[Convert]::ToBase64String($bytes)
$encodedText

