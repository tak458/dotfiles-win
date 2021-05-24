# import .env file
function Import-DotEnv {
    Get-ChildItem (Get-Location) -File ".env" |
    ForEach-Object { 
        Write-Host "Loading $_"
        Get-Content $_
    } |
    ForEach-Object {
        $key, $value = $_.split('=', 2);
        Invoke-Expression "`$env:$key='$value'"
        Write-Host "Loaded `$env:$key='$value'"
    }
}
