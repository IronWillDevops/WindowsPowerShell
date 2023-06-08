# Задаем имена OU, которые нужно создать
$sites = "Sites"
$city = "KHA"
$descriptioncity="Place in Kharkiv"
$OUs = @(
"Workstations",
"Contacts",
"Groups",
"Users"
)
# Подключаемся к Active Directory
Import-Module ActiveDirectory

# Создаем структуру OU в Active Directory
New-ADOrganizationalUnit -Name "$sites" 
$newOU=New-ADOrganizationalUnit -Name "$city" -Path "OU=$sites,DC=itkha,DC=domain" -Description "$descriptioncity" -PassThru

Write-Output $newOU

ForEach ($OU In $OUs) {
New-ADOrganizationalUnit -Name $OU -Path $newOU
}
