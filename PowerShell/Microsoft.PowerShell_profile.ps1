# Terminal Encoding UTF-8
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$global:OutputEncoding = [System.Text.Encoding]::UTF8
[console]::OutputEncoding = [System.Text.Encoding]::UTF8
