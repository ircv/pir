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
addpath('C:\Users\Robin\Documents\SUPAERO\pir\computation');
addpath('C:\Users\Robin\Documents\SUPAERO\pir\data');
addpath('C:\Users\Robin\Documents\SUPAERO\pir\derivatives');
addpath('C:\Users\Robin\Documents\SUPAERO\pir\differential correction');
addpath('C:\Users\Robin\Documents\SUPAERO\pir\initialization');
addpath('C:\Users\Robin\Documents\SUPAERO\pir\ode');
addpath('C:\Users\Robin\Documents\SUPAERO\pir\plot');
addpath('C:\Users\Robin\Documents\SUPAERO\pir\richardson');


%% adding data
load halo_init_matrix_EML1;
load halo_init_matrix_EML2;
load nro_init_EML1;
load nro_init_EML2;

%% constants init
cst=constants_init();
default=parameters_default_init(cst);

