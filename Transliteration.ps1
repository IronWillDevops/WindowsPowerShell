Param (
[string]$Text,
[string]$Language = "UA"
)

#Функция транслитерации
$Result= $null
$Table = $null
#Создаем хэш-таблицу соответствия символов
$TranslitUA = @{

[char]'а' = "a"
[char]'А' = "A"
[char]'б' = "b"
[char]'Б' = "B"
[char]'в' = "v"
[char]'В' = "V"
[char]'г' = "h"
[char]'Г' = "H"
[char]'ґ' = "g"
[char]'Ґ' = "G"
[char]'д' = "d"
[char]'Д' = "D"
[char]'е' = "e"
[char]'Е' = "E"
[char]'є' = "ie"
[char]'Є' = "Ye"
[char]'ж' = "zh"
[char]'Ж' = "Zh"
[char]'з' = "z"
[char]'З' = "Z"
[char]'и' = "y"
[char]'И' = "Y"
[char]'і' = "i"
[char]'І' = "I"
[char]'ї' = "i"
[char]'Ї' = "Yi"
[char]'к' = "k"
[char]'К' = "K"
[char]'л' = "l"
[char]'Л' = "L"
[char]'м' = "m"
[char]'М' = "M"
[char]'н' = "n"
[char]'Н' = "N"
[char]'о' = "o"
[char]'О' = "O"
[char]'п' = "p"
[char]'П' = "P"
[char]'р' = "r"
[char]'Р' = "R"
[char]'с' = "s"
[char]'С' = "S"
[char]'т' = "t"
[char]'Т' = "T"
[char]'у' = "u"
[char]'У' = "U"
[char]'ф' = "f"
[char]'Ф' = "F"
[char]'х' = "kh"
[char]'Х' = "Kh"
[char]'ц' = "ts"
[char]'Ц' = "Ts"
[char]'ч' = "ch"
[char]'Ч' = "Ch"
[char]'ш' = "sh"
[char]'Ш' = "Sh"
[char]'щ' = "shch"
[char]'Щ' = "Shch"
[char]'ь' = ""
[char]'Ь' = ""
[char]'ю' = "iu"
[char]'Ю' = "Yu"
[char]'я' = "ia"
[char]'Я' = "Ya"
[char] "'" = ""



}
$TranslitRU = @{

[char]'а' = "a"
[char]'А' = "A"
[char]'б' = "b"
[char]'Б' = "B"
[char]'в' = "v"
[char]'В' = "V"
[char]'г' = "g"
[char]'Г' = "G"
[char]'д' = "d"
[char]'Д' = "D"
[char]'е' = "e"
[char]'Е' = "E"
[char]'ё' = "e"
[char]'Ё' = "E"
[char]'ж' = "zh"
[char]'Ж' = "Zh"
[char]'з' = "z"
[char]'З' = "Z"
[char]'и' = "i"
[char]'И' = "I"
[char]'й' = "y"
[char]'Й' = "Y"
[char]'к' = "k"
[char]'К' = "K"
[char]'л' = "l"
[char]'Л' = "L"
[char]'м' = "m"
[char]'М' = "M"
[char]'н' = "n"
[char]'Н' = "N"
[char]'о' = "o"
[char]'О' = "O"
[char]'п' = "p"
[char]'П' = "P"
[char]'р' = "r"
[char]'Р' = "R"
[char]'с' = "s"
[char]'С' = "S"
[char]'т' = "t"
[char]'Т' = "T"
[char]'у' = "u"
[char]'У' = "U"
[char]'ф' = "f"
[char]'Ф' = "F"
[char]'х' = "kh"
[char]'Х' = "Kh"
[char]'ц' = "ts"
[char]'Ц' = "Ts"
[char]'ч' = "ch"
[char]'Ч' = "Ch"
[char]'ш' = "sh"
[char]'Ш' = "Sh"
[char]'щ' = "sch"
[char]'Щ' = "Sch"
[char]'ъ' = ""
[char]'Ъ' = ""
[char]'ы' = "y"
[char]'Ы' = "Y"
[char]'ь' = ""
[char]'Ь' = ""
[char]'э' = "e"
[char]'Э' = "E"
[char]'ю' = "yu"
[char]'Ю' = "Yu"
[char]'я' = "ya"
[char]'Я' = "Ya"
[char]' ' = " " #пробел

}

Switch ($Language)
{
"UA" {$Table = $TranslitUA;Break}
"RU" {$Table = $TranslitRU;Break}

  Default {$Table = $TranslitUA}
}



$chars = $Text.ToCharArray();

foreach ($char in $chars) 
{
if( $Table[$char] -cne $null)
    {$Result += $Table[$char]}
else 
    {$Result +=$char}
}



"$Result" 




