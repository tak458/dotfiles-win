function Get-EpochTime {
    param (
        [System.DateTime]$dt = (Get-Date)
    )
    $start = Get-Date "1970/01/01T00:00:00Z"
    (New-TimeSpan -Start ($start) -End ($dt)).TotalSeconds

}

function Get-EpochTimeMilli {
    param (
        [System.DateTime]$dt = (Get-Date)
    )
    (Get-EpochTime $dt) * 1000
}
