$encoded_secret = $args[0]

#base64 decode a string
$bytes = [System.Convert]::FromBase64String($encoded_secret)
$decodedText=[System.Text.Encoding]::UTF8.GetString($bytes)
$decodedText
