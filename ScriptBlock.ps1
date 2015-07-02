Invoke-WebRequest http://www.ipdeny.com/ipblocks/data/countries/br.zone -OutFile br.zone
Invoke-WebRequest http://www.ipdeny.com/ipblocks/data/countries/cn.zone -OutFile cn.zone
Invoke-WebRequest http://www.ipdeny.com/ipblocks/data/countries/ua.zone -OutFile ua.zone

$ips = Get-Content br.zone, cn.zone, ua.zone
Remove-NetFirewallRule -DisplayName 'ScriptBlock'

while ($ips.length -gt 1)
{
	$chunkLen = (1000, $ips.length | Measure -Min).Minimum
	$chunk    = $ips[0..($chunkLen-1)]
	$ips      = $ips[1000..($ips.length-1)]

	New-NetFirewallRule -DisplayName 'ScriptBlock' -Action Block -RemoteAddress $chunk
}
