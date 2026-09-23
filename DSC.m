clear;
close all;
clc;
%Select the folder that contains original TEM images
ruta_carpetaOriginal = uigetdir('','Selecciona la carpeta que contiene las imágenes originales');
%Select the folder that contains automatic TEM images
ruta_carpetaPredict = uigetdir('','Selecciona la carpeta que contiene las imágenes automáticas');
NumArchivos=dir(fullfile(ruta_carpetaOriginal,'.png'));
CoeficienteSimilitudDice=zeros(numel(NumArchivos),1);
disp(['Se seleccionó la carpeta: ' ruta_carpetaOriginal]);
disp(['Se seleccionó la carpeta: ' ruta_carpetaPredict]);
% Filter PNG files only
archivosOriginal = dir(fullfile(ruta_carpetaOriginal, '*.png')); 
archivosPredict = dir(fullfile(ruta_carpetaPredict, '*.png'));
%DSC
for i = 1:numel(archivosOriginal)
    nombreOriginal = archivosOriginal(i).name;
    imagenOriginal = imread(fullfile(ruta_carpetaOriginal, nombreOriginal));
    imagenOriginal= imresize(imagenOriginal,[2048,2048]);
    imagenOriginal= im2gray(imagenOriginal);
    imagenOriginal= imbinarize(imagenOriginal);
    imagenOriginal=logical(imagenOriginal);
    nombrePredict = archivosPredict(i).name;
    imagenPredict = imread(fullfile(ruta_carpetaPredict, nombrePredict));
    imagenPredict=im2gray(imagenPredict);
    imagenPredict= imresize(imagenPredict,[2048,2048]);
    imagenPredict= imbinarize(imagenPredict);
    imagenPredict=logical(imagenPredict);
    similarity= dice(imagenOriginal,imagenPredict);
    CoeficienteSimilitudDice(i,1)=similarity;
end
h=histogram(CoeficienteSimilitudDice);
counts = h.Values;
binEdges = h.BinEdges;
binCenters = binEdges(1:end-1) + diff(binEdges)/2;
text(binCenters,counts,num2str(counts'),HorizontalAlignment="center",VerticalAlignment="bottom")
title('DICE coefficient');
xlabel('DICE Similarity Coefficient (DSC)');
ylabel('Micrographs');
