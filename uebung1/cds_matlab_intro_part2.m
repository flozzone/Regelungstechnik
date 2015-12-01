%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Einf�hrung in Matlab/Simulink
% 
% Regelungstechnik �bung
% Institut f�r Automatisierungstechnik 
% Gruppe f�r komplexe dynamische Systeme
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Diese Musterfile dient zum Erlernen der grafischen Ausgabem�glichkeiten
% unter Matlab

clear all
close all
clc

%% Einfache 2dimensionale plots

% Erzeugen der Daten

x = 0:.1:2*pi;
y = sin(2*x).*exp(-x/pi);


figure(1)   % �ffnet eine Figure-Umgebung

plot(x,y)   % einfacher plot-Befehl

grid on     % Es werden Gitternetzlinien angegeben

% Hinzuf�gen eines zweiten Datensatzes

y1 = cos(2*x).*exp(-x/pi);

hold on     % Die dargestellten Elemente werden beibehalten

% Die zweite Kurve wird rot und mit dickerer Strichst�rke dargestellt
plot(x,y1,'red','LineWidth',2) 


legend('Kurve 1','Kurve 2')  % Hinzuf�gen einer Legende

axis([0 5 -0.7 1.2])  % Der Darstellungsbereich wird eingegrenzt

% Zus�tzlich ist die Einstellung einer Vielzahl von Parametern im Plot
% m�glich. Einerseits kann dies direkt in der grafischen Oberfl�che
% erfolgen, andererseits mit den Befehlen get und set.

get(gca)  % gca steht f�r 'get current axis'
set(gca, 'FontName', 'Arial', 'FontSize', 14) % Schriftart und -gr��e �ndern


xlabel('Zeit in s', 'FontName', 'Arial', 'FontSize', 14)       % x-Achsen-Beschriftung
ylabel('Amplitude in V', 'FontName', 'Arial', 'FontSize', 14)  % y-Achsen-Beschriftung
title('Spannungsverlauf', 'FontName', 'Arial', 'FontSize', 14) % Beschriftung des Titels

%% Unterschiedliche Darstellung der Linien

close all

x = 0:.1:2*pi;
y = sin(2*x).*exp(-x/pi);

figure 

plot(x,y,'k.')    % Plot in schwarz mit Punkten
hold on
grid on
plot(x,1.5*y,'bo')    % Plot in blau mit Kreisen
plot(x,2*y,'c*')      % Plot in cyan mit Sternen
plot(x,2.5*y,'g+')    % Plot in gr�n mit Kreuzen
plot(x,3*y,'r:')      % Plot in rot punktiert
plot(x,3.5*y,'m--')   % Plot in magenta gestrichelt
plot(x,4*y,'y-.')     % Plot in gelb strichpunktiert


% Weitere Plots

figure

loglog(x,abs(y))      % Doppellogarithmischer plot
grid on

figure

polar(0:.1:10,0:.1:10) % Polarplot

% Erstellen von Subplots

figure
subplot(2,1,1)        % Subplot erzeugen
plot(x,y)
grid on
subplot(2,1,2)        % Zugriff auf zweites Fenster
plot(x,2*y)
grid on
suptitle('Dies is ein Super-Titel');

%% Dreidimensionale Plots

clear all
close all
clc

x = 0:0.01:1;

% Darstellung einer Linie im Raum

plot3(sin(x*4*pi),cos(x*4*pi),x,'LineWidth',2)
box on   % Hinzuf�gen einer Box
grid on  % Hinzuf�gen von Gitternetzlinien

% Darstellung von Fl�chen

[xx,yy] = meshgrid(x,x);  % Koordinatenmatrix erzeugen

zz = sin(4*pi*xx).*cos(4*pi*yy).*exp(-xx); % Darzustellende Funktion

% Fl�chenplot
figure
surf(xx,yy,zz)
box on
shading interp      %  3D-Fl�chen ohne Gitternetzlinien
grid on

% Gitterplot
figure
mesh(xx,yy,zz)
box on
grid on

% 2D Konturplot
figure
contour(xx,yy,zz)
box on
grid on





