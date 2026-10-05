%% Exportar diagramas del pendulo sin ejecutar el modelo
% Colocar junto a pendulo_qube3_lqr.slx (o qs3_lqr_ctrl.slx).
% Requiere MATLAB/Simulink y bibliotecas QUARC del modelo.
% No exporta senales de Scopes: esas necesitan datos de una ejecucion.
carpeta = fileparts(mfilename('fullpath'));
archivo = fullfile(carpeta,'pendulo_qube3_lqr.slx');
if ~isfile(archivo)
    archivo = fullfile(carpeta,'qs3_lqr_ctrl.slx');
end
assert(isfile(archivo),'Coloca el SLX junto a este script.');
[~,modelo] = fileparts(archivo);
destino = fullfile(carpeta,'diagramas_pendulo');
if ~isfolder(destino), mkdir(destino); end
load_system(archivo);
sistemas = {modelo, ...
    [modelo '/Qube With Pendulum'], ...
    [modelo '/Qube With Pendulum/Counts to Angles'], ...
    [modelo '/Qube With Pendulum/State X']};
nombres = {'01_modelo_general','02_planta_y_observador', ...
    '03_conversion_encoders','04_estados_y_velocidades'};
for k = 1:numel(sistemas)
    try
        open_system(sistemas{k});
        print(['-s' sistemas{k}],'-dpng','-r300', ...
            fullfile(destino,[nombres{k} '.png']));
        fprintf('Exportado: %s\n',nombres{k});
    catch ME
        warning('No se pudo exportar %s: %s',sistemas{k},ME.message);
    end
end
fprintf('Revisa las imagenes en: %s\n',destino);
% El modelo permanece abierto. No se llama a sim, QUARC Start ni save_system.
