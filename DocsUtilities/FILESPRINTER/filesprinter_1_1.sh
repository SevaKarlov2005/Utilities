#!/usr/bin/env bash

# Проверка возможности создать файл для записи
check_file_path()
{
	local path=$(dirname "$1")
	
	if [[ -d "$path" ]]; then
		return 0
	else
		echo "Не получилось создать файл для записи!"
		return 1
	fi
}

# Проверка наличия директории
check_dir_path()
{
	if [[ -d "$1" ]]; then
		return 0
	else
		echo "Отсутствует директория для чтения файлов!"
		return 1
	fi
}

# Запись в файл
print_in_file()
{	
	# Директория вызова
	local start_dir=$(pwd)
	
	# Переход в директорию чтения
	cd "$2"
	
	# Подключение пустого списка при отсутствии файлов по шаблону
	shopt -s nullglob
	
	# Массив файлов для чтения
	local files=($1)
	
	# Отключение пустого списка при отсутствии файлов по шаблону
	shopt -u nullglob
	
	# Переход в начальную директорию
	cd "$start_dir"
	
	# Проверка пустоты массива
	if [[ ${#files[@]} -eq 0 ]]; then
		echo "Нет файлов, удовлетворяющих шаблону!"
	else
		# Создание или очистка файла для записи
		> "$3"
		
		# Запись содержимого в файл
		for file in "${files[@]}"; do
			echo "Файл $file" >> "$3"
			cat "$2/$file" >> "$3"
			printf "\n\n" >> "$3"
		done
	fi
}

# Выбор функции
choose_function()
{
	if [[ $# -eq 1 && "$1" == "help" ]]; then
		echo "FILESPRINTER ВЕРСИЯ 1.1"
		echo 'Инструкция по работе:'
		echo 'filesprinter help - Вызов инструкции по использованию;'
		echo 'filesprinter flprint "<шаблон>" <директория_откуда> <путь_к_файлу_куда> - Извлечение содержимого в файл;'
	elif [[ $# -eq 4 && "$1" == "flprint" ]]; then
		if check_dir_path "$3" && check_file_path "$4"; then
			print_in_file "$2" "$3" "$4"
		fi
	else
		echo "Вызова с таким набором параметров нет!"
		echo "Используйте 'filesprinter help' для чтения инструкции!"
	fi
}

# Вызов выбора
choose_function "$@"