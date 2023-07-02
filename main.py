import os
import subprocess

def execute_command(file_name):
    new_line = 'filename = "' + file_name + '.nc"'
    line_number = 2
    command = f"sed -i '{line_number}s/.*/{new_line}/' shapefile.ncl"
    subprocess.run(command, shell=True)
    
    new_line = 'cmd = "magick Bodentemperatur.png ' + file_name + '.gif"'
    line_number = 57
    command = f"sed -i '{line_number}s/.*/{new_line}/' shapefile.ncl"
    subprocess.run(command, shell=True)
    
    command = f"ncl shapefile.ncl"   # Ersetze "your_shell_command" durch dein gewünschtes Shell-Kommando
    os.system(command)

def process_files():
    current_directory = os.getcwd()
    for file_name in os.listdir(current_directory):
        if file_name.startswith("wrfout"):
            execute_command(file_name)

# Beispielaufruf
process_files()
