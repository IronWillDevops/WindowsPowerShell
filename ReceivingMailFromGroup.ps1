# Импортируем модуль Active Directory
Import-Module ActiveDirectory

# Задаем имя группы доступа
$groupName = "GROUP_NAME"

# Задаем FQDN домена Active Directory
$domainFQDN = "domain.com"



# Получаем объект группы с указанием домена Active Directory
$group = Get-ADGroup -Identity $groupName -Server $domainFQDN

if ($group) {
    # Получаем всех пользователей в группе с указанием домена Active Directory
    $groupMembers = Get-ADGroupMember -Identity $group -Server $domainFQDN

    # Фильтруем только пользователей (исключаем другие объекты, такие как группы и компьютеры)
    $users = $groupMembers | Where-Object { $_.objectClass -eq "user" }

    if ($users) {
        foreach ($user in $users) {
            # Получаем свойства пользователя, включая почтовый адрес
            $userProperties = Get-ADUser -Identity $user -Properties EmailAddress -Server $domainFQDN

            if ($userProperties.EmailAddress) {
                Write-Output "$($userProperties.Name) <$($userProperties.EmailAddress)>"
            } else {
                Write-Output "$($userProperties.Name) - Почтовый адрес не указан"
            }
        }
    } else {
        Write-Output "В группе '$groupName' в домене '$domainFQDN' нет пользователей."
    }
} else {
    Write-Output "Группа '$groupName' не найдена в домене '$domainFQDN'."
}
