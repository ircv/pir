function EarthImage

% EarthImage.m - plots the image of the Earth on a globe.
% 
% PROTOTYPE:
%   EarthImage
%
% NO INPUT/OUTPUT NEEDED
%
% NO CALLED FUNCTIONS
% ------------------------------------------------------------------------

%Immagine Terra
npanels=180;
alpha=1;                  % opacità (0 invisibile)                      
GMST0 = 4.89496121282306;
%image_file = 'http://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Land_ocean_ice_2048.jpg/1024px-Land_ocean_ice_2048.jpg';
image_file = 'Earth.jpg';
erad= 6371.0087714; %[Km]
prad= 6371.0087714; %[Km]
erot= 7.2921158553e-5; %[rad/s]
%figure('Color',);
% set(gca, 'NextPlot','add', 'Visible','off');
 axis equal;
 axis auto;
[x, y, z] = ellipsoid(0, 0, 0, erad, erad, prad, npanels);
globe = surf(x, y, -z, 'FaceColor', 'none', 'EdgeColor', 0.5*[1 1 1]);
if ~isempty(GMST0)
    hgx = hgtransform;
    set(hgx,'Matrix', makehgtform('zrotate',GMST0));
    set(globe,'Parent',hgx);
end
cdata = imread(image_file);
set(globe, 'FaceColor', 'texturemap', 'CData', cdata, 'FaceAlpha', alpha, 'EdgeColor', 'none');
grid on
end