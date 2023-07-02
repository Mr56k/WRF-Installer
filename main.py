import os

def execute_command(file_name):   
    command = f"ncl \'filename=\"{file_name}.nc\"\' shapefile.ncl"   # Ersetze "your_shell_command" durch dein gewünschtes Shell-Kommando
    os.system(command)

def process_files():
    current_directory = os.getcwd()
    for file_name in os.listdir(current_directory):
        if file_name.startswith("wrfout"):
            execute_command(file_name)

# Beispielaufruf
process_files()
