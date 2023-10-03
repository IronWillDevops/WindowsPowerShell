param (
    [Parameter(Mandatory=$true, Position=1)]
    $To,
    [Parameter(Mandatory=$true, Position=2)]
    $Subject,
    [Parameter(Mandatory=$true, Position=3)]
    $Body,
    [Parameter(Mandatory=$false, Position=4)]
    $Priority,
    [Parameter(Mandatory=$false, Position=5)]
    $BodyAsHtml


)
if (-not $Priority) {
    $Priority = "Normal"
}

$From = "From@exmaple.com"
$Password = "Password" | ConvertTo-SecureString -AsPlainText -Force
$SMTPServer = "smtp.example.com"
$SMTPPort = "587"

$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password
$Data = $(Get-Date -Format g)
$ErrorVariable = $null
if($BodyAsHtml)
{
    Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body  -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential $Credential -Priority $Priority -Encoding 'UTF8'  -ErrorVariable ErrorVariable -BodyAsHtml 
}
else 
{
    Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body  -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential $Credential -Priority $Priority -Encoding 'UTF8'  -ErrorVariable ErrorVariable 
}
if ($ErrorVariable) { 
    Write-Host "Ошибка отправки сообщения $To : $($ErrorVariable[0].Exception.Message)"
} else {
    Write-Host "[$Data] Сообщение $To успешно отправлено"
}
