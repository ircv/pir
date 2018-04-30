%INITIALIZZATION 

%% add folders necessary for the computation
% addpath('C:\Users\irene\OneDrive\Documenti\ISAE\PIR\pir1\computation');
% addpath('C:\Users\irene\OneDrive\Documenti\ISAE\PIR\pir1\data');
% addpath('C:\Users\irene\OneDrive\Documenti\ISAE\PIR\pir1\derivatives');
% addpath('C:\Users\irene\OneDrive\Documenti\ISAE\PIR\pir1\differential correction');
% addpath('C:\Users\irene\OneDrive\Documenti\ISAE\PIR\pir1\initialization');
% addpath('C:\Users\irene\OneDrive\Documenti\ISAE\PIR\pir1\ode');
% addpath('C:\Users\irene\OneDrive\Documenti\ISAE\PIR\pir1\plot');
% addpath('C:\Users\irene\OneDrive\Documenti\ISAE\PIR\pir1\richardson');
addpath('C:\Users\Robin\Documents\SUPAERO\2A\PIR\pir-source\computation');
addpath('C:\Users\Robin\Documents\SUPAERO\2A\PIR\pir-source\data');
addpath('C:\Users\Robin\Documents\SUPAERO\2A\PIR\pir-source\derivatives');
addpath('C:\Users\Robin\Documents\SUPAERO\2A\PIR\pir-source\differential correction');
addpath('C:\Users\Robin\Documents\SUPAERO\2A\PIR\pir-source\initialization');
addpath('C:\Users\Robin\Documents\SUPAERO\2A\PIR\pir-source\ode');
addpath('C:\Users\Robin\Documents\SUPAERO\2A\PIR\pir-source\plot');
addpath('C:\Users\Robin\Documents\SUPAERO\2A\PIR\pir-source\richardson');


%% adding data
load halo_init_matrix_EML1;
load halo_init_matrix_EML2;
load nro_init_EML1;
load nro_init_EML2;

%% constants init
cst=constants_init();
default=parameters_default_init(cst);

