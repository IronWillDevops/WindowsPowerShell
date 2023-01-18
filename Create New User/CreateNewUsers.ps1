$path=".\NewUsers.csv"
$emailDomain="@domain.com"
$company ="domain.com"
$defaultOU = "OU=Test,OU=Domain Users,DC=domain,DC=com"
$defaultMailQuota = "204800"
$lockAccount =$True
$userMustHaveChangedPassword = $False

Function GenerateDomainPassword ([Parameter(Mandatory=$true)][int]$PassLenght)
{

Add-Type -AssemblyName System.Web
$requirementsPassed = $false
do {
$newPassword=[System.Web.Security.Membership]::GeneratePassword($PassLenght,1)
If ( ($newPassword -cmatch "[A-Z\p{Lu}\s]") `
-and ($newPassword -cmatch "[a-z\p{Ll}\s]") `
-and ($newPassword -match "[\d]") `
-and ($newPassword -match "[^\w]")
)
{
$requirementsPassed=$True
}
} While ($requirementsPassed -eq $false)
return $newPassword
}


Import-Csv $path -Delimiter ';' | ForEach-Object {
$givenName = $_.givenName 
$sn = $_.sn
$displayName = $sn + ", " +$givenName
$sAMAccountName = $_.sAMAccountName
$mail= $givenName  + '.'+$sn +$emailDomain
$Password = GenerateDomainPassword(10)
$telephoneNumber = $_.telephoneNumber
$department = $_.department
$title = $_.title
New-ADUser `
-Name "$givenName $sn" `
-GivenName $givenName `
-Surname $sn `
-DisplayName $displayName `
-Description $sAMAccountName `
-SamAccountName $sAMAccountName `
-State $defaultMailQuota `
-EmailAddress $mail `
-Department $department `
-Title $title `
-Path $defaultOU `
-AccountPassword (ConvertTo-SecureString $Password -AsPlainText -force) `
-ChangePasswordAtLogon $userMustHaveChangedPassword `
-Enabled $lockAccount ` 
Set-ADUser -Identity $sAMAccountName -Replace @{mobile=$telephoneNumber}
Set-ADUser -Identity $sAMAccountName -Replace @{userPrincipalName="$mail"}
Set-ADUser -Identity $sAMAccountName -Replace @{otherMailbox=$mail}
Set-ADUser -Identity $sAMAccountName -Replace @{st=$defaultMailQuota}



echo "User Created Login: $sAMAccountName Password: $Password"
}


