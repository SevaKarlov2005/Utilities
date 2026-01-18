#!/usr/bin/env bash

# Запись в файл
print_in_file()
{	
	# Директория вызова
	start_dir=$(pwd)
	
	# Переход в директорию чтения
	cd "$2"
	
	# Массив файлов для чтения
	files=($1)
	
	# Переход в начальную директорию
	cd "$start_dir"
	
	# Создание или очистка файла для записи
	> "$3"
	
	# Запись содержимого в файл
	for file in "${files[@]}"; do
		echo "Файл $file" >> "$3"
		cat "$2/$file" >> "$3"
		echo "" >> "$3"
	done
}

# Выбор функции
choose_function()
{
	if [[ $# -eq 1 && "$1" == "help" ]]; then
		echo "FILESPRINTER ВЕРСИЯ 1.0"
		echo 'Инструкция по работе:'
		echo 'filesprinter help - Вызов инструкции по использованию;'
		echo 'filesprinter flprint "<шаблон>" <директория_откуда> <путь_к_файлу_куда> - Извлечение содержимого в файл;'
	elif [[ $# -eq 4 && "$1" == "flprint" ]]; then
		print_in_file "$2" "$3" "$4"
	else
		echo "Вызова с таким набором параметров нет!"
		echo "Используйте 'filesprinter help' для чтения инструкции!"
	fi
}

# Вызов выбора
choose_function "$@"