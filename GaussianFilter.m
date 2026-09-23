clear;
close all;
clc;
%Select the folder that contains TEM images
ruta_carpeta = uigetdir('','Selecciona la carpeta que contiene las imágenes');
if ruta_carpeta == 0
       disp('No se seleccionó ninguna carpeta.');
    return;
end
disp(['Se seleccionó la carpeta: ' ruta_carpeta]);
% Filter PNG files only
archivos = dir(fullfile(ruta_carpeta, '*.png')); % Filter PNG files only

% Iterate over each file in the folder
for i = 1:numel(archivos)
    nombre_archivo = archivos(i).name;
    imagen = imread(fullfile(ruta_carpeta, nombre_archivo));
    imagen_filtrada = imgaussfilt(imagen, 2);
    figure;
    imshow(imagen_filtrada);
    [~, nombre_sin_extension, ~] = fileparts(nombre_archivo);
    nuevo_nombre = [nombre_sin_extension 'G.png'];
    exportgraphics(gcf, fullfile(ruta_carpeta, nuevo_nombre), 'Resolution', 431);
    close(gcf);
end