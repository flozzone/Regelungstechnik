%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Einf�hrung in Matlab/Simulink
% 
% Regelungstechnik �bung
% Institut f�r Automatisierungstechnik 
% Gruppe f�r komplexe dynamische Systeme
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% In diesem Musterfile wird haupts�chlich die Funktionalit�t der Control
% Systems Toolbox (CST) n�her erl�utert. Diese findet vor allem in
% regelungstechnischen Aufgabenstellungen Anwendung.
% Ausgangspunkt f�r die Verwendung der CST ist ein mathematisches Modell
% der betrachteteten Strecke. Im Allgemeinen werden nur lineare
% zeitkontinuierliche und zeitdiskrete Probleme betrachtet.

clear all
close all
clc
%%
help control  % Wichtig: Die Hilfe zur Control Systems Toolbox


%% Erzeugen von Datenobjekten kontinuierlicher Systeme in der CST
% Es wird ein einfaches PT2-Glied betrachtet (siehe Vorlesung AT)

T = 0.5;
xi = 0.2;
V = 2;

% 1. M�glichkeit: �bertragungsfunktion

G_tf = tf([V],[T^2 2*xi*T 1])

% Zugriff auf das Datenobjekt

G_tf.num{1}   % Z�hler
G_tf.den{1}   % Nenner
G_tf.Variable % Variable

% Alternative (ist bevorzugt zu verwenden)

s = tf('s')   % Erzeugen der komplexen Variablen s
G_tf1 = V/(1+2*xi*T*s+s^2*T^2)


% 2. M�glichkeit: �ber Pol-Nullstellen

p1 = (-xi+sqrt(xi^2-1))/T;
p2 = (-xi-sqrt(xi^2-1))/T;
G_zp = zpk([],[p1 p2],V/T^2)

% Zugriff auf das Datenobjekt

G_zp.z{1}   % Nullstellen
G_zp.p{1}   % Polstellen
G_zp.k      % Verst�rkung (aber nicht der Verst�rkungsfaktor V)
G_zp.Variable % Variable


% 3. M�glichkeit: Zustandsraumdarstellung

A = [0 1; -1/T^2 -2*xi/T];
B = [0;V/T^2];
C = [1,0];
D = 0;

sys = ss(A,B,C,D)


% Zugriff auf das Datenobjekt

sys.a   % Dynamikmatrix
sys.b   % Eingangsmatrix
sys.c   % Ausgangsmatrix
sys.d   % Durchschaltmatrix
sys.StateName % Name der Zust�nde


% 4. M�glichkeit FRD-Modelle: Numerische Eingabe von gemessenen
% �bertragungsfunktionen, wird hier nicht n�her betrachet

% Umwandeln der Objekte in andere Darstellungsformen

G_ss2tf = tf(sys)
G_spk2tf = tf(G_zp)

sys_zpk2ss = ss(G_zp)
sys_tf2ss = ss(G_tf)

G_ss2zpk = zpk(sys)
G_tf2zpk = zpk(G_tf)

% Zus�tzliche M�glichkeiten
help ss2tf
help ss2zp
help zp2tf
help zp2ss
help tf2zp
help tf2ss

%% Diskrete Modelle
% Diese k�nnen prinzpiell wie oben erzeugt werden, ledglich muss noch
% eine Abstastzeit vorgegeben werden

Ta = 0.2; % Vorgabe einer Abtastzeit

% Direktes Erzeugen

z = tf('z',Ta)
Gzt = 1/(z-0.5);      % Als �bertragungsfunktion
sysd = ss(1,1,1,0,Ta) % In Zustandsraumdarstellung (hier: Diskreter Integrator)         

% Aus bestehendem kontinuierlichen Modell

Gz = c2d(G_tf,Ta,'zoh')    % Hier wird ein Halteglied nullter Ordnung verwendet
sys_z = c2d(sys,Ta,'zoh')

% Modelle im Tustin Bereich (q-Bereich)

Gq = d2c(Gz,'tustin')
sys_q = d2c(sys_z,'tustin')
%% Modelle mit Totzeiten

G_tzi = tf(1,[1 1],'inputdelay',0.5)   % Eingangsverz�gerung
G_tzo = tf(1,[1 1],'outputdelay',0.5)  % Ausgangsverz�gerung
G_tzio = tf(1,[1 1],'iodelay',0.5)     % Eingangs-Ausgangsverz�gerung


%% Verkn�pfung von Modellen
G2 = 1/s;

Gsum = G_tf+G2    % Summe der Modelle
Gdiff = G_tf-G2   % Differenz der Modelle
Gprod = G_tf*G2   % Hintereinanderschlatung der Modelle
Gfb = feedback(G_tf,G2) % R�ckkopplung

%% Analyse von LTI-Modellen

dcgain(G_tf)    % Verst�rkungsfaktor bestimmen
damp(G_tf)      % Nat�rliche Frequenzen und D�mpfungen
bandwidth(G_tf) % Bandbreite

pole(G_tf)      % Pole der �bertragungsfunktion
zero(G_tf)      % Nullstellen der �bertragunsgfunktion G_tf
zero(Gsum)      % Nullstellen der �bertragunsgfunktion Gsum

pzmap(Gsum)     % Pol-Nullstellendiagramm
grid on

figure
impulse(G_tf,10)    % Impulsantwort f�r 10 Sekunden
hold on
step(G_tf,10)       % Sprungantwort f�r 10 Sekunden
legend('Impulsantwort','Sprungantwort');

% Systemantwort auf beliebiges Eingangssignal

[u,t] = gensig('square',1,10);   % Erzeugung eines Testsignals 
[y,t] = lsim(G_tf,u,t);          % Simulation des Systems mit dem Eingangssignal

figure
plot(t,u,t,y)
grid on
legend('Eingangssignal','Ausgangssignal');

% L�sung im eingeschwungenen Zustand

H = freqresp(G_tf,2)     % Auswertung an der Stelle omega = 2

% Bodediagramm

figure
bode(G_tf)
grid on
[abs,pha,omega] = bode(G_tf); % Auslesen der Daten aus dem Bodediagramm
[abs,pha,omega] = bode(G_tf,2); % Bodediagramm an der Stelle omega = 2

% Nyquistdiagramm

figure
nyquist(G_tf)
grid on

% Minimalrealisierung von Systemen

minreal((s+1)/(s+1)/s)  % Durchf�hren von Pol-Nullstellen-K�rzungen

%%

% Regler- und Beobachterentwurf: In dieser Einf�hrung sollen nur die
% grundlegenden Bergiffe f�r Regler- und Beobachterentwurf genannt werden,
% die Anwendung erfolgt dann in den sp�teren Kapiteln

% Analyse des offenen Regelkreises

allmargin(G_tf/s)       % Kennwerte f�r den offenen Kreis beim Frequenzkennlinienverfahren



A = [-1 2; 0 -2];
B = [0;1];
C = [1,0];
D = 0;

sysr = ss(A,B,C,D)

ctrb(A,B)  % Erreichbarkeitsmatrix
obsv(A,C) % Beobachtbarkeitsmatrix

gram(sysr,'c') % Gramsche Matrix (controllability gramian)
gram(sysr,'o') % Gramsche Matrix (observability gramian)

acker(A,B,[-10 -11]) % Polvorgabe 
place(A,B,[-10 -11]) % Polvorgabe

